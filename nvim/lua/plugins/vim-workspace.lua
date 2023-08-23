return {
  'thaerkh/vim-workspace',
  lazy = false,
  keys = {
    {
      '<Leader>w',
      function()
        vim.cmd.ToggleWorkspace()
      end,
    },
  },
  config = function()
    vim.g.workspace_autocreate = 1
    vim.g.workspace_session_directory = vim.fn.stdpath('data') .. '/sessions'
    vim.g.workspace_autosave = 0
    vim.g.workspace_session_disable_on_args = 1 -- mostly because `hg commit` creates a workspace flooded with tmp files
  end,
}
