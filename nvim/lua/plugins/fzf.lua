local ok, mod = pcall(require, 'local.mod.fzf')

local function ordered_dedup(list)
  local d = {}
  return vim.tbl_filter(function(item)
    if d[item] then
      return false
    end
    d[item] = 1
    return true
  end, list)
end

local function get_buffers()
  local handles = vim.api.nvim_list_bufs()
  local names = vim.tbl_map(vim.fn.bufname, handles)
  local non_empty = vim.tbl_filter(function(name)
    return string.len(name) > 0
  end, names)

  return non_empty
end

local function get_oldfiles()
  local list = vim.v.oldfiles

  -- custom filtering
  if ok and mod.filters and mod.filters.oldfiles then
    list = mod.filters.oldfiles(list)
  end

  -- remove tmp files (created by vim for merge conflicts)
  list = vim.tbl_filter(function(file)
    return not string.match(file, '^/tmp/')
  end, list)

  return list
end

local function recent()
  local combined = vim.list_extend(get_oldfiles(), get_buffers())
  local uniq = ordered_dedup(combined)
  vim.fn.FzfWrappedRun({
    source = uniq,
    options = { '--header', '[Recent]' },
  })
end

local function buffers()
  vim.fn.FzfWrappedRun({
    source = get_buffers(),
    options = { '--header', '[Buffers]' },
  })
end

local function files()
  vim.cmd('FZF ' .. vim.fn.FindRootDirectory())
end

-- fuzzy search
return {
  'junegunn/fzf',
  version = '*',
  build = function()
    vim.fn['fzf#install']()
  end,
  dependencies = { 'vim-rooter' },
  keys = vim.list_extend({
    { '<C-p>', files, silent = true },
    { '<C-b>', buffers, silent = true },
    { '<C-e>', recent, silent = true },
  }, ok and mod.keys or {}),
  config = function()
    vim.g.fzf_layout = {
      window = { width = 0.9, height = 0.6 },
    }
    vim.g.fzf_colors = {
      fg = { 'fg', 'NormalFloat' },
      bg = { 'bg', 'NormalFloat' },
      border = { 'fg', 'FloatBorder' },
    }
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
