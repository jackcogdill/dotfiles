-- indentation guides
return {
  'lukas-reineke/indent-blankline.nvim',
  version = '*',
  event = 'VeryLazy',
  opts = {
    enabled = true,
    use_treesitter = true,
    max_indent_increase = 1,
    show_first_indent_level = false,
    show_trailing_blankline_indent = false,
    show_current_context = true,
    show_current_context_start = true,
  },
  config = function(_, opts)
    require('indent_blankline').setup(opts)
  end,
}
