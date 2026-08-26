-----------------------------------------------------------
--- keybindings related to lsp and diagnostic functionality
-----------------------------------------------------------

vim.api.nvim_create_autocmd({"BufEnter", "BufWinEnter"}, {
    callback = function() 
        vim.keymap.set("n", "K", vim.lsp.buf.hover);
        vim.keymap.set("i", "<C-k>", vim.lsp.buf.signature_help);
        vim.keymap.set("n", "gd", vim.lsp.buf.definition);
        vim.keymap.set("n", "<Leader>a", vim.lsp.buf.code_action);

        vim.keymap.set("n", "<Leader>rn", vim.lsp.buf.rename);

        vim.keymap.set("n", "<Leader>rr", vim.lsp.buf.references);
        vim.keymap.set("n", "<Leader>rf", vim.lsp.buf.format);

        vim.keymap.set("n", "<Leader>e", function()
            vim.diagnostic.jump({ count = 1, float = false });
        end);
        vim.keymap.set("n", "<Leader>E", function() vim.diagnostic.jump({ count = -1 }) end);
    end
})
