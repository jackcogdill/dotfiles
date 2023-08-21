-- color nested parentheses
return {
  'luochen1990/rainbow',
  event = 'BufReadPost',
  config = function()
    vim.g.rainbow_active = 1
    pcall(require, 'local.rainbow')
  end,
}
