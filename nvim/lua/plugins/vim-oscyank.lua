-- copy to system clipboard including over remote ssh
return {
  'ojroques/vim-oscyank',
  keys = {
    { '<leader>c', '<Plug>OSCYankOperator', remap = true },
    { '<leader>cc', '<Leader>c_' },
    { '<leader>c', '<Plug>OSCYankVisual', mode = 'v' },
  },
  config = function()
    vim.g.oscyank_term = 'default'
  end,
}
