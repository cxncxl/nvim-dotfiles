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
            config = function()
                require("nvim-treesitter.install").update({ with_sync = true });
                vim.cmd([[TSToggle highlight]]);
            end,
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

        { -- opencode integration
          "nickjvandyke/opencode.nvim",
          version = "*", -- Latest stable release
          dependencies = {
            {
              -- `snacks.nvim` integration is recommended, but optional
              ---@module "snacks" <- Loads `snacks.nvim` types for configuration intellisense
              "folke/snacks.nvim",
              optional = true,
              opts = {
                input = {}, -- Enhances `ask()`
                picker = { -- Enhances `select()`
                  actions = {
                    opencode_send = function(...) return require("opencode").snacks_picker_send(...) end,
                  },
                  win = {
                    input = {
                      keys = {
                        ["<a-a>"] = { "opencode_send", mode = { "n", "i" } },
                      },
                    },
                  },
                },
              },
            },
          },
          config = function()
            vim.o.autoread = true -- Required for `opts.events.reload`

            -- Recommended/example keymaps
            vim.keymap.set({ "n", "x" }, "<C-s>", function() require("opencode").ask("@this: ", { submit = true }) end, { desc = "Ask opencode…" })
            vim.keymap.set({ "n", "x" }, "<C-x>", function() require("opencode").select() end,                          { desc = "Execute opencode action…" })
            vim.keymap.set({ "n", "t" }, "<C-.>", function() require("opencode").toggle() end,                          { desc = "Toggle opencode" })

            vim.keymap.set({ "n", "x" }, "go",  function() return require("opencode").operator("@this ") end,        { desc = "Add range to opencode", expr = true })
            vim.keymap.set("n",          "goo", function() return require("opencode").operator("@this ") .. "_" end, { desc = "Add line to opencode", expr = true })

            vim.keymap.set("n", "<S-C-u>", function() require("opencode").command("session.half.page.up") end,   { desc = "Scroll opencode up" })
            vim.keymap.set("n", "<S-C-d>", function() require("opencode").command("session.half.page.down") end, { desc = "Scroll opencode down" })

            -- You may want these if you use the opinionated `<C-a>` and `<C-x>` keymaps above — otherwise consider `<leader>o…` (and remove terminal mode from the `toggle` keymap)
            vim.keymap.set("n", "+", "<C-a>", { desc = "Increment under cursor", noremap = true })
            vim.keymap.set("n", "-", "<C-x>", { desc = "Decrement under cursor", noremap = true })
          end,
        }
    },
    ui = {
        show_on_startup = false,
    },
    checker = { enabled = false },
});
