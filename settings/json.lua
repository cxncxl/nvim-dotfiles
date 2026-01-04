vim.api.nvim_create_autocmd({"BufEnter", "BufWinEnter"}, {
    pattern = { '*.json' },
    callback = function ()
        vim.opt.conceallevel = 0
    end
})
