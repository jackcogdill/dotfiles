local ok, mod = pcall(require, 'local.mod.lualine')

-- status line
return {
  'nvim-lualine/lualine.nvim',
  lazy = false,
  opts = vim.tbl_deep_extend('keep', ok and mod.opts or {}, {
    options = {
      icons_enabled = false,
      component_separators = '|',
      section_separators = '',
      color = {
        gui = '', -- no bold or italics
      },
    },
    sections = {
      lualine_a = {
        {
          'mode',
          fmt = function(s)
            return s:sub(1, 3) -- limit to 3 characters
          end,
        },
      },
      lualine_b = { 'filename' },
      lualine_c = { 'branch' },
      lualine_x = { 'filetype' },
      lualine_y = { 'progress' },
      lualine_z = { 'location' },
    },
    inactive_sections = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = { 'filename' },
      lualine_x = { 'location' },
      lualine_y = {},
      lualine_z = {},
    },
    tabline = {
      lualine_a = {
        {
          'tabs',
          max_length = function()
            return vim.o.columns
          end,
          mode = 1, -- tab_name
          tabs_color = {
            active = 'lualine_b_normal',
            inactive = 'lualine_c_normal',
          },
          component_separators = { left = '', right = '' },
        },
      },
      lualine_b = {},
      lualine_c = {},
      lualine_x = {},
      lualine_y = {},
      lualine_z = {},
    },
  }),
}
