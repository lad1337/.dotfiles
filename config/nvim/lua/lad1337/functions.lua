function split_definition_vertical()
  vim.lsp.buf_request(0, 'textDocument/definition', vim.lsp.util.make_position_params(nil, 'utf-16'), function(err, result, ctx, config)
    if err then
      print(err)
      return
    end
    if result == nil then
      vim.notify('No definition to open.', vim.log.levels.WARN)
      return
    end
    if vim.api.nvim_win_get_config(0).zindex ~= nil then -- are we in a floating window aka goto-preview
      vim.api.nvim_buf_del_keymap(0, 'n', 'q') -- remove the q to close
      vim.api.nvim_win_close(0, false) -- do not force
    end
    local command = 'vsplit ' .. vim.uri_to_fname(result[1].uri)
    local line = 'call cursor(' .. (result[1].range.start.line + 1) .. ',' .. (result[1].range.start.character + 1) .. ')'
    vim.cmd(command)
    vim.cmd(line)
  end)
end
