-- remove search highlighting and clear command line
vim.keymap.set('n', '<Esc>', function()
  vim.cmd.nohlsearch()
  vim.cmd.echo()
end, { silent = true })
-- search selected text
vim.keymap.set('v', '//', 'y/<C-R>"<CR>', {})
-- redo macro
vim.keymap.set('n', '<Space>', '@q', {})
-- redo macro on selected lines
vim.keymap.set('v', '<Space>', ':normal @q<CR>', {})
-- redo last change on selected lines
vim.keymap.set('v', '.', ':normal .<CR>', {})
-- exit terminal mode
vim.keymap.set('t', '<Leader><Esc>', [[<C-\><C-n>]], {})
-- spell check
vim.keymap.set('n', '<Leader>s', ':setlocal spell! spelllang=en_us<CR>', {})
-- sort selected lines
vim.keymap.set('v', '<C-s>', ':sort<CR>', {})
-- make C-C trigger InsertLeave
vim.keymap.set('i', '<C-C>', '<Esc>', {})
-- toggle line wrapping ruler (colorcolumn)
vim.keymap.set(
  'n',
  '<Leader><Leader>',
  ":let &cc = &cc == '' ? '+1' : ''<CR>",
  { silent = true }
)
-- toggle diffs
vim.keymap.set(
  'n',
  '<M-d>',
  ":exe &diff == 0 ? 'windo diffthis' : 'diffoff!'<CR>",
  { silent = true }
)
-- lazy.nvim
vim.keymap.set('n', '<Leader>z', ':Lazy<CR>', { silent = true })

-- navigate tabs
vim.keymap.set('n', 'H', ':silent :tabp<CR>', { silent = true })
vim.keymap.set('n', 'L', ':silent :tabn<CR>', { silent = true })
vim.keymap.set('n', '<A-h>', ':silent :tabm -1<CR>', { silent = true })
vim.keymap.set('n', '<A-l>', ':silent :tabm +1<CR>', { silent = true })
vim.keymap.set('n', '<Leader>1', '1gt', {})
vim.keymap.set('n', '<Leader>2', '2gt', {})
vim.keymap.set('n', '<Leader>3', '3gt', {})
vim.keymap.set('n', '<Leader>4', '4gt', {})
vim.keymap.set('n', '<Leader>5', '5gt', {})
vim.keymap.set('n', '<Leader>6', '6gt', {})
vim.keymap.set('n', '<Leader>7', '7gt', {})
vim.keymap.set('n', '<Leader>8', '8gt', {})
vim.keymap.set('n', '<Leader>9', ':tablast<CR>', { silent = true })
vim.keymap.set('n', '<C-T><C-O>', ':tabonly<CR>', { silent = true })
vim.keymap.set('n', '<C-M>', ':tabnew<CR>', { silent = true })

-- navigate buffers
vim.keymap.set('n', '<Leader>[', ':silent :bp<CR>', { silent = true })
vim.keymap.set('n', '<Leader>]', ':silent :bn<CR>', { silent = true })

-- copy/paste/delete to system clipboard
vim.keymap.set('', '<Leader>y', '"*y', {})
vim.keymap.set('', '<Leader>p', '"*p', {})
vim.keymap.set('', '<Leader>P', '"*P', {})

-- explore files
vim.keymap.set('n', '<Leader>e', ':Explore<CR>', {})

-- copy filepath
vim.keymap.set('n', '<Leader>G', function()
  vim.fn.setreg('', vim.fn.bufname())
end, {})
