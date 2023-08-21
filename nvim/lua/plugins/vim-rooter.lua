-- project root working directory
return {
  'airblade/vim-rooter',
  lazy = true,
  config = function()
    vim.g.rooter_manual_only = 1
    pcall(require, 'local.vim-rooter')
  end,
}
