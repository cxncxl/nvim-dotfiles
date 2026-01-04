vim.api.nvim_create_autocmd({"BufEnter", "BufWinEnter"}, {
    callback = function()
        vim.keymap.set("n", "<C-b>", ":NERDTreeToggle<CR>", { silent = true });
    end,
})
