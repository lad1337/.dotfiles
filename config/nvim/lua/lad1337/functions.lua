function split_definition_vertical()
  vim.lsp.buf_request(0, 'textDocument/definition', vim.lsp.util.make_position_params(nil, 'utf-16'), function(err, result, ctx, config)
    if err then
      print(err)
      return
    end
    if result == nil or (type(result) == 'table' and #result == 0) then
      vim.notify('No definition to open.', vim.log.levels.WARN)
      return
    end
    -- Close all floating windows (goto-preview windows)
    for _, win in ipairs(vim.api.nvim_list_wins()) do
      if vim.api.nvim_win_get_config(win).zindex ~= nil then
        pcall(vim.api.nvim_buf_del_keymap, vim.api.nvim_win_get_buf(win), 'n', 'q')
        vim.api.nvim_win_close(win, false)
      end
    end
    -- Handle both Location and LocationLink response formats
    local location = result[1] or result
    local uri = location.uri or location.targetUri
    local range = location.range or location.targetSelectionRange
    if not uri or not range then
      vim.notify('Invalid definition response', vim.log.levels.WARN)
      return
    end
    local command = 'vsplit ' .. vim.uri_to_fname(uri)
    local line = 'call cursor(' .. (range.start.line + 1) .. ',' .. (range.start.character + 1) .. ')'
    vim.cmd(command)
    vim.cmd(line)
  end)
end

vim.api.nvim_create_user_command('Mypy', function(args)
  local errorFile = '/tmp/mypy-errors'
  vim.cmd(string.format('silent !mypy --no-error-summary . > %s', errorFile))
  vim.cmd(string.format('silent cf %s', errorFile))
  vim.cmd 'cw'
  local qf_list = vim.fn.getqflist()
  print(string.format('Found %d error(s)', #qf_list))
end, {})
