-- copy to system clipboard including over remote ssh
return {
  'ojroques/vim-oscyank',
  keys = {
    { '<Leader>c', '<Plug>OSCYankOperator', remap = true },
    { '<Leader>cc', '<Leader>c_' },
    { '<Leader>c', '<Plug>OSCYankVisual', mode = 'v' },
  },
  config = function()
    vim.g.oscyank_term = 'default'
  end,
}
