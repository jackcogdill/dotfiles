-- color nested parentheses
return {
  'luochen1990/rainbow',
  event = 'BufReadPost',
  config = function()
    vim.api.nvim_create_autocmd('BufEnter', {
      pattern = '*',
      command = 'RainbowToggleOn',
    })
    pcall(require, 'local.rainbow')
  end,
}
