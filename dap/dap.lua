local dap = require("dap")

dap.configurations.javascript = {
  {
    type = "pwa-node",
    request = "attach",
    name = "Attach to Bun",
    port = 9229,
    cwd = vim.fn.getcwd(),
    sourceMaps = true,
    skipFiles = { "<node_internals>/**/*.js" },
  },
}

dap.configurations.typescript = dap.configurations.javascript

require("dap-vscode-js").setup({
  adapters = { 'pwa-node', 'pwa-chrome', 'pwa-msedge', 'node-terminal', 'pwa-extensionHost' }, -- which adapters to register in nvim-dap
})
