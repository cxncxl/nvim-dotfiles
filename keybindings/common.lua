---------------------------------
--- editor shortcuts, global ones
---------------------------------

vim.api.nvim_create_autocmd({"BufEnter", "BufWinEnter"}, {
    callback = function()
        vim.keymap.set("i", "jj", "<Esc>")

        vim.keymap.set("n", "<C-h>", ":wincmd h<CR>", { silent = true });
        vim.keymap.set("n", "<C-j>", ":wincmd j<CR>", { silent = true });
        vim.keymap.set("n", "<C-k>", ":wincmd k<CR>", { silent = true });
        vim.keymap.set("n", "<C-l>", ":wincmd l<CR>", { silent = true });

        vim.keymap.set("n", "<C-S-up>", ":resize +5<CR>", { silent = true });
        vim.keymap.set("n", "<C-S-down>", ":resize -5<CR>", { silent = true });
        vim.keymap.set("n", "<C-S-left>", ":vertical resize -5<CR>", { silent = true });
        vim.keymap.set("n", "<C-S-right>", ":vertical resize +5<CR>", { silent = true });

        vim.keymap.set("n", "qq", ":q<CR>", { silent = true });
        vim.keymap.set("n", "ss", ":w<CR>", { silent = true });
        vim.keymap.set("n", "gg", ":nohl <CR> :let @/ = \"\"<CR>", { silent = true });

        vim.keymap.set("n", "vv", ":vsplit<CR>", { silent = true });

        vim.keymap.set("n", "<leader>1", "1gt");
        vim.keymap.set("n", "<leader>2", "2gt");
        vim.keymap.set("n", "<leader>3", "3gt");
        vim.keymap.set("n", "<leader>4", "4gt");
        vim.keymap.set("n", "<leader>5", "5gt");
        vim.keymap.set("n", "<leader>6", "6gt");
        vim.keymap.set("n", "<leader>7", "7gt");
        vim.keymap.set("n", "<leader>8", "8gt");
        vim.keymap.set("n", "<leader>9", "9gt");
        vim.keymap.set("n", "<leader>0", ":tablast<cr>");

        vim.keymap.set("n", "<Leader>O", "O<Esc>O", { silent = true });
        vim.keymap.set("n", "<Leader>o", "o<Esc>o", { silent = true });
    end
})
