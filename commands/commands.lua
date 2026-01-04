vim.api.nvim_create_user_command('SfdxDeployCurrent', '!sfdx force:source:deploy -p %:p', {})
vim.api.nvim_create_user_command('FormatJson', 'execute \'%!python -m json.tool\' | w', {})
