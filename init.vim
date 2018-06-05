" Using vim-plug for plugins {{
call plug#begin('~/.local/share/nvim/plugged')
" ============================
" Syntax highlighting {{
" Rainbow parantheses
Plug 'luochen1990/rainbow'
" Better python syntax highlighting
Plug 'hdima/python-syntax'
" ES7 javascript highlighting
Plug 'othree/yajs.vim'
" }}

" Editing {{
" Parentheses autocomplete
Plug 'Raimondi/delimitMate'
" Whitespace plugin
Plug 'ntpeters/vim-better-whitespace'
" }}

" Auto completion
Plug 'Valloric/YouCompleteMe', { 'do': 'python3 install.py' }

" Status bar
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Palenight color scheme
Plug 'jackcogdill/palenight.vim'

" ============================
" Initialize plugin system
call plug#end()
" }}

" Specific Color scheme {{
" Italics for my favorite color scheme
let g:palenight_terminal_italics=1
set background=dark
" Set color scheme
colorscheme palenight
" Enable rainbow parantheses
let g:rainbow_active = 1
" }}

" General Color scheme {{
" Enable line numbers
set number
" Disable line wrapping
set nowrap
" Enable cursor line
set cursorline
" Enable true colors support
set termguicolors
" Enable italics for comments
hi Comment cterm=italic
" }}

" Python syntax
let python_highlight_all = 1

" YCM config {{
let g:ycm_add_preview_to_completeopt = 1
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_server_python_interpreter = '/opt/local/bin/python3'
" }}

" Airline config {{
let g:airline#extensions#tabline#enabled = 1
" }}

" Airline theme config {{
let g:airline_theme='base16_shell'
let g:airline_powerline_fonts = 1 " Powerline symbols
" }}

" Whitespace config {{
nnoremap <silent> <C-s> :silent :StripWhitespace<CR>
" }}

" Smart case
set ignorecase
set smartcase

" Tab is 4 spaces
set tabstop=8 softtabstop=0 expandtab shiftwidth=4 smarttab

" Don't use Ibeam cursor in insert mode
set guicursor=

" Remove search highlighting
nnoremap <silent><Esc> :noh<CR>
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
" Enable mode shapes, 'Cursor' highlight, and blinking:
set guicursor=n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor,sm:block-blinkwait175-blinkoff150-blinkon175

"Folding settings
set foldmethod=indent   "fold based on indent
set foldnestmax=10      "deepest fold is 10 levels
set nofoldenable        "dont fold by default
set foldlevel=1         "this is just what i use
" Create newline without entering insert mode
nnoremap <C-O> o<Esc>

" Navigate tabs
nnoremap <silent> <C-M> :silent :tabnew<CR>
nnoremap <silent> <C-Left> :silent :tabp<CR>
nnoremap <silent> <C-Right> :silent :tabn<CR>

" Navigate buffers
nnoremap <silent> <Leader>[ :silent :bp<CR>
nnoremap <silent> <Leader>] :silent :bn<CR>
" Delete buffer
nnoremap <silent> <C-L> :silent :bd<CR>
" Delete buffer with !
nnoremap <silent> <C-K> :silent :bd!<CR>

" Spellcheck
nmap <Leader>s :setlocal spell! spelllang=en_us<CR>

