local M = {}

local _se_mappings = {
  duckduckgo = 'http://duckduckgo.com/?q=',
  google = 'http://google.com/?q=',
}

local _defaults = { se = 'google', }

local function base_url(se_mappings, se)
  local url = se_mappings[se]
  if url == nil then
    url = 'http://google.com/?q='
  end
  return url
end

local function trim(s)
  return (string.gsub(s, '^%s*(.-)%s*$', '%1'))
end

local function get_selection()
  -- Overwrites the z registry
  vim.cmd [[norm! gv"zy]]
  local selection = vim.fn.getreg('@z')
  return selection
end

local function setup_commands()
  vim.api.nvim_create_user_command('Searcher', function(_) M.search() end, { range = true })
  vim.api.nvim_create_user_command('SearcherEdit', function(_) M.search_edit() end, { range = true })
end

--Module
M._go = function(term)
  local url = string.gsub(M._conf.base_url .. trim(term), '\n', '  ')
  url = string.gsub(url, '"', '')
  local command = ':call netrw#BrowseX(\"' .. url .. '\", 1)'
  vim.cmd(command)
end

M.search = function()
  local selection = get_selection()
  M._go(selection)
end

M.search_edit = function()
  local selection = get_selection()
  vim.ui.input({ prompt = 'Search for: ', default = selection }, function(input)
    if input == nil then
      return
    end
    M._go(input)
  end)
end

M.setup = function(opts)
  M._conf = vim.tbl_deep_extend('force', _defaults, opts or {})
  if M._conf.base_url == nil then
    M._conf.base_url = base_url(_se_mappings, M._conf.se)
  end

  setup_commands()
end

return M
