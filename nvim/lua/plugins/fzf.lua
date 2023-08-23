local ok, local_keys = pcall(require, 'local.fzf-keys')

-- fuzzy search
return {
  'junegunn/fzf',
  version = '*',
  build = function()
    vim.fn['fzf#install']()
  end,
  dependencies = { 'vim-rooter' },
  keys = vim.tbl_values(vim.tbl_deep_extend('keep', ok and local_keys or {}, {
    files = {
      '<C-p>',
      function()
        vim.cmd('FZF ' .. vim.fn.FindRootDirectory())
      end,
      silent = true,
    },
    buffers = {
      '<C-n>',
      function()
        local numbers = {}
        for i = 1, vim.fn.bufnr('$') do
          table.insert(numbers, i)
        end

        local listed = vim.tbl_filter(vim.fn.buflisted, numbers)
        local names = vim.tbl_map(vim.fn.bufname, listed)
        local non_empty = vim.tbl_filter(function(name)
          return string.len(name) > 0
        end, names)

        vim.fn.FzfWrappedRun({
          source = non_empty,
        })
      end,
      silent = true,
    },
    recent = {
      '<C-e>',
      function()
        local list = vim.v.oldfiles

        -- remove tmp files (created by vim for merge conflicts)
        list = vim.tbl_filter(function(file)
          return not string.match(file, '^/tmp/')
        end, list)

        -- remove non-existent files
        list = vim.tbl_filter(function(file)
          return vim.loop.fs_stat(file)
        end, list)

        vim.fn.FzfWrappedRun({
          source = list,
        })
      end,
      silent = true,
    },
  })),
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
