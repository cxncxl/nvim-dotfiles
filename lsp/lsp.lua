local cmp = require 'cmp'
local luasnip = require 'luasnip'

cmp.setup()

vim.lsp.enable("zls")
vim.lsp.enable("gopls")
vim.lsp.enable("sourcekit")

vim.lsp.config("lua_ls", {
    settings = {
        Lua = {
            runtime = {
                version = 'LuaJIT',
            },
            diagnostics = {
                globals = { 'vim', 'require' },
            },
            workspace = {
                library = vim.api.nvim_get_runtime_file("", true),
            },
            telemetry = { enable = false },
        },
    },
});
vim.lsp.enable("lua_ls");

vim.lsp.enable("gdscript")

-- Godot shader support
vim.lsp.config("gdshader_lsp", {
    name = "gdshader_lsp",
    cmd = { "gdshader-lsp" },
    filetypes = { "gdshader", "gdshaderinc" },
})
vim.lsp.enable("gdshader_lsp")

vim.lsp.enable("prismals")
vim.lsp.enable('ts_ls')

cmp.setup.filetype({ 'sql' }, {
    sources = {
        { name = 'vim-dadbod-completion' },
        { name = 'buffer' },
    },
})

vim.lsp.config("elixir_ls", {
    cmd = { "/users/r1sha/.lsp/elixir/language_server.sh" },
});
vim.lsp.enable("elixir_ls");
