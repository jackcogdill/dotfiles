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
        keys = { 'f', 'F', 't', 'T' },
      },
    },
  },
}
