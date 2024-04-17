vim.o.mouse = '' -- disable mouse
vim.o.showmode = false -- dedup mode status
vim.o.termguicolors = true -- enable 24-bit RGB color
vim.o.number = true -- numbered lines
vim.o.wrap = false -- disable line wrapping
vim.o.cursorline = true -- enable cursor line
vim.o.visualbell = true -- visual bell instead of beeping
vim.o.ignorecase = true -- ignore case in search patterns
vim.o.smartcase = true -- consider case if uppercase present
vim.o.shada = "!,'10000,<50,s10,h" -- configure shraed data (recent files, etc)
vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }

-- tabs
vim.o.expandtab = true -- use spaces not tabs
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.list = true -- display tabs differently
vim.o.listchars = 'tab:· ' -- character for tabs

-- folds
vim.o.foldmethod = 'indent' -- fold based on indent
vim.o.foldnestmax = 10
vim.o.foldenable = false -- dont fold by default
vim.o.foldlevel = 1

-- cursor: enable mode shapes, 'Cursor' highlight, and blinking
vim.o.guicursor =
  'n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor,sm:block-blinkwait175-blinkoff150-blinkon175'
