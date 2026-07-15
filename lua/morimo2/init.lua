local M = {}

-- Applied unconditionally; kept in sync with groups/plugins/ by tests/run.lua.
M.integrations = { "cmp", "dap", "gitsigns", "nvim-notify" }

local config = { transparent = false }

---@param opts morimo2.Config?
function M.setup(opts)
  config = vim.tbl_extend("force", config, opts or {})
end

--- Entry point, called by colors/morimo2.lua.
function M.load()
  local C = require("morimo2.palette")

  vim.cmd("highlight clear")
  vim.g.colors_name = "morimo2"

  local hl = require("morimo2.groups.core")(C, config)
  for _, name in ipairs(M.integrations) do
    for group, attrs in pairs(require("morimo2.groups.plugins." .. name)(C)) do
      hl[group] = attrs
    end
  end
  if config.overrides then
    config.overrides(hl, C)
  end
  for group, attrs in pairs(hl) do
    vim.api.nvim_set_hl(0, group, attrs)
  end

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
end

return M
