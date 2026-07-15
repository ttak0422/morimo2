local M = {}

-- Integrations applied so far; re-applied when the colorscheme reloads.
-- Module-local on purpose: writes to nested vim.g tables are silently dropped
-- (vim.g returns copies), which is exactly the bug morimo v1 had.
local loaded = {}

local function options()
  return vim.tbl_extend("force", { plugins = {}, transparent = false }, vim.g.morimo2 or {})
end

local function set(hl, C, opts)
  if opts.overrides then
    opts.overrides(hl, C)
  end
  for group, attrs in pairs(hl) do
    vim.api.nvim_set_hl(0, group, attrs)
  end
end

--- Apply an integration on demand, e.g. require("morimo2").apply("gitsigns").
--- Available names: files in lua/morimo2/groups/plugins/.
---@param name string
function M.apply(name)
  local C = require("morimo2.palette")
  set(require("morimo2.groups.plugins." .. name)(C), C, options())
  loaded[name] = true
end

--- Entry point, called by colors/morimo2.lua.
function M.load()
  local C = require("morimo2.palette")
  local opts = options()

  vim.cmd("highlight clear")
  vim.g.colors_name = "morimo2"

  set(require("morimo2.groups.core")(C, opts), C, opts)

  local terminal = {
    C.bg0,
    C.red,
    C.green,
    C.yellow,
    C.blue,
    C.magenta,
    C.cyan,
    C.fg1,
    C.grey3,
    C.lightRed,
    C.lightGreen,
    C.lightYellow,
    C.lightBlue,
    C.lightMagenta,
    C.lightCyan,
    C.fg0,
  }
  for i, color in ipairs(terminal) do
    vim.g["terminal_color_" .. (i - 1)] = color
  end

  for name, enabled in pairs(opts.plugins) do
    if enabled then
      loaded[name] = true
    end
  end
  for name in pairs(loaded) do
    M.apply(name)
  end
end

return M
