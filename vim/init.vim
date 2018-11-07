set nocompatible " Disable backward compatibility with vi
let NVIM = has('nvim')

" Using vim-plug for plugins
" ============================
call plug#begin(NVIM ? '~/.local/share/nvim/plugged' : '~/.vim/plugged')

" Syntax highlighting
Plug 'sheerun/vim-polyglot' " Syntax highlighting for most languages
Plug 'luochen1990/rainbow' " Color nested parentheses

" Editing
Plug 'Raimondi/delimitMate' " Autocomplete for parentheses, quotes, etc.
Plug 'ntpeters/vim-better-whitespace' " Remove trailing whitespace
Plug 'Valloric/YouCompleteMe', { 'do': './install.py --js-completer' } " Auto completion

" Color schemes
Plug 'KeitaNakamura/neodark.vim'
Plug 'sonph/onehalf', { 'rtp': 'vim' }

" Status
Plug 'itchyny/lightline.vim' " Status line
if has('signs')
    Plug 'airblade/vim-gitgutter' " Show git status of each line left of line number
    set updatetime=1000 " 1 second
endif

call plug#end() " Initialize plugin system


" Plugin config
" ============================
" Lightline
let g:lightline = {}
set laststatus=2

" Rainbow parentheses
let g:rainbow_active = 1 " Enable
if !has('termguicolors') " If true color is not available, fix weird colors by setting defaults
    let g:rainbow_conf = {
    \    'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick'],
    \    'ctermfgs': ['blue', 'yellow', 'cyan', 'magenta']
    \}
endif

" Better whitespace
nnoremap <silent> <C-s> :silent :StripWhitespace<CR>

" YouCompleteMe
let g:ycm_add_preview_to_completeopt = 1
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_server_python_interpreter = 'python'
let g:ycm_python_binary_path = 'python'


" Color schemes
" ============================
function Light_theme()
    set background=light
    colorscheme onehalflight
    let g:lightline.colorscheme='onehalfdark'
endfunction

function Dark_theme()
    set background=dark
    colorscheme neodark
    let g:lightline.colorscheme='neodark'
endfunction

" Commands to manually change color scheme
command L call Light_theme()
command D call Dark_theme()

" Set colorscheme
if match($THEME, "light") == 0
    call Light_theme()
else
    call Dark_theme()
endif


" Misc visual settings
" ============================
if has('termguicolors')
    set termguicolors
endif

" Line numbers
set number
set relativenumber
augroup numbertoggle
    autocmd!
    autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
    autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END

autocmd VimEnter,WinEnter * let &scrolloff = winheight(0) / 4 " Scroll limit
set nowrap " Disable line wrapping
set cursorline " Enable cursor line
set incsearch " Search as characters are entered
set hlsearch " Highlight search matches
set showcmd " Show (partial) command on the last line of the screen
set ruler " Show current row, column, percent, etc.

if NVIM
    " Enable italics for comments
    hi Comment cterm=italic
endif


" Misc settings
" ============================
set backspace=indent,eol,start " Normal backspace in insert mode
set ignorecase
set smartcase

" Tabs
set tabstop=8 softtabstop=0 expandtab shiftwidth=4 smarttab " Set tab to 4 spaces
" Language specific tab size
autocmd FileType javascript setlocal shiftwidth=2
autocmd FileType css setlocal shiftwidth=2

" Enable mode shapes, 'Cursor' highlight, and blinking:
set guicursor=n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor,sm:block-blinkwait175-blinkoff150-blinkon175

"Folding settings
set foldmethod=indent " Fold based on indent
set foldnestmax=10    " Deepest fold is 10 levels
set nofoldenable      " Dont fold by default
set foldlevel=1       " This is just what i use


" Keyboard shortcuts
" ============================
if NVIM
    " Remove search highlighting
    nnoremap <silent><Esc> :noh<CR>
else
    " Hit Esc twice to remove search highlighting from previous search
    nnoremap <silent> <Esc><Esc> :noh<CR>
endif
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
if NVIM
    " Press leader+escape in terminal to get out
    tnoremap <Leader><Esc> <C-\><C-n>
endif

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