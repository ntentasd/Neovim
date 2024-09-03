---@type ChadrcConfig
local M = {}
require(custom.options)
M.ui = { theme = 'catppuccin' }
M.plugins = 'custom.plugins'
M.mappings = require "custom.mappings"
return M
