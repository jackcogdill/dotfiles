-- dynamic scroll limit
vim.api.nvim_create_autocmd({ 'VimEnter', 'WinEnter' }, {
  pattern = '*',
  command = 'let &scrolloff = winheight(0) / 4',
})

-- reload buffers if changed outside of vim
vim.api.nvim_create_autocmd(
  'FocusGained',
  { pattern = '*', command = 'checktime' }
)
