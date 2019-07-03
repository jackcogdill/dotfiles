set nocompatible " Disable backward compatibility with vi
let NVIM = has('nvim')

" Auto install vim-plug
let s:vimplug_path = NVIM ? '~/.local/share/nvim/site/autoload/plug.vim' : '~/.vim/autoload/plug.vim'
if empty(glob(s:vimplug_path))
  silent execute '!curl -fLo ' . s:vimplug_path . ' --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif


" Using vim-plug for plugins
" ============================
call plug#begin(NVIM ? '~/.local/share/nvim/plugged' : '~/.vim/plugged')

" Syntax highlighting
Plug 'sheerun/vim-polyglot' " Syntax highlighting for most languages
Plug 'luochen1990/rainbow' " Color nested parentheses

" Editing
Plug 'Raimondi/delimitMate' " Autocomplete for parentheses, quotes, etc.
Plug 'ntpeters/vim-better-whitespace' " Remove trailing whitespace
Plug 'Valloric/YouCompleteMe', { 'do': 'python3 install.py --js-completer --go-completer' } " Auto completion
Plug 'Yggdroot/indentLine' " Display code indentation with lines

" Color schemes
Plug 'morhetz/gruvbox'

" Status
Plug 'itchyny/lightline.vim' " Status line
Plug 'mhinz/vim-signify' " Changes for version control systems
Plug 'edkolev/tmuxline.vim' " Tmux status line

" Navigation / Organization
Plug 'thaerkh/vim-workspace' " Sessions
Plug 'christoomey/vim-tmux-navigator' " Tmux navigation integration
Plug 'ctrlpvim/ctrlp.vim' " Files

call plug#end() " Initialize plugin system


" Core Python config
" ============================
let g:python2_host_prog = '/usr/local/bin/python'
let g:python3_host_prog = '/usr/local/bin/python3'


" Plugin config
" ============================
" vim-signify
let g:signify_vcs_list = [ 'git', 'hg' ]

" CtrlP
let g:ctrlp_cmd = 'CtrlPMixed' " Search in Files, Buffers and MRU files
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.?(DS_Store|node_modules|git|hg|svn)$',
  \ 'file': '\v\.(exe|so|dll)$',
  \ 'link': 'some_bad_symbolic_links',
  \ }

" vim-workspace
nnoremap <leader>w :ToggleWorkspace<CR>
let g:workspace_autocreate = 1
let g:workspace_session_directory = $HOME . '/.vim/sessions/'
let g:workspace_autosave = 0 " Disable auto save
let g:workspace_session_disable_on_args = 1

" Lightline
let g:lightline = {}
set laststatus=2

" Tmuxline
let g:tmuxline_powerline_separators = 0

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
let g:ycm_server_python_interpreter = 'python3'
let g:ycm_python_binary_path = 'python3'

" indentLine
let g:indentLine_char = '┆'


" Misc visual settings
" ============================
if NVIM
    " Enable italics for comments
    hi Comment cterm=italic
    let g:gruvbox_italic=1
endif

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
" Remap zt and zb to be unaffected by scrolloff
" (actually move line to top and bottom)
nnoremap zt :execute "normal! " . (line(".") + &scrolloff) . "Gzt"<CR>
nnoremap zb :execute "normal! " . (line(".") - &scrolloff) . "Gzb"<CR>
set nowrap " Disable line wrapping
set cursorline " Enable cursor line
set incsearch " Search as characters are entered
set hlsearch " Highlight search matches
set showcmd " Show (partial) command on the last line of the screen
set ruler " Show current row, column, percent, etc.


" Color schemes
" ============================
function! Light_theme()
    set background=light
    let g:gruvbox_contrast_light='medium'
    colorscheme gruvbox
    let g:lightline.colorscheme='gruvbox'
endfunction

function! Dark_theme()
    set background=dark
    let g:gruvbox_contrast_dark='medium'
    colorscheme gruvbox
    let g:lightline.colorscheme='gruvbox'
endfunction

" Commands to manually change color scheme
command! L call Light_theme()
command! D call Dark_theme()

" Set colorscheme
call Dark_theme()


" Misc settings
" ============================
" Disable bells and flashing
set noerrorbells visualbell t_vb=
autocmd GUIEnter * set visualbell t_vb=

set backspace=indent,eol,start " Normal backspace in insert mode
set ignorecase
set smartcase

" Tabs
set tabstop=8 softtabstop=0 expandtab shiftwidth=4 smarttab " Set tab to 4 spaces
" Language specific tab size
autocmd FileType javascript setlocal shiftwidth=2
autocmd FileType css setlocal shiftwidth=2
autocmd FileType vim setlocal shiftwidth=2
autocmd FileType vue setlocal shiftwidth=2

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

" Navigate tabs
nnoremap <silent> <C-M> :silent :tabnew<CR>
nnoremap <silent> H :silent :tabp<CR>
nnoremap <silent> L :silent :tabn<CR>

" Navigate buffers
nnoremap <silent> <Leader>[ :silent :bp<CR>
nnoremap <silent> <Leader>] :silent :bn<CR>

" Spellcheck
nmap <Leader>s :setlocal spell! spelllang=en_us<CR>

" Paste from clipboard
nnoremap <C-P> "*p
