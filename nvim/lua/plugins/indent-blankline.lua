-- indentation guides
return {
  'lukas-reineke/indent-blankline.nvim',
  version = '2', -- everforest does not support v3 yet
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
}
