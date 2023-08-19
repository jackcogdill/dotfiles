-- fuzzy search
return {
  'junegunn/fzf',
  version = '*',
  build = ':call fzf#install()',
  dependencies = { 'vim-rooter' },
  keys = {
    {
      -- files
      '<C-p>',
      ":exe 'FZF ' . FindRootDirectory()<CR>",
      silent = true,
    },
    {
      -- buffers
      '<C-n>',
      ":call fzf#run(fzf#wrap({ 'source': filter(map(filter(range(1, bufnr('$')), {_, v -> buflisted(v)}), {_, v -> bufname(v)}), {_, v -> len(v) > 0}) }))<CR>",
      silent = true,
    },
    {
      -- recent
      '<C-e>',
      ":call fzf#run(fzf#wrap({ 'source': v:oldfiles }))<CR>",
      silent = true,
    },
  },
  config = function()
    vim.g.fzf_layout = { down = '~25%' }
    vim.cmd([[
      let $FZF_DEFAULT_COMMAND = 'find .
            \ -type d \(
            \ -name node_modules
            \ -o -name .git
            \ -o -name .undodir
            \ \)
            \ -prune -o -print'
    ]])
  end,
}
