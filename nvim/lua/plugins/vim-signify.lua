-- signs for changes tracked by a version control system
return {
  'mhinz/vim-signify',
  event = 'VeryLazy',
  config = function()
    vim.cmd([[
      let g:signify_skip = { 'vcs': { 'allow': ['git'] } }
      let g:signify_update_on_focusgained = 1
    ]])
    pcall(require, 'local.vim-signify')
  end,
}
