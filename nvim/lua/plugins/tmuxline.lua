-- tmux status line
return {
  'edkolev/tmuxline.vim',
  cmd = 'Tmuxline',
  config = function()
    vim.cmd([[
      let g:tmuxline_powerline_separators = 0
      let g:tmuxline_preset = {
            \ 'a'       : '#h:#S',
            \ 'win'     : '#W',
            \ 'cwin'    : '#W',
            \ 'x'       : '#T',
            \ 'y'       : '%a %b %d',
            \ 'z'       : '%H:%M',
            \ 'options' : {
            \   'status-justify' : 'left',
            \   'status-style'   : 'default',
            \ },
            \ }
    ]])
    pcall(require, 'local.tmuxline')
  end,
}
