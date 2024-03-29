local ok, mod = pcall(require, 'local.mod.tmuxline')

-- tmux status line
return {
  'edkolev/tmuxline.vim',
  cmd = 'Tmuxline',
  config = function()
    vim.g.tmuxline_powerline_separators = false
    vim.g.tmuxline_preset = {
      a = '#h:#S',
      win = '#W',
      cwin = '#W',
      x = '#T',
      y = '%a %b %d',
      z = '%H:%M',
      options = {
        ['status-justify'] = 'left',
        ['status-style'] = 'default',
      },
    }
    if ok then
      mod.config()
    end
  end,
}
