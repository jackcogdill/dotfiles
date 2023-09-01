return {
  on_attach = function(client, bufnr) end,
  config = function(capabilities, on_attach)
    local lspconfig = require('lspconfig')
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
