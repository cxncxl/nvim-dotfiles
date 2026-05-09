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
                    'interface',
                    'enum',
                    'constant',
                    'variable',
                },
            });
        end)
    end
});

require("telescope").setup({
    defaults = {
        attach_mappings = function(buf_nr, map)
            map("i", "<C-i>", function ()
                local actions_state = require("telescope.actions.state")
                local picker = actions_state.get_current_picker(buf_nr)
                picker:set_prompt(":interface:")
            end)
        end
    }
})
