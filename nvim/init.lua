require('options')
require('autocmds')
require('keybinds')

-- try loading local configs
pcall(require, 'local.autocmds')
pcall(require, 'local.keybinds')

-- bootstrap lazy.nvim
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  spec = {
    import = 'plugins',
  },
  install = {
    colorscheme = { 'everforest' },
  },
  ui = {
    border = 'rounded',
    title = ' Lazy ',
  },
})
