local cmp = require 'cmp'
local luasnip = require 'luasnip'
cmp.setup {
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
}

cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = 'buffer' }
    }
})

require'nvim-treesitter.configs'.setup {
    ensure_installed = {
        "graphql",
        "typescript",
        "eex",
        "elixir",
        "erlang",
        "heex",
        "html",
        "surface",
    },
    matchup = {
        enable = true,
    },
    indent = { enable = true },
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },
}

local lspconfig = require('lspconfig')

lspconfig.dartls.setup({})
lspconfig.clangd.setup({})
lspconfig.zls.setup({})
lspconfig.apex_ls.setup({
    -- apex_jar_path = '/Users/r1sha/Projects/apex-jorje-lsp.jar',
    cmd = {
        vim.env.JAVA_HOME and (vim.env.JAVA_HOME) or 'java',
        '-jar',
        '/Users/r1sha/Projects/apex-jorje-lsp.jar',
        '-Ddebug.internal.errors=true',
        '-Dlwc.typegeneration.disabled=true'
    },
    filetypes = { 'st', 'apexcode' },
    apex_enable_semantic_errors = false, -- Whether to allow Apex Language Server to surface semantic errors
    apex_enable_completion_statistics = false, -- Whether to allow Apex Language Server to collect telemetry on code completion usage
})
lspconfig.gopls.setup({})
lspconfig.sourcekit.setup({})
lspconfig.lua_ls.setup({})
lspconfig.java_language_server.setup{
    cmd = {
        '/users/r1sha/.config/java-language-server/dist/lang_server_mac.sh',
    },
}
lspconfig.gdscript.setup({})
lspconfig.gdshader.setup({})
lspconfig.prismals.setup({})
-- vim.lsp.enable('angularls')

-- local capabilities = vim.lsp.protocol.make_client_capabilities()
-- capabilities.textDocument.completion.completionItem.snippetSupport = true
-- 
-- vim.lsp.config('html', {
--   capabilities = capabilities,
-- })
-- vim.lsp.enable('html')

local updatedCaps = require('cmp_nvim_lsp')
                    .default_capabilities(
                        vim.lsp.protocol.make_client_capabilities()
                    )

-- lspconfig.ts_ls.setup({
--     capabilities = updatedCaps,
--     root_dir = require("lspconfig.util").root_pattern("tsconfig.worker.json", "tsconfig.json", ".git"),
--     on_new_config = function(new_config, new_root_dir)
--         if not new_config.cmd then
--             new_config.cmd = { "typescript-language-server", "--stdio" }
--         end
-- 
--         new_config.init_options = new_config.init_options or {}
--         new_config.init_options.tsserver = new_config.init_options.tsserver or {}
--         new_config.init_options.tsserver.maxTsServerMemory = 8192
--     end
-- })

-- i don't use deno
lspconfig.denols.setup({
    autostart = false,
})

vim.lsp.enable('ts_ls')
-- vim.lsp.config("tsgo", {
--     filetypes = {
--         "javascript",
--         "javascriptreact",
--         "javascript.jsx",
--         "typescript",
--         "typescriptreact",
--         "typescript.tsx",
--     },
--     root_markers = { "tsconfig.json", "jsconfig.json", "package.json", ".git" },
-- })
-- vim.lsp.enable("tsgo")

-- require('lspconfig').graphql.setup{
--   cmd = { "graphql-lsp", "server", "-m", "stream" },
--   filetypes = { "graphql", "gql", "typescript", "javascript" },
--   root_dir = require('lspconfig.util').root_pattern('.graphqlrc*', '.git'),
-- }

cmp.setup.filetype({ 'sql' }, {
    sources = {
        { name = 'vim-dadbod-completion' },
        { name = 'buffer' },
    },
})

lspconfig.elixirls.setup({
    cmd = { "/users/r1sha/.lsp/elixir/language_server.sh" },
})
