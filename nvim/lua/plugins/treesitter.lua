-- incremental syntax parsing
return {
  'nvim-treesitter/nvim-treesitter',
  version = '*',
  build = ':TSUpdate',
  event = 'BufReadPost',
  opts = {
    ensure_installed = 'all',
    ignore_install = { 'phpdoc' },
    highlight = {
      enable = true, -- false will disable the whole extension
      disable = { 'html', 'proto' }, -- list of language that will be disabled
    },
  },
  config = function(_, opts)
    require('nvim-treesitter.configs').setup(opts)

    -- compatibility with rainbow-parentheses
    vim.api.nvim_create_autocmd('BufEnter', {
      pattern = '*',
      command = 'highlight clear TSPunctBracket',
    })
  end,
}
