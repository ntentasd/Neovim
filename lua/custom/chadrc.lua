---@type ChadrcConfig
local M = {}
local set = vim.opt

-- General options
set.updatetime = 100
set.redrawtime = 1500
-- set.lazyredraw = true
set.timeout = true
set.ttimeout = true
set.timeoutlen = 500
set.ttimeoutlen = 10

M.ui = { theme = 'tokyonight' }
M.plugins = 'custom.plugins'
M.mappings = require "custom.mappings"
return M
