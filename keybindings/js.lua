vim.api.nvim_create_autocmd({"BufEnter", "BufWinEnter"}, {
    pattern = { "*.js", "*.ts" },
    callback = function()
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

        vim.cmd('Neoformat')
    end
})
