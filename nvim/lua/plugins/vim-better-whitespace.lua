-- remove trailing whitespace
return {
  'ntpeters/vim-better-whitespace',
  event = 'VeryLazy',
  config = function()
    vim.keymap.set('n', '<C-s>', function()
      vim.cmd.StripWhitespace()
    end, { silent = true })
  end,
}
