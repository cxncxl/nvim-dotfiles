vim.api.nvim_create_autocmd({"BufEnter", "BufWinEnter"}, {
    pattern = "*.zig",
    callback = function()
        vim.api.nvim_set_keymap("n", "<F9>", ":!zig build run<CR>", {silent = false})
    end
})

vim.api.nvim_create_autocmd({"BufWritePre"}, {
    pattern = "*.zig",
    callback = function()
        local view = vim.fn.winsaveview()
        vim.cmd("%!zig fmt --stdin")
        if vim.v.shell_error > 0 then
            vim.cmd("undo")
        end
        vim.fn.winrestview(view)
    end
})
