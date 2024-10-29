local M = {}

local function highlight(group, properties)
  local bg = properties.bg == nil and '' or 'guibg=' .. properties.bg
  local fg = properties.fg == nil and '' or 'guifg=' .. properties.fg
  local style = properties.style == nil and '' or 'gui=' .. properties.style

  local cmd = table.concat({
    'highlight',
    group,
    bg,
    fg,
    style,
  }, ' ')
  local args = {}
  table.insert(args, group)
  if bg ~= '' then
    table.insert(args, bg)
  end
  if fg ~= '' then
    table.insert(args, fg)
  end
  if style ~= '' then
    table.insert(args, style)
  end
  -- vim.notify(vim.inspect(args), 1)
  vim.cmd.highlight { args = args, mods = { silent = true } }
end

function M.initialise(skeleton)
  for group, properties in pairs(skeleton) do
    highlight(group, properties)
  end
end

return M

