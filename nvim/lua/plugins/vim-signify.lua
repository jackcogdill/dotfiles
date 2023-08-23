-- signs for changes tracked by a version control system
return {
  'mhinz/vim-signify',
  event = 'BufReadPost',
  config = function()
    vim.g.signify_skip = {
      vcs = {
        allow = { 'git' },
      },
    }
    vim.g.signify_update_on_focusgained = true
    pcall(require, 'local.vim-signify')
  end,
}
