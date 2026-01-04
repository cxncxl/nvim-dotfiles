vim.api.nvim_create_autocmd({"BufEnter", "BufWinEnter"}, {
    callback = function()
        vim.keymap.set("n", "ff", ":Telescope git_files<CR>", { silent = true });
        vim.keymap.set("n", "fa", ":Telescope find_files<CR>", { silent = true });
        vim.keymap.set("n", "fg", ":Telescope live_grep<CR>", { silent = true });
        vim.keymap.set("n", "<Leader>M", ":Telescope lsp_workspace_symbols<CR>", { silent = true })
        vim.keymap.set("n", "fm", function ()
            require("telescope.builtin").lsp_document_symbols({
                symbols = {
                    'function',
                    'method',
                    'class',
                    'type',
                },
            });
        end)
    end
});
