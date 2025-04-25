-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    '--branch=stable',
    lazyrepo,
    lazypath,
  })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { 'Failed to clone lazy.nvim:\n', 'ErrorMsg' },
      { out, 'WarningMsg' },
      { '\nPress any key to exit...' },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Set options
require('config.options')
require('config.autocmds')
require('config.keybinds')

-- Try loading local configs
pcall(require, 'local.autocmds')
pcall(require, 'local.keybinds')

-- Setup lazy.nvim
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
  checker = {
    enabled = true, -- check for plugin updates
  },
})
