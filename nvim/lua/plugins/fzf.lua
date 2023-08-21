-- fuzzy search
return {
  'junegunn/fzf',
  version = '*',
  build = function()
    vim.fn['fzf#install']()
  end,
  dependencies = { 'vim-rooter' },
  keys = {
    {
      -- files
      '<C-p>',
      function()
        vim.cmd('FZF ' .. vim.fn.FindRootDirectory())
      end,
      silent = true,
    },
    {
      -- buffers
      '<C-n>',
      function()
        local files = {}
        for i = 1, vim.fn.bufnr('$') do
          if vim.fn.buflisted(i) then
            local file = vim.fn.bufname(i)
            if string.len(file) > 0 then
              table.insert(files, file)
            end
          end
        end
        vim.fn.FzfWrappedRun({
          source = files,
        })
      end,
      silent = true,
    },
    {
      -- recent
      '<C-e>',
      function()
        vim.fn.FzfWrappedRun({
          source = vim.v.oldfiles,
        })
      end,
      silent = true,
    },
  },
  config = function()
    vim.g.fzf_layout = { down = '~25%' }
    vim.env.FZF_DEFAULT_COMMAND = [[
      find . -type d \( -name node_modules -o -name .git -o -name .undodir \) -prune -o -print
    ]]

    -- can't use vim.fn because the sink/sinklist funcrefs are reset to vim.NIL
    vim.cmd([[
      fun! FzfWrappedRun(...)
        call fzf#run(call('fzf#wrap', a:000))
      endfun
    ]])
  end,
}
