local config_path = vim.fn.stdpath("config") .. "/?.lua"
local config_subpath = vim.fn.stdpath("config") .. "/?/init.lua"
package.path = package.path .. ";" .. config_path .. ";" .. config_subpath

-- editor configuration
require("editor/editor");

-- loads third-party plugins
require("plugins/main");
require("plugins/linters");
require("plugins/nerd-tree");
require("plugins/neocodium");
require("plugins/treesitter-context");
require("plugins/noice");
require("plugins/treesitter");
-- require("plugins/dap")

-- lsp
require('lsp/lsp');

-- keybindings
require('keybindings/common');
require('keybindings/lsp');
require('keybindings/telescope');
require('keybindings/go');
require('keybindings/dart');
require('keybindings/zig');
require('keybindings/js');

-- snippets
require("snippets/go");
require("snippets/html");

-- language-specific configs
require('settings/markdown');
require('settings/json');
-- common editor settings
require('settings/main');

-- commands
require('commands/commands');

-- appearance
require("theme/theme");
