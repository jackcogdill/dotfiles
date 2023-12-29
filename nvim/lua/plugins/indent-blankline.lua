-- indentation guides
return {
  'lukas-reineke/indent-blankline.nvim',
  version = '*',
  event = 'VeryLazy',
  opts = {
    indent = {
      char = '│',
    },
  },
  config = function(_, opts)
    require('ibl').setup(opts)
    vim.cmd.highlight({
      'link @ibl.scope.underline.1 IndentBlanklineContextStart',
      bang = true,
    })
  end,
}
