-- signs for changes tracked by a version control system
return {
  'mhinz/vim-signify',
  event = 'VeryLazy',
  config = function()
    vim.g.signify_skip = {
      vcs = {
        allow = { 'git' },
      },
    }
    vim.g.signify_update_on_focusgained = true
    pcall(require, 'local.vim-signify')
    vim.cmd.SignifyEnable()
  end,
}
