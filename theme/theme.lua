-----------------------------------
--- theme and visuals configuration
-----------------------------------

vim.cmd([[
    hi DiagnosticError guibg=#E06C75 guifg=#2D323B
    hi DiagnosticWarn  guibg=#E5C07B guifg=#2D323B
    hi DiagnosticInfo  guibg=#81A1C1 guifg=#2D323B
    hi DiagnosticHint  guibg=#88C0D0 guifg=#2D323B
]])

vim.opt.background = "dark"
vim.cmd.colorscheme("kanagawa-dragon")

vim.opt.statuscolumn = "%s%=%T%l│%T";

-- disbale tildas at empty lines
vim.opt.fillchars = { eob = " "}

vim.opt.colorcolumn = "81";

-- status line
vim.g.macro_recording = '';
vim.api.nvim_create_autocmd("RecordingEnter", {
    callback = function()
        vim.g.macro_recording = 'MACRO'
    end,
    pattern = "*",
});
vim.api.nvim_create_autocmd("RecordingLeave", {
    callback = function()
        vim.g.macro_recording = '';
    end,
    pattern = "*",
});
require("lualine").setup({
    options = {
        theme = "auto",
        section_separators = { left = "", right = "" },
        component_separators = { left = "", right = "" },
    },
    sections = {
        lualine_a = {'mode'},
        lualine_b = {'diff'},
        lualine_c = {'%=', "'󰈔'", 'filename'},
        lualine_x = {'diagnostics'},
        lualine_y = {'vim.g.macro_recording'},
        lualine_z = {'location'},
    },
})
