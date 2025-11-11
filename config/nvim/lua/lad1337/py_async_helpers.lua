-- asyncify current Python function
local function make_async()
  local row, col = unpack(vim.api.nvim_win_get_cursor(0))
  -- search backwards for "def"
  local found = vim.fn.search('^\\s*def\\s\\+\\w\\+', 'bW')
  if found == 0 then
    vim.api.nvim_echo({ { 'No Python function definition found above', 'ErrorMsg' } }, false, {})
    vim.api.nvim_win_set_cursor(0, { row, col })
    return
  end
  local line = vim.api.nvim_get_current_line()
  if line:match '^%s*async%s+def%s' then
    vim.api.nvim_echo({ { 'Already async', 'Comment' } }, false, {})
  else
    -- compute indent
    local indent = line:match '^%s*'
    -- replace line
    local new = indent .. 'async ' .. line:sub(#indent + 1)
    vim.api.nvim_set_current_line(new)
  end
  -- restore cursor
  vim.api.nvim_win_set_cursor(0, { row, col })
end

-- Toggle `await ` after the first `=` if there is one,
-- otherwise at the start of the (indented) line
local function make_line_await()
  make_async()
  -- save cursor
  local row, col = unpack(vim.api.nvim_win_get_cursor(0))
  local line = vim.api.nvim_get_current_line()
  local indent = line:match '^%s*' or ''

  local prefix, suffix = line:match '^(.-=)(.*)$'
  if prefix then
    -- Found "=", operate on suffix
    -- Detect existing await
    local has_await = suffix:match '^%s*await%s+'
    if has_await then
      -- remove await
      local rest = suffix:gsub('^%s*await%s+', '', 1)
      vim.api.nvim_set_current_line(prefix .. rest)
    else
      -- insert await
      local rest = suffix:match '^%s*(.*)$'
      vim.api.nvim_set_current_line(prefix .. ' await ' .. rest)
    end
  else
    -- No "=", operate on whole line
    local content = line:sub(#indent + 1)
    if content:match '^await%s+' then
      -- remove await
      local rest = content:gsub('^await%s+', '', 1)
      vim.api.nvim_set_current_line(indent .. rest)
    else
      -- insert await
      vim.api.nvim_set_current_line(indent .. 'await ' .. content)
    end
  end

  -- restore cursor
  vim.api.nvim_win_set_cursor(0, { row, col })
end

-- Map <Leader>a to that function
vim.keymap.set('n', '<leader>A', make_async, { silent = true, desc = 'Make current Python func async' })
-- map <Leader>w to it
vim.keymap.set('n', '<leader>a', make_line_await, {
  silent = true,
  desc = 'Make current line await after =',
})
