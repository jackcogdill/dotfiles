local ok, mod = pcall(require, 'local.mod.vim-signify')

-- signs for changes tracked by a version control system
return {
  'mhinz/vim-signify',
  event = 'BufReadPre',
  config = function()
    vim.g.signify_skip = {
      vcs = {
        allow = { 'git' },
      },
    }
    vim.g.signify_update_on_focusgained = true
    if ok then
      mod.config()
    end
  end,
}
