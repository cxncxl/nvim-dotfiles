-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

vim.g.maplocalleader = "\\";

require('lazy').setup({
    spec = {
        "nvim-lua/plenary.nvim", -- lua helpers
        {
            "nvim-treesitter/nvim-treesitter",
            tag = "v0.10.0",
            build = ":TSUpdate",
            lazy = false,
            priority = 1000,
            opts = {
                ensure_installed = {
                    "graphql", "typescript", "eex", "elixir",
                    "erlang", "heex", "html", "surface",
                },
                matchup = { enable = true },
                indent = { enable = true },
                highlight = {
                    enable = true,
                    additional_vim_regex_highlighting = false,
                },
            },
        },
        {
            "folke/noice.nvim", -- better command line
            dependencies = {
                "MunifTanjim/nui.nvim",
            }
        },
        {
            'nvim-telescope/telescope.nvim',
            dependencies = {
                'nvim-lua/plenary.nvim',
                -- optional but recommended
                { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
            },
        },

        'neovim/nvim-lspconfig', -- Collection of configurations for built-in LSP client
        'hrsh7th/nvim-cmp', -- Autocompletion plugin
        'hrsh7th/cmp-nvim-lsp', -- LSP source for nvim-cmp
        'saadparwaiz1/cmp_luasnip', -- Snippets source for nvim-cmp
        'L3MON4D3/LuaSnip', -- Snippets plugin
        'ibhagwan/fzf-lua', -- fuzzy-finder
        'dense-analysis/ale', -- js prettier / linter

        'nvim-treesitter/nvim-treesitter-context', -- shows function/class name at the top

        -- themes
        'frenzyexists/aquarium-vim',
        'kvrohit/substrata.nvim',
        "rebelot/kanagawa.nvim",
        'mellow-theme/mellow.nvim',
        'datsfilipe/vesper.nvim',
        'hrsh7th/nvim-compe',
        'onsails/lspkind-nvim',
        "kvrohit/rasmus.nvim",
        "kyazdani42/blue-moon",
        "mcchrish/zenbones.nvim",
        "sponkurtus2/angelic.nvim",

        { dir = '/users/r1sha/Projects/petprojects/nvim-todo' },
        { dir = '/users/r1sha/Projects/petprojects/nvim-f2' },

        'tpope/vim-dadbod', -- sql
        'kristijanhusak/vim-dadbod-completion', -- sql
        'kristijanhusak/vim-dadbod-ui', -- sql

        "preservim/nerdtree", -- file explorer
        "ryanoasis/vim-devicons", -- icons
        {
            "Yggdroot/indentLine", -- identation lines
            config = function()
                vim.g.indentLine_char = '⎸';
            end
        },

        -- ai
        {
            "monkoose/neocodeium",
        },
        {
            "ThePrimeagen/99",
            config = function()
                local _99 = require("99")

                -- For logging that is to a file if you wish to trace through requests
                -- for reporting bugs, i would not rely on this, but instead the provided
                -- logging mechanisms within 99.  This is for more debugging purposes
                local cwd = vim.uv.cwd()
                local basename = vim.fs.basename(cwd)
                _99.setup({
                    logger = {
                        level = _99.DEBUG,
                        path = "/tmp/" .. basename .. ".99.debug",
                        print_on_error = true,
                    },

                    md_files = {
                        "AGENT.md",
                    },
                })

                vim.keymap.set("n", "<leader>9f", function()
                    _99.fill_in_function()
                end)
                vim.keymap.set("v", "<leader>9v", function()
                    _99.visual()
                end)
                vim.keymap.set("v", "<leader>9s", function()
                    _99.stop_all_requests()
                end)
            end,
        },

        -- autoclose
        {
            "windwp/nvim-autopairs",
            event = "InsertEnter",
            config = function()
                require("nvim-autopairs").setup {}
            end
        },

        -- show git status in statuscol
        "lewis6991/gitsigns.nvim",

        { -- custom statusline
            'nvim-lualine/lualine.nvim',
            dependencies = { 'nvim-tree/nvim-web-devicons' }
        },
    },
    ui = {
        show_on_startup = false,
    },
    checker = { enabled = false },
});
