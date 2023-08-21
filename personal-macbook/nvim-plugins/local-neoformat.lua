-- formatting
return {
  'sbdchd/neoformat',
  event = 'BufWritePre',
  config = function()
    vim.cmd([[
      let g:neoformat_python_yapf = {
            \ 'exe': 'yapf',
            \ 'args': ["--style='{based_on_style: google, indent_width: 2}'"],
            \ }
      let g:neoformat_typescript_prettier = {
            \ 'exe': 'prettier',
            \ 'args': ['--parser typescript --single-quote'],
            \ }
    ]])
    vim.g.neoformat_enabled_lua = { 'stylua' }
    vim.api.nvim_create_autocmd('BufWritePre', {
      pattern = '*',
      command = 'Neoformat',
    })
  end,
}
