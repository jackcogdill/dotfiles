-- autocomplete for parentheses, quotes, etc.
return {
  'jiangmiao/auto-pairs',
  event = 'VeryLazy',
  config = function()
    vim.g.AutoPairsCenterLine = 0
    vim.g.AutoPairsShortcutFastWrap = '<M-w>'
  end,
}
