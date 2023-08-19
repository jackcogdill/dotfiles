-- status line
return {
  'itchyny/lightline.vim',
  event = 'BufReadPost',
  config = function()
    vim.cmd([[
      let g:lightline = {
            \ 'colorscheme': 'everforest',
            \ 'tabline': {
            \   'left'  : [ [ 'tabs' ] ],
            \   'right' : [ [] ],
            \ },
            \ 'tab': {
            \   'active': [ 'filename', 'modified' ],
            \   'inactive': [ 'filename', 'modified' ],
            \ },
            \ 'active': {
            \   'left': [ [ 'mode', 'paste', 'spell' ],
            \             [ 'readonly', 'filename' ] ],
            \   'right': [ [ 'lineinfo' ],
            \              [ 'percent' ],
            \              [ 'filetype' ] ]
            \ },
            \ 'inactive': {
            \   'left': [ [ 'filename' ] ],
            \   'right': [ [] ],
            \ },
            \ 'component_function': {
            \   'filename': 'LightlineFilename',
            \ },
            \ 'mode_map': {
            \   'n' : 'NOR', 'i' : 'INS', 'R' : 'REP', 'v' : 'VIS', 'V' : 'V-L', "\<C-v>": 'V-B',
            \   'c' : 'CMD', 's' : 'SEL', 'S' : 'S-L', "\<C-s>": 'S-B', 't': 'TRM',
            \ },
            \ }
      fun! LightlineFilename()
        if &buftype == 'terminal'
          "        [ name ][ remove prefix ][ title ]
          return expand('%:s?term://[^:]*:??:s?.*;#??')
        endif

        let expanded = expand('%:t')
        let filename = expanded !=# '' ? expanded : '[No Name]'
        let modified = &modified ? ' +' : ''
        return filename . modified
      endfun
    ]])
    vim.api.nvim_create_autocmd('WinClosed', {
      pattern = '*',
      command = 'call lightline#update()',
    })
    -- update lightline and tmuxline on background change
    vim.api.nvim_create_autocmd('OptionSet', {
      pattern = 'background',
      callback = function()
        vim.cmd('Tmuxline') -- load plugin
        vim.cmd("execute 'source' globpath(&rtp, 'autoload/lightline/colorscheme/everforest.vim')")
        vim.cmd('call lightline#colorscheme()')
        vim.cmd('call lightline#update()')
        vim.cmd("call tmuxline#api#set_theme(tmuxline#util#create_theme_from_lightline(lightline#palette()['command']))")
      end,
    })
  end,
}
