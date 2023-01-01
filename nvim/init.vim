set nocompatible
set mouse=

augroup vimrc
  autocmd!
augroup END

" Plugins
" ============================
" Auto install vim-plug
let s:vimplug = '~/.local/share/nvim/site/autoload/plug.vim'
if empty(glob(s:vimplug))
  silent exe '!curl -fLo ' . s:vimplug . ' --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd vimrc VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.local/share/nvim/plugged')

" Syntax highlighting
Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' } " Incremental syntax parsing
Plug 'luochen1990/rainbow' " Color nested parentheses

" Editing
Plug 'jiangmiao/auto-pairs' " Autocomplete for parentheses, quotes, etc.
Plug 'ntpeters/vim-better-whitespace' " Remove trailing whitespace
Plug 'wsdjeg/vim-fetch' " Line and column jump specifications
Plug 'svermeulen/vim-yoink' " Yank history

" Semantic completion
Plug 'neovim/nvim-lspconfig'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'Shougo/deoplete-lsp' " LSP source
Plug 'Shougo/neco-vim' " Vim source
Plug 'Shougo/echodoc.vim' " Display function signatures from completions
Plug 'Shougo/neosnippet.vim' " Snippet support

" Color schemes
Plug 'sainnhe/everforest'

" Status
Plug 'itchyny/lightline.vim' " Status line
Plug 'edkolev/tmuxline.vim' " Tmux status line
Plug 'mhinz/vim-signify' " Signs for changes tracked by a version control system

" Navigation / Organization
Plug 'thaerkh/vim-workspace' " Sessions
Plug 'christoomey/vim-tmux-navigator' " Seamless navigation with tmux
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } } " Fuzzy search
Plug 'airblade/vim-rooter' " Project root working directory
Plug 'ojroques/vim-oscyank' " Copy to system clipboard including over remote ssh

" Shell commands
Plug 'skywind3000/asyncrun.vim' " Run shell commands in the background

" Conflict resolution
Plug 'whiteinge/diffconflicts'

" Local plugins
let s:plug = expand('~/.config/nvim/plug.vim')
if filereadable(s:plug)
  exe 'source ' . s:plug
endif

call plug#end() " Initialize plugin system

" Plugin config
" ============================
" nvim-treesitter
" ---------------
lua << EOF
require 'nvim-treesitter.configs'.setup {
  ensure_installed = 'all',
  ignore_install = { 'phpdoc' },
  highlight = {
    enable = true, -- false will disable the whole extension
    disable = { 'html' }, -- list of language that will be disabled
  },
}
EOF
" Compatibility with rainbow-parentheses
autocmd vimrc BufEnter * hi clear TSPunctBracket

" auto-pairs
" ----------
let g:AutoPairsCenterLine = 0
let g:AutoPairsShortcutFastWrap = '<M-w>'

" vim-signify
" -----------
let g:signify_skip = { 'vcs': { 'allow': ['git'] } }
let g:signify_update_on_focusgained = 1

" fzf
" ---
let g:fzf_layout = { 'down': '~25%' }
let $FZF_DEFAULT_COMMAND = 'find .
      \ -type d \(
      \ -name node_modules -o
      \ -name .git -o
      \ -name .undodir
      \ \)
      \ -prune -o -print'

fun! s:Buflist()
  redir => ls
  silent ls
  redir END
  return split(ls, '\n')
endfun

fun! s:Bufopen(lines)
  let cmd = get({
        \ 'ctrl-x': 'sb',
        \ 'ctrl-v': 'vert sb',
        \ 'ctrl-t': 'tab sb',
        \ }, a:lines[0], 'b')
  exe cmd matchstr(a:lines[1], '^[ 0-9]*')
endfun

fun! s:Recentlist()
  redir => list
  silent oldfiles
  redir END
  let list = split(list, '\n')
  return map(list, {_, v -> substitute(v, '^[0-9]\+: ', '', '')})
endfun

fun! s:Registerlist()
  redir => list
  silent registers
  redir END
  return split(list, '\n')[1:]
endfun

fun! s:Registerpaste(line)
  exe 'normal ' . matchstr(a:line, '^\s\+\w\s\+\zs".') . 'p'
endfun

" Files
nnoremap <silent> <C-p> :exe 'FZF ' . FindRootDirectory()<CR>
" Buffers
nnoremap <silent> <C-n> :call fzf#run(fzf#wrap({
      \ 'source': reverse(<sid>Buflist()),
      \ 'sink*': function('<sid>Bufopen'),
      \ 'options': '--expect=ctrl-t,ctrl-v,ctrl-x',
      \ }))<CR>
" Recent
nnoremap <silent> <C-e> :call fzf#run(fzf#wrap({
      \ 'source': <sid>Recentlist(),
      \ }))<CR>
" Registers
nnoremap <silent> <C-y> :call fzf#run(fzf#wrap({
      \ 'source': <sid>Registerlist(),
      \ 'sink': function('<sid>Registerpaste'),
      \ }))<CR>

" vim-yoink
" ---------
let g:yoinkIncludeDeleteOperations = 1
let g:yoinkSyncNumberedRegisters = 1

" vim-rooter
" ----------
let g:rooter_manual_only = 1

" vim-workspace
" -------------
nnoremap <leader>w :ToggleWorkspace<CR>
let g:workspace_autocreate = 1
let g:workspace_session_directory = expand('~/.local/share/nvim/sessions/')
let g:workspace_autosave = 0 " Disable auto save
" Mostly because `hg commit` creates a workspace flooded with tmp files
let g:workspace_session_disable_on_args = 1

" Lightline
" ---------
set laststatus=2 " Enable status line
set noshowmode " De-dup mode status
let g:lightline = {
      \ 'colorscheme': 'everforest',
      \ 'tabline': {
      \   'left'  : [[ 'tabs' ]],
      \   'right' : [[]],
      \ },
      \ 'tab': {
      \   'active': [ 'filename', 'modified' ],
      \   'inactive': [ 'filename', 'modified' ],
      \ },
      \ 'active': {
      \   'left': [[ 'mode', 'paste', 'spell' ],
      \            [ 'readonly', 'filename' ]],
      \   'right': [[ 'lineinfo' ],
      \             [ 'percent' ],
      \             [ 'filetype' ]]
      \ },
      \ 'inactive': {
      \   'left': [['filename']],
      \   'right': [[]],
      \ },
      \ 'component_function': {
      \   'filename': 'LightlineFilename',
      \ },
      \ 'mode_map': {
      \   'n' : 'NML', 'i' : 'INS', 'R' : 'REP', 'v' : 'VIS', 'V' : 'V-L', "\<C-v>": 'V-B',
      \   'c' : 'CMD', 's' : 'SEL', 'S' : 'S-L', "\<C-s>": 'S-B', 't': 'TRM',
      \ },
      \ }
autocmd vimrc WinClosed * call lightline#update()

fun! LightlineFilename()
  let expanded = expand('%:t')
  let filename = expanded !=# '' ? expanded : '[No Name]'
  let modified = &modified ? ' +' : ''
  return filename . modified
endfun

" Tmuxline
" --------
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

" Rainbow parentheses
" -------------------
let g:rainbow_active = 1

" Better whitespace
" -----------------
nnoremap <silent> <C-s> :silent :StripWhitespace<CR>

" deoplete
" --------
let g:python3_host_prog = '/usr/bin/python3'
let g:deoplete#enable_at_startup = 1
" Manually set complete options
set completeopt=menuone
" '_' sets options for all sources
call deoplete#custom#source('_', {
      \ 'matchers': ['matcher_full_fuzzy'],
      \ 'smart_case': v:true,
      \ })
call deoplete#custom#option('_', {
      \ 'auto_complete_delay': 250,
      \ 'auto_refresh_delay': 250,
      \ 'max_list': 100,
      \ })

" neosnippet
" ----------
let g:neosnippet#disable_runtime_snippets = { '_': 1 }
let g:neosnippet#enable_completed_snippet = 1
let g:neosnippet#enable_complete_done = 1
imap <C-j> <Plug>(neosnippet_expand_or_jump)
smap <C-j> <Plug>(neosnippet_expand_or_jump)

" echodoc
" -------
let g:echodoc#enable_at_startup = 1
let g:echodoc#type = 'floating'

" AsyncRun
" --------------
" Open the quickfix window automatically at N lines height after command starts
let g:asyncrun_open = 8

" vim-oscyank
" --------------
let g:oscyank_term = 'default'
noremap <Leader>Y :OSCYank<CR>


" Visual
" ============================
set termguicolors
" Line numbers
set number
set relativenumber
augroup vimrc
  autocmd BufEnter,FocusGained,InsertLeave * silent if &number == 1 | set relativenumber | endif
  autocmd BufLeave,FocusLost,InsertEnter   * silent set norelativenumber
augroup END
" Make C-C trigger InsertLeave
inoremap <C-C> <Esc>

autocmd vimrc VimEnter,WinEnter * let &scrolloff = winheight(0) / 4 " Scroll limit
set nowrap " Disable line wrapping
set cursorline " Enable cursor line
set incsearch " Search as characters are entered
set hlsearch " Highlight search matches
set showcmd " Show (partial) command on the last line of the screen
set ruler " Show current row, column, percent, etc.


" Colorscheme
" ============================
let g:everforest_background = 'soft'
let g:everforest_enable_italic = 1
let g:everforest_sign_column_background = 'none'
let g:everforest_lightline_disable_bold = 1
colorscheme everforest
" Update lightline and tmuxline on background change
autocmd vimrc OptionSet background
      \ execute 'source' globpath(&rtp, 'autoload/lightline/colorscheme/everforest.vim')
      \ | call lightline#colorscheme() | call lightline#update()
      \ | call tmuxline#api#set_theme(tmuxline#util#create_theme_from_lightline(lightline#palette()['command']))


" Editor
" ============================
" Reload buffers if changed outside of vim
set autoread
autocmd vimrc FocusGained * checktime

" Disable bells and flashing
set noerrorbells visualbell t_vb=
autocmd vimrc GUIEnter * set visualbell t_vb=

set backspace=indent,eol,start " Normal backspace in insert mode
set ignorecase
set smartcase

" Tabs
set list listchars=tab:·\  " Keep this whitespace
set tabstop=2 shiftwidth=2 expandtab
" Language specific tab size
augroup vimrc
  autocmd FileType go setlocal tabstop=2 shiftwidth=2
  autocmd FileType python setlocal tabstop=2 shiftwidth=2
augroup END

" Enable mode shapes, 'Cursor' highlight, and blinking:
set guicursor=n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor,sm:block-blinkwait175-blinkoff150-blinkon175

"Folding settings
set foldmethod=indent " Fold based on indent
set foldnestmax=10    " Deepest fold is 10 levels
set nofoldenable      " Dont fold by default
set foldlevel=1       " This is just what i use

" Disable joinspaces (only insert 1 space after [.?!], not 2)
set nojs

" Remember 1000 recent files
set shada=!,'1000,<50,s10,h


" Keybinds
" ============================
" Remove search highlighting and clear command line
nnoremap <silent><Esc> :exe 'noh <Bar> echo'<CR>
" Press // in visual mode to search selected text
vnoremap // y/<C-R>"<CR>
" Redo macro with space
nnoremap <Space> @q
" Redo macro with leader+space at next search result
nnoremap <Leader><Space> n@q
" Redo macro on all lines in visual mode
vnoremap <Space> :normal @q<CR>
" Redo last change on all lines in visual mode
vnoremap . :normal .<CR>
" Press leader+escape in terminal to get out
tnoremap <Leader><Esc> <C-\><C-n>

" Navigate tabs
nnoremap <silent> H :silent :tabp<CR>
nnoremap <silent> L :silent :tabn<CR>
nnoremap <silent> <A-h> :silent :tabm -1<CR>
nnoremap <silent> <A-l> :silent :tabm +1<CR>
nnoremap <Leader>1 1gt
nnoremap <Leader>2 2gt
nnoremap <Leader>3 3gt
nnoremap <Leader>4 4gt
nnoremap <Leader>5 5gt
nnoremap <Leader>6 6gt
nnoremap <Leader>7 7gt
nnoremap <Leader>8 8gt
nnoremap <silent> <Leader>9 :tablast<CR>
nnoremap <silent> <C-T><C-O> :tabonly<CR>
nnoremap <silent> <C-M> :tabnew<CR>

" Switch to last active tab
if !exists('g:lasttab')
  let g:lasttab = 1
  let g:lasttab_backup = 1
endif
augroup vimrc
  autocmd TabLeave * let g:lasttab_backup = g:lasttab | let g:lasttab = tabpagenr()
  autocmd TabClosed * let g:lasttab = g:lasttab_backup
augroup END
nnoremap <silent> <Leader>l :exe "tabn " . g:lasttab<CR>

" Navigate buffers
nnoremap <silent> <Leader>[ :silent :bp<CR>
nnoremap <silent> <Leader>] :silent :bn<CR>

" Spell check
nnoremap <Leader>s :setlocal spell! spelllang=en_us<CR>

" Sort
vnoremap <C-s> :sort<CR>

" Copy/paste/delete to system clipboard
noremap <Leader>y "*y
noremap <Leader>p "*p
noremap <Leader>P "*P
noremap <Leader>d "*d
" Copy filepath to the unnamed register
noremap <Leader>g :let @" = expand('%')<CR>

" Toggle line wrapping ruler (colorcolumn) (off by default)
nnoremap <silent> <Leader><Leader> :let &cc = &cc == '' ? '+1' : ''<CR>

" Reload vimrc
nnoremap <A-r> :source $MYVIMRC<CR>

" Toggle diffs
nnoremap <silent> <Leader>D :exe &diff == 0 ? 'windo diffthis' : 'diffoff!'<CR>


" Local config
" ============================
let s:local_config = expand('~/.config/nvim/local.vim')
if filereadable(s:local_config)
  exe 'source ' . s:local_config
endif
