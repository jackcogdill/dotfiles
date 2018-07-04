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

" Status bar
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Color scheme
Plug 'KeitaNakamura/neodark.vim'

" ============================
" Initialize plugin system
call plug#end()
" }}


" Specific Color scheme {{
set background=dark
" Set color scheme
colorscheme neodark
" Enable rainbow parantheses
let g:rainbow_active = 1
let g:rainbow_conf = {
\    'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick'],
\    'ctermfgs': ['blue', 'yellow', 'cyan', 'magenta']
\}
" }}

" General Color scheme {{
" Enable line numbers
set number
" Disable wrapping
set nowrap
" Enable cursor line
set cursorline
" Enable highlighting search matches
set hlsearch
" Enable truecolor support
if has('termguicolors')
    set termguicolors
endif
set showcmd " Show (partial) command in the last line of the screen
" }}

" Airline config {{
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1 " Powerline symbols
" }}

" Smart case
set ignorecase
set smartcase

" Tab is 4 spaces
set tabstop=8 softtabstop=0 expandtab shiftwidth=4 smarttab

" Hit Esc twice to remove search highlighting from previous search
nnoremap <silent> <Esc><Esc> :noh<CR>

" Normal backspace in insert mode
set backspace=indent,eol,start

