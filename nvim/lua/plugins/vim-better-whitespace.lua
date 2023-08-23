-- remove trailing whitespace
return {
  'ntpeters/vim-better-whitespace',
  event = 'VeryLazy',
  config = function()
    vim.keymap.set('n', '<C-s>', function()
      vim.cmd.StripWhitespace()
    end, { silent = true })
    vim.api.nvim_create_autocmd(
      'TermOpen',
      { pattern = '*', command = 'DisableWhitespace' }
    )
  end,
}
