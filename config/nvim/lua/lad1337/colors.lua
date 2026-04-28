-- Custom color palette
-- Reads from environment variables (set in .zshrc)

local M = {}

M.fg = vim.env.COLOR_FG or '#cdd6f4'
M.magenta = vim.env.COLOR_MAGENTA or '#ff0e82'
M.magenta2 = vim.env.COLOR_MAGENTA2 or '#900048'
M.cyan = vim.env.COLOR_CYAN or '#00ffb7'
M.purple = vim.env.COLOR_PURPLE or '#cba6f7'
M.yellow = vim.env.COLOR_YELLOW or '#EDFF00'
M.error = '#ff0000'

-- Semantic assignments
M.directory = vim.env.COLOR_DIRECTORY or M.cyan
M.executable = vim.env.COLOR_EXECUTABLE or M.magenta
M.git_modified = M.yellow
M.string = M.purple
M.command = M.cyan
M.keyword = M.magenta
M.selection_bg = M.magenta2

return M
