------------------------------------------------------------------
--- basic editor configurtion such as indent, tab, appearance, etc.
--- everything that previously was in .vimrc
------------------------------------------------------------------

-- show line number
vim.opt.number = true;
-- show relative line number
vim.opt.relativenumber = true;

-- tab size
vim.opt.tabstop = 4;
vim.opt.shiftwidth = 4;
-- use spaces instead of tabs
vim.opt.expandtab = true;

vim.opt.incsearch = true;

vim.opt.showmode = true;

vim.opt.hlsearch = true;

-- history size
vim.opt.history = 256;

-- build-in syntax highlight
vim.opt.syntax = "on";

-- highlight current line
vim.opt.cursorline = true;

vim.opt.wildmenu = true;
vim.opt.wildmode = "list:longest";

-- what characters to use for split bars
vim.opt.fillchars = {
    vert = "┃",
    horiz = "⎯",
    fold = "·",
};

vim.highlight.WinSeparator = { fg = "#171717" };
vim.highlight.VertSplit = { fg = "#ff5c8f" };

-- use 24-bit color
vim.opt.termguicolors = true

vim.opt.cmdheight = 0;
vim.opt.signcolumn = "yes";
vim.opt.updatetime = 300;

vim.opt.clipboard = "unnamed";

-- use space as <Leader>
vim.g.mapleader = ' '
