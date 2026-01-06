local function log_variable()
    local var_name = vim.fn.expand("<cword>")
    if var_name == "" then return end

    local node = vim.treesitter.get_node()
    if not node then return end

    -- Find the containing statement node
    local curr = node
    while curr do
        local type = curr:type()
        if type:find("statement") or type:find("declaration") then
            break
        end
        local parent = curr:parent()
        if not parent then break end
        curr = parent
    end

    local _, _, end_line, _ = curr:range()
    local start_line, _, _, _ = curr:range()
    local indentation = vim.fn.indent(start_line + 1)
    local padding = string.rep(" ", indentation)
    local log_line = string.format('console.log("%s ->", %s);', var_name, var_name)

    vim.api.nvim_buf_set_lines(0, end_line + 1, end_line + 1, false, { padding .. log_line })
end

local function toggle_comment()
    local esc = vim.api.nvim_replace_termcodes("<ESC>", true, false, true)
    vim.api.nvim_feedkeys(esc, "x", false)

    vim.schedule(function()
        local start_line = vim.fn.line("'<") - 1
        local end_line = vim.fn.line("'>") - 1

        if start_line < 0 then return end

        local lines = vim.api.nvim_buf_get_lines(0, start_line, end_line + 1, false)
        if #lines == 0 then return end

        local is_commented = lines[1]:match("^%s*//")
        local new_lines = {}

        for _, line in ipairs(lines) do
            if is_commented then
                table.insert(new_lines, (line:gsub("^(%s*)//%s?", "%1")))
            else
                table.insert(new_lines, (line:gsub("^(%s*)", "%1// ")))
            end
        end

        vim.api.nvim_buf_set_lines(0, start_line, end_line + 1, false, new_lines)
    end)
end

vim.api.nvim_create_autocmd({"BufEnter", "BufWinEnter"}, {
    pattern = { "*.js", "*.ts" },
    callback = function()
        vim.keymap.set("n", "<leader>l", log_variable, { silent = true, buffer = true, desc = "Log variable under cursor" })
        vim.keymap.set("v", "<leader>/", toggle_comment, { silent = true, buffer = true, desc = "Toggle comments" })

        vim.keymap.set("n", "<F6>", function()
            require'dap'.run({
                type = 'node2',
                request = 'attach',
                cwd = vim.fn.getcwd(),
                sourceMaps = true,
                protocol = 'inspector',
                skipFiles = {'<node_internals>/**/*.js'},
            })
        end, { silent = true, buffer = true })

        vim.keymap.set('n', '<F9>', ':!npm run build', { silent = false })

        vim.api.nvim_create_user_command('FormatQuotes', '%s/"/\'/g <CR> nohl <CR> :let @/ = "" <CR>', {})
    end
})
