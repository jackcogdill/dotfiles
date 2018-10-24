" Using vim-plug for plugins {{
call plug#begin('~/.vim/plugged')
" ============================
" Syntax highlighting {{
" Rainbow parantheses
Plug 'luochen1990/rainbow'
" Syntax highlighting for most languages
Plug 'sheerun/vim-polyglot'
" }}

" Editing {{
" Parentheses autocomplete
Plug 'Raimondi/delimitMate'
" Whitespace plugin
Plug 'ntpeters/vim-better-whitespace'
" }}

" Color scheme
Plug 'KeitaNakamura/neodark.vim'
Plug 'junegunn/seoul256.vim'

" ============================
" Initialize plugin system
call plug#end()
" }}


" Specific Color scheme {{
" Set color scheme
colorscheme neodark
" Enable rainbow parantheses
let g:rainbow_active = 1
let g:rainbow_conf = {
\    'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick'],
\    'ctermfgs': ['blue', 'yellow', 'cyan', 'magenta']
\}
" Custom commands
command L colorscheme seoul256-light
command D colorscheme neodark
" }}

" General Color scheme {{
" Enable line numbers
set number

" Relative line numbers
set relativenumber
augroup numbertoggle
    autocmd!
    autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
    autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END

" Scroll limit 1/4
autocmd VimEnter,WinEnter * let &scrolloff = winheight(0) / 4
" Disable wrapping
set nowrap
" Enable cursor line
set cursorline
" Search
set incsearch " Search as characters are entered
set hlsearch " Highlight matches
" Enable truecolor support
if has('termguicolors')
    set termguicolors
endif
set showcmd " Show (partial) command in the last line of the screen
" }}

" Smart case
set ignorecase
set smartcase

" Tab is 4 spaces
set tabstop=8 softtabstop=0 expandtab shiftwidth=4 smarttab
" 2 spaces for JavaScript
autocmd FileType javascript setlocal shiftwidth=2

" Hit Esc twice to remove search highlighting from previous search
nnoremap <silent> <Esc><Esc> :noh<CR>

" Normal backspace in insert mode
set backspace=indent,eol,start

