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
        enabled = false,
      },
    },
  },
  keys = {
    {
      's',
      mode = { 'n', 'x', 'o' },
      function()
        require('flash').jump()
      end,
      desc = 'Flash',
    },
    {
      'S',
      mode = { 'n', 'o' },
      function()
        require('flash').treesitter()
      end,
      desc = 'Flash Treesitter',
    },
  },
}
