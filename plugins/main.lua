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
            build = ":TSUpdate",
            lazy = false,
            priority = 1000,
            config = function()
                require("nvim-treesitter").install({
                    "graphql", "typescript", "eex", "elixir",
                    "erlang", "heex", "html", "surface", "r",
                })
                vim.api.nvim_create_autocmd("FileType", {
                    callback = function(args)
                        pcall(vim.treesitter.start, args.buf)
                    end,
                })
            end,
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
        'tpope/vim-fugitive', -- git integration

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

        -- git diff viewer
        "sindrets/diffview.nvim",

        { dir = '/users/r1sha/Projects/petprojects/nvim-todo' },
        { dir = '/users/r1sha/Projects/petprojects/nvim-f2' },

        'tpope/vim-dadbod', -- sql
        'kristijanhusak/vim-dadbod-completion', -- sql
        'kristijanhusak/vim-dadbod-ui', -- sql

        "preservim/nerdtree", -- file explorer
        "ryanoasis/vim-devicons", -- icons

        { -- indentation lines
            "lukas-reineke/indent-blankline.nvim",
            config = function()
                local hooks = require("ibl.hooks")

                -- Function to calculate and apply the active theme color
                local function apply_scope_highlights()
                    local theme_hl = vim.api.nvim_get_hl(0, { name = "Keyword" })
                    local color_hex = (theme_hl and theme_hl.fg)
                        and string.format("#%06x", theme_hl.fg) or "#785f62"
                    vim.api.nvim_set_hl(0, "IblScopeVertical", {
                        fg = color_hex,
                        bg = "NONE"
                    })
                end

                -- 1. Run it inside the hook for IBL's internal rendering cycles
                hooks.register(hooks.type.HIGHLIGHT_SETUP, apply_scope_highlights)

                -- 2. Run it inside an Autocommand to intercept your colorscheme whenever it loads
                vim.api.nvim_create_autocmd("ColorScheme", {
                    pattern = "*",
                    callback = apply_scope_highlights,
                })

                require("ibl").setup({
                    indent = {
                        char = "⎸",
                        highlight = { "LineNr" }
                    },
                    scope = {
                        highlight = { "IblScopeVertical" },
                        show_start = true,
                        show_end = true,
                    }
                })
            end
        },

        { -- diagnostics rendered beatifully
            "Maan2003/lsp_lines.nvim",
            config = function()
                require("lsp_lines").setup()
                vim.diagnostic.config({
                    virtual_text = false,
                })
                vim.diagnostic.config({ virtual_lines = true })
            end,
        },

        -- ai
        {
            "monkoose/neocodeium",
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

        { -- c# lsp
            'seblyng/roslyn.nvim'
        },

        { -- send code to REPL
            "jpalardy/vim-slime",
            keys = {
                { "<leader>rc", "<cmd>SlimeConfig<cr>",               desc = "Slime Config" },
                { "<leader>rs", "<Plug>SlimeSendCell<BAR>/^# %%<CR>", desc = "Slime Send Cell" },
            },
            config = function()
                vim.g.slime_target = "tmux"
                vim.g.slime_cell_delimiter = "# %%"
                vim.g.slime_bracketed_paste = 1
            end,
        },

        { -- R bundle
            "R-nvim/R.nvim"
        }
    },
    ui = {
        show_on_startup = false,
    },
    checker = { enabled = false },
});
