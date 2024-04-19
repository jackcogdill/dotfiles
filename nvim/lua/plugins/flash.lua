return {
  'folke/flash.nvim',
  event = 'VeryLazy',
  opts = {
    highlight = {
      groups = {
        label = 'DiffText',
      },
    },
    modes = {
      char = {
        keys = { 'f', 'F', 't', 'T', ';' },
      },
    },
  },
  keys = {
    {
      '<c-s>',
      mode = { 'c' },
      function()
        require('flash').toggle()
      end,
      desc = 'Toggle Flash Search',
    },
  },
}
