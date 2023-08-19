-- remove trailing whitespace
return {
  'ntpeters/vim-better-whitespace',
  event = 'VeryLazy',
  config = function()
    vim.keymap.set(
      'n',
      '<C-s>',
      ':silent :StripWhitespace<CR>',
      { silent = true }
    )
  end,
}
