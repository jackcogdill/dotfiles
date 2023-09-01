local ok, mod = pcall(require, 'local.mod.rainbow')

-- color nested parentheses
return {
  'luochen1990/rainbow',
  event = 'BufReadPost',
  config = function()
    vim.api.nvim_create_autocmd('BufEnter', {
      pattern = '*',
      command = 'RainbowToggleOn',
    })
    if ok then
      mod.config()
    end
  end,
}
