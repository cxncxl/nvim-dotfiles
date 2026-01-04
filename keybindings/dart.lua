vim.api.nvim_create_autocmd({"BufEnter", "BufWinEnter"}, {
    pattern = "*.dart",
    callback = function()
        vim.api.nvim_set_keymap("n", "<F9>", ":!flutter run --dart-define=useIntegrationServices=true <CR>", {silent = false})
    end
})
