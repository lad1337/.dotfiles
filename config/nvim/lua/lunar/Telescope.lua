local C = require 'lunar.palette'
local Config = require 'lunar.config'

local Telescope = {
  TelescopeSelection = { fg = C.hint_blue },
  TelescopeMatching = { fg = C.info_yellow, style = 'bold' },
  TelescopeBorder = { fg = C.blue, bg = Config.transparent_background and 'NONE' or C.bg },
}

return Telescope

