vim.api.nvim_create_autocmd({"BufEnter", "BufWinEnter"}, {
    callback = function()
        vim.keymap.set("n", "<F3>", function()
            require'dap'.toggle_breakpoint()
        end, { silent = true, buffer = true })

        vim.keymap.set("n", "<F5>", function()
            require'dap'.continue()
        end, { silent = true, buffer = true })

        vim.keymap.set("n", "<F4>", function()
            require'dap'.repl.open()
        end, { silent = true, buffer = true })

        vim.keymap.set("n", "<Leader>M", ":Telescope lsp_workspace_symbols<CR>", { silent = true })

        vim.keymap.set('n', '<Leader>a', vim.lsp.buf.code_action, { silent = true })

        vim.keymap.set('n', '<Leader>n', ':TSToggle highlight<CR>', { silent = false })

        local toggleOutline = function()
            local opened = vim.g.__ouline_active
            if opened == nil then
                opened = false
            end
            if opened then
                vim.cmd('OutlineClose')
            else
                vim.cmd('OutlineOpen')
            end
            vim.g.__ouline_active = not opened
        end

        vim.keymap.set('n', '<Leader>o', toggleOutline, { silent = false })

        vim.keymap.set('n', '<leader>f', ':Twilight<CR>', { silent = true })
    end
})
