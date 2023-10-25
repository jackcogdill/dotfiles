-- indentation guides
return {
  'lukas-reineke/indent-blankline.nvim',
  version = '*',
  event = 'VeryLazy',
  main = 'ibl',
  opts = {
    indent = {
      char = '│',
    },
    scope = {
      show_start = false,
      show_end = false,
    },
  },
}
