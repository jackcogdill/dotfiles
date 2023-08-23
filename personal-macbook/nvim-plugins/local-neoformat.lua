-- formatting
return {
  'sbdchd/neoformat',
  event = 'VeryLazy',
  config = function()
    vim.g.neoformat_python_yapf = {
      exe = 'yapf',
      args = { "--style='{based_on_style: google, indent_width: 2}'" },
    }
    vim.g.neoformat_typescript_prettier = {
      exe = 'prettier',
      args = { '--parser typescript', '--single-quote' },
    }
    vim.g.neoformat_javascript_prettier = {
      exe = 'prettier',
      args = { '--parser javascript', '--single-quote' },
    }
    vim.g.neoformat_lua_stylua = {
      exe = 'stylua',
      args = {
        '--call-parentheses Always',
        '--indent-type Spaces',
        '--quote-style AutoPreferSingle',
        '--indent-width 2',
        '--column-width 80',
      },
      replace = true,
    }
    vim.api.nvim_create_autocmd('BufWritePre', {
      pattern = '*',
      command = 'Neoformat',
    })
  end,
}
