local ok, mod = pcall(require, 'local.mod.vim-rooter')

-- project root working directory
return {
  'airblade/vim-rooter',
  lazy = true,
  config = function()
    vim.g.rooter_manual_only = 1
    if ok then
      mod.config()
    end
  end,
}
