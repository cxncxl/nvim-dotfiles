vim.g.ale_linters_explicit = 1
vim.g.ale_fixers = {
  javascript = {'prettier', 'eslint'},
  typescript = {'prettier', 'eslint'},
  typescriptreact = {'prettier', 'eslint'},
  javascruptreact = {'prettier', 'eslint'},
  css = {'prettier'},
  json = {'prettier'},
}
vim.g.ale_fix_on_save = 1

