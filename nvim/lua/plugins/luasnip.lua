-- snippets
return {
  'L3MON4D3/LuaSnip',
  version = '*',
  dependencies = { 'rafamadriz/friendly-snippets' },
  keys = {
    {
      '<C-j>',
      function()
        require('luasnip').jump(1)
      end,
      mode = { 'i', 's' },
      silent = true,
    },
    {
      '<C-k>',
      function()
        require('luasnip').jump(-1)
      end,
      mode = { 'i', 's' },
      silent = true,
    },
  },
  config = function()
    require('luasnip.loaders.from_vscode').lazy_load()
  end,
}
