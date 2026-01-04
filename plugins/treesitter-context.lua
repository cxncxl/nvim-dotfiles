require("treesitter-context").setup({
    enable = true,
    max_lines = 3,
})
vim.api.nvim_set_hl(0, "TreesitterContext", { bg = "#2c2c2f" })
