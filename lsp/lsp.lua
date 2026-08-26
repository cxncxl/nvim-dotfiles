local cmp = require('cmp');
local luasnip = require('luasnip');

cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-u>'] = cmp.mapping.scroll_docs(-4), -- Up
    ['<C-d>'] = cmp.mapping.scroll_docs(4), -- Down
    -- C-b (back) C-f (forward) for snippet placeholder navigation.
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ["<C-n>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            else
                fallback()
            end
        end, { 'i', 's' }),
    ["<Tab>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "s" }),
    ["<C-S-n>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "s" }),
  }),
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  },
});

vim.lsp.enable("zls");
vim.lsp.enable("gopls");
vim.lsp.enable("sourcekit");

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

vim.lsp.enable("gdscript");

-- Godot shader support
vim.lsp.config("gdshader_lsp", {
    name = "gdshader_lsp",
    cmd = { "gdshader-lsp" },
    filetypes = { "gdshader", "gdshaderinc" },
});
vim.lsp.enable("gdshader_lsp");

vim.lsp.enable("prismals");
-- vim.lsp.enable('ts_ls');
vim.lsp.enable('tsgo');

-- if does not work with Unity - make sure to generate project files (.sln(x))
vim.lsp.enable('roslyn');

cmp.setup.filetype({ 'sql' }, {
    sources = {
        { name = 'vim-dadbod-completion' },
        { name = 'buffer' },
    },
});

-- vim.lsp.config("elixir_ls", {
--     cmd = { "/users/r1sha/.lsp/elixir/language_server.sh" },
-- });
-- vim.lsp.enable("elixir_ls");

vim.lsp.enable("r_language_server");
