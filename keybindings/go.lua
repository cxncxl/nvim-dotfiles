vim.api.nvim_create_autocmd({"BufEnter", "BufWinEnter"}, {
    pattern = "*.go",
    callback = function()
        vim.api.nvim_set_keymap("n", "<F8>", ":!make build <CR>", {silent = false})
        vim.api.nvim_set_keymap("n", "<F9>", ":!make run <CR>", {silent = false})
    end
})

vim.api.nvim_create_autocmd({"BufWritePre"}, {
    pattern = "*.go",
    callback = function()
        local view = vim.fn.winsaveview()
        vim.cmd("%!gofmt")
        if vim.v.shell_error > 0 then
            vim.cmd("undo")
        end
        vim.fn.winrestview(view)
    end
})
