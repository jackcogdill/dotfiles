return {
  'folke/flash.nvim',
  event = 'VeryLazy',
  opts = {
    search = {
      mode = 'fuzzy',
    },
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
