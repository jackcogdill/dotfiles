-- toggle relative numbers based on focus
vim.api.nvim_create_autocmd({ 'BufEnter', 'FocusGained', 'InsertLeave' }, {
  pattern = '*',
  command = 'silent if &number == 1 | set relativenumber | endif',
})
vim.api.nvim_create_autocmd({ 'BufLeave', 'FocusLost', 'InsertEnter' }, {
  pattern = '*',
  command = 'silent set norelativenumber',
})

-- dynamic scroll limit
vim.api.nvim_create_autocmd({ 'VimEnter', 'WinEnter' }, {
  pattern = '*',
  command = 'let &scrolloff = winheight(0) / 4',
})

-- reload buffers if changed outside of vim
vim.api.nvim_create_autocmd('FocusGained', { pattern = '*', command = 'checktime' })
