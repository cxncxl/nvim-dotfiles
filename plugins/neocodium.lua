require('neocodeium').setup({
    enabled = true,
})
vim.keymap.set("i", "<C-l>", require('neocodeium').accept)
vim.keymap.set("i", "<C-h>", require('neocodeium').clear)
vim.keymap.set("i", "<C-S-l>", require('neocodeium').accept_line)
