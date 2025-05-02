-- colorscheme
return {
  'sainnhe/everforest',
  lazy = false,
  priority = 1000,
  config = function()
    vim.g.everforest_background = 'soft'
    vim.g.everforest_enable_italic = 1
    vim.g.everforest_sign_column_background = 'none'
    vim.g.everforest_float_style = 'dim'
    vim.cmd.colorscheme('everforest')
  end,
}
