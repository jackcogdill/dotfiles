-- CiderLSP setup
return {
  'neovim/nvim-lspconfig',
  event = 'BufReadPost',
  config = function()
    local lspconfig = require('lspconfig')

    local capabilities = require('cmp_nvim_lsp').default_capabilities()
    local on_attach = function(client, bufnr)
      vim.api.nvim_buf_set_option(
        bufnr,
        'formatexpr',
        'v:lua.vim.lsp.formatexpr'
      )
      vim.api.nvim_buf_set_option(bufnr, 'tagfunc', 'v:lua.vim.lsp.tagfunc')

      local opts = { noremap = true, silent = true, buffer = bufnr }
      vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
      vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
      vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
      vim.keymap.set('n', 'g0', vim.lsp.buf.document_symbol, opts)
      vim.keymap.set('n', 'gW', vim.lsp.buf.workspace_symbol, opts)
      vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
      vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
      vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
      vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
      vim.keymap.set('i', '<C-k>', vim.lsp.buf.signature_help, opts)
      vim.keymap.set('n', 'gt', vim.lsp.buf.type_definition, opts)
      vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
      vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
      vim.keymap.set('n', 'gl', vim.diagnostic.open_float, opts)

      if client.supports_method('textDocument/documentHighlight') then
        vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
          buffer = bufnr,
          callback = function()
            vim.lsp.buf.document_highlight()
          end,
        })
        vim.api.nvim_create_autocmd('CursorMoved', {
          buffer = bufnr,
          callback = function()
            vim.lsp.util.buf_clear_references()
          end,
        })
      end
    end

    lspconfig.pyright.setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })
    lspconfig.tsserver.setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })
  end,
}
