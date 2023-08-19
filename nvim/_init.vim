" Semantic completion
" Plug 'neovim/nvim-lspconfig'
" Plug 'hrsh7th/cmp-nvim-lsp'
" Plug 'hrsh7th/cmp-nvim-lsp-document-symbol'
" Plug 'hrsh7th/cmp-nvim-lua'
" Plug 'hrsh7th/cmp-buffer'
" Plug 'hrsh7th/cmp-path'
" Plug 'hrsh7th/cmp-cmdline'
" Plug 'hrsh7th/nvim-cmp'
" Plug 'L3MON4D3/LuaSnip', { 'tag': '*' }
" Plug 'rafamadriz/friendly-snippets'
" Plug 'saadparwaiz1/cmp_luasnip'

" Shell commands
" Plug 'skywind3000/asyncrun.vim' " Run shell commands in the background

" Plugin config
" ============================
" nvim-cmp
" --------
lua << EOF
local cmp = require('cmp')

-- If lsp offers a completion score, use it when sorting completion options
local function compare_by_completion_score(entry1, entry2)
  if entry1.completion_item.score ~= nil and entry2.completion_item.score ~= nil then
    return entry1.completion_item.score > entry2.completion_item.score
  end
end

cmp.setup({
  formatting = {
    format = function(entry, vim_item)
      -- Source
      vim_item.menu = ({
        nvim_lsp = '[LSP]',
        luasnip = '[LuaSnip]',
        buffer = '[Buffer]',
        path = '[Path]',
        nvim_lua = '[Lua]',
      })[entry.source.name]
      return vim_item
    end
  },
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<C-y>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = 'buffer' },
    { name = 'path' },
    { name = 'nvim_lua' },
  }),
  sorting = {
    comparators = {
      compare_by_completion_score,
      cmp.config.compare.offset,
      cmp.config.compare.exact,
      cmp.config.compare.score,
      cmp.config.compare.recently_used,
      cmp.config.compare.locality,
      cmp.config.compare.kind,
      cmp.config.compare.length,
      cmp.config.compare.order,
    },
  },
  experimental = {
    ghost_text = true,
  },
})

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ '/', '?' }, {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'nvim_lsp_document_symbol' },
    { name = 'buffer' },
  })
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' },
    { name = 'cmdline' },
  })
})
EOF

" luasnip
" -------
lua << EOF
local luasnip = require('luasnip')
local opts = { noremap = true, silent = true }
vim.keymap.set({'i', 's'}, '<C-j>', function() luasnip.jump(1) end, opts)
vim.keymap.set({'i', 's'}, '<C-k>', function() luasnip.jump(-1) end, opts)
require('luasnip.loaders.from_vscode').lazy_load()
EOF


" AsyncRun
" --------------
fun! AsyncWrap(cmd)
  let opts = {
      \ 'mode': 'term',
      \ 'rows': 10,
      \ 'focus': 0,
      \ 'listed': 0,
      \ }
  call asyncrun#run('', opts, a:cmd)
endfun




" Local config
" ============================
let s:local_config = expand('~/.config/nvim/local.vim')
if filereadable(s:local_config)
  exe 'source ' . s:local_config
endif
