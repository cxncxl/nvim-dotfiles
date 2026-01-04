---------------------------------------------------------------
-- treesitter fix
-- the problem it solves: syntax highlighting breaks sometimes
---------------------------------------------------------------

local tsparsers = require("nvim-treesitter.parsers")
vim.g._ts_force_sync_parsing = true
vim.api.nvim_create_autocmd({"TextChanged", "TextChangedI"}, {
    callback = function(args)
        if vim.bo[args.buf].buftype ~= '' then
            return
        end
        local ft = vim.bo[args.buf].filetype
        if not ft or ft == '' then
            return
        end

        if tsparsers.has_parser(tsparsers.ft_to_lang(ft)) then
            vim.treesitter.stop(args.buf)
            vim.treesitter.start(args.buf, ft)
        end
    end,
})
