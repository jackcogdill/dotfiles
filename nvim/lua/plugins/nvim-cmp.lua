local ok, mod = pcall(require, 'local.mod.nvim-cmp')

-- completion
return {
  'hrsh7th/nvim-cmp',
  dependencies = vim.list_extend({
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-nvim-lsp-document-symbol',
    'hrsh7th/cmp-nvim-lua',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-cmdline',
    'saadparwaiz1/cmp_luasnip',
    'onsails/lspkind.nvim', -- icons
  }, ok and mod.dependencies or {}),
  event = 'VeryLazy',
  config = function()
    local cmp = require('cmp')

    local source_names = vim.tbl_deep_extend('force', {
      nvim_lsp = '[LSP]',
      luasnip = '[LuaSnip]',
      buffer = '[Buffer]',
      path = '[Path]',
      nvim_lua = '[Lua]',
    }, ok and mod.opts.formatting.source_names or {})

    -- If priority is not specified, index is used (promotes earlier sources)
    local sources = vim.list_extend(ok and mod.opts.sources or {}, {
      { name = 'nvim_lsp', priority = 200 },
      { name = 'luasnip', priority = 100 },
      {
        name = 'buffer',
        option = {
          get_bufnrs = function()
            return vim.tbl_filter(
              vim.api.nvim_buf_is_loaded,
              vim.api.nvim_list_bufs()
            )
          end,
        },
      },
      { name = 'path' },
      { name = 'nvim_lua' },
    })

    local lspkind = require('lspkind')
    cmp.setup({
      formatting = {
        format = lspkind.cmp_format({
          mode = 'symbol_text',
          menu = source_names,
          maxwidth = {
            abbr = function()
              return vim.o.columns / 2
            end,
          },
          ellipsis_char = '…',
        }),
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
      sources = cmp.config.sources(sources),
      sorting = {
        comparators = {
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
      }),
    })

    -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
    cmp.setup.cmdline(':', {
      mapping = cmp.mapping.preset.cmdline(),
      sources = cmp.config.sources({
        { name = 'path' },
        { name = 'cmdline' },
      }),
    })
  end,
}
