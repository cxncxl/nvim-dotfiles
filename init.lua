vim.g.mapleader = ' '

local config_path = vim.fn.stdpath("config") .. "/?.lua"
local config_subpath = vim.fn.stdpath("config") .. "/?/init.lua"
package.path = package.path .. ";" .. config_path .. ";" .. config_subpath

vim.cmd([[
    set runtimepath^=~/.vim runtimepath+=~/.vim/after
    let &packpath = &runtimepath
    source ~/.vimrc
]])

vim.cmd([[
    packadd packer.nvim
]])

vim.cmd([[
    hi DiagnosticError guibg=#E06C75 guifg=#2D323B
    hi DiagnosticWarn guibg=#E5C07B guifg=#2D323B
    hi DiagnosticInfo guibg=#81A1C1 guifg=#2D323B
    hi DiagnosticHint guibg=#88C0D0 guifg=#2D323B
]])

vim.opt.foldmethod = "expr"
-- vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldcolumn = "0"
vim.opt.foldtext = ""
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 1
vim.opt.foldnestmax = 4
vim.opt.conceallevel = 0 -- don't hide quotes in json files

vim.keymap.set('c', '<tab>', '<C-z>', { silent = false })

vim.cmd[[
    augroup disableIndentlineDb
      autocmd!
      au FileType alpha let b:indentLine_enabled = 0
    augroup END
]]

-- treesitter fix
-- the problem it solves: syntax highlighting breaks sometimes
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

require("noice").setup({}); -- better commandline

require('lsp/lsp')

require("snippets/go");
require("snippets/html");

require('keybindings/go')
require('keybindings/dart')
require('keybindings/zig')
require('keybindings/common')

require('settings/markdown')
require('settings/json')

require('commands/commands')

require('workspaces').setup()

require("outline").setup({}) -- code navigation plugin

-- require('typespeed').setup()

vim.g.ale_linters_explicit = 1
vim.g.ale_fixers = {
  javascript = {'prettier', 'eslint'},
  typescript = {'prettier', 'eslint'},
  css = {'prettier'},
}
vim.g.ale_fixers = {
  javascript = {'prettier', 'eslint'},
  typescript = {'prettier', 'eslint'},
  css = {'prettier'},
}
vim.g.ale_fix_on_save = 1

require("treesitter-context").setup({
    enable = true,
    max_lines = 3,
})
vim.api.nvim_set_hl(0, "TreesitterContext", { bg = "#2c2c2f" })

-- ai
require('neocodeium').setup({
    enabled = true,
})
vim.keymap.set("i", "<C-l>", require('neocodeium').accept)
vim.keymap.set("i", "<C-h>", require('neocodeium').clear)
vim.keymap.set("i", "<C-S-l>", require('neocodeium').accept_line)

return require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'

    use 'neovim/nvim-lspconfig' -- Collection of configurations for built-in LSP client
    use 'hrsh7th/nvim-cmp' -- Autocompletion plugin
    use 'hrsh7th/cmp-nvim-lsp' -- LSP source for nvim-cmp
    use 'saadparwaiz1/cmp_luasnip' -- Snippets source for nvim-cmp
    use 'L3MON4D3/LuaSnip' -- Snippets plugin
    use 'ibhagwan/fzf-lua'
    use 'fxn/vim-monochrome'
    use 'ewilazarus/preto'
    use 'dense-analysis/ale' -- js prettier / linter
    use 'metalelf0/base16-black-metal-scheme'

    use 'nvim-treesitter/nvim-treesitter-context'

    -- code dimming
    use {
        'folke/twilight.nvim',
        config = function()
            require("twilight").setup {
                dimming = {
                    alpha = 0.35,
                },
                context = 20,
                treesitter = true,
                expand = {
                    "function",
                    "method",
                },
            }
        end
    }

    -- themes
    use 'frenzyexists/aquarium-vim'
    use 'kvrohit/substrata.nvim'
    use "rebelot/kanagawa.nvim"
    use 'mellow-theme/mellow.nvim'

    use 'hrsh7th/nvim-compe'
    use 'onsails/lspkind-nvim'
    use {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
    }
    use "kvrohit/rasmus.nvim"
    use "kyazdani42/blue-moon"

    use '/users/r1sha/Projects/petprojects/nvim-todo'
    use '/users/r1sha/Projects/petprojects/nvim-f2'
    -- use '/users/r1sha/Projects/petprojects/neovim-typespeed'

    use 'natecraddock/workspaces.nvim'

    use 'tpope/vim-dadbod' -- sql
    use 'kristijanhusak/vim-dadbod-completion' -- sql
    use 'kristijanhusak/vim-dadbod-ui' -- sql

    use 'hedyhli/outline.nvim' -- code navigation

    -- csv
    use "mechatroner/rainbow_csv"
    use "hat0uma/csvview.nvim"

    -- ai
    use {
        "monkoose/neocodeium",
    }

    -- autoclose
    use {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        config = function()
            require("nvim-autopairs").setup {}
        end
    }

    use {
        'nvim-telescope/telescope-project.nvim',
        requires = {
            'nvim-telescope/telescope.nvim',
        },
    }
    require'telescope'.load_extension('project')
end)
