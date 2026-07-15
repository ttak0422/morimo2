-- Run from the repo root: nvim --clean -l tests/run.lua
-- ponytail: plain assert script, no test framework on purpose.
vim.opt.runtimepath:prepend(vim.uv.cwd())

local C = require("morimo2.palette")

local palette_values = {}
for _, hex in pairs(C) do
  palette_values[hex] = true
end

-- Contract: fg/bg/sp must be a palette color or "NONE" (catches bare-string bugs
-- like v1's `FloatTitle = { fg = "lightBlue" }`); link must not mix with attrs.
local function check_attrs(where, group, attrs)
  for _, key in ipairs({ "fg", "bg", "sp" }) do
    local v = attrs[key]
    if v ~= nil then
      assert(
        v == "NONE" or palette_values[v],
        ("%s: %s.%s = %s is not a palette color"):format(where, group, key, tostring(v))
      )
    end
  end
  if attrs.link then
    assert(vim.tbl_count(attrs) == 1, ("%s: %s mixes link with other attrs"):format(where, group))
  end
end

-- core (both transparent modes)
for _, transparent in ipairs({ false, true }) do
  for group, attrs in pairs(require("morimo2.groups.core")(C, { transparent = transparent })) do
    check_attrs("core", group, attrs)
  end
end

-- plugin integrations: URL comment on line 1, return function(C) -> hl table
local plugin_names = {}
for file, kind in vim.fs.dir("lua/morimo2/groups/plugins") do
  assert(kind == "file" and file:match("%.lua$"), "unexpected entry in groups/plugins: " .. file)
  local first_line = assert(io.open("lua/morimo2/groups/plugins/" .. file)):read("l")
  assert(first_line:match("^%-%- https://"), file .. ": first line must be an upstream URL comment")
  local name = file:gsub("%.lua$", "")
  local fn = require("morimo2.groups.plugins." .. name)
  assert(type(fn) == "function", file .. ": must return a function")
  for group, attrs in pairs(fn(C)) do
    check_attrs(file, group, attrs)
  end
  table.insert(plugin_names, name)
end
assert(#plugin_names > 0, "no plugin integrations found")

-- smoke: colorscheme + vim.g config (plugins / overrides) actually take effect
vim.g.morimo2 = {
  plugins = { gitsigns = true },
  overrides = function(hl)
    hl.Comment = { fg = "#ff0000" }
  end,
}
vim.cmd.colorscheme("morimo2")
assert(vim.g.colors_name == "morimo2")
assert(vim.api.nvim_get_hl(0, { name = "Comment" }).fg == 0xff0000, "overrides hook was not applied")
assert(next(vim.api.nvim_get_hl(0, { name = "GitSignsAdd" })), "plugins config was not applied")
assert(vim.g.terminal_color_15 == C.fg0)

-- on-demand apply + persistence across colorscheme reload
for _, name in ipairs(plugin_names) do
  require("morimo2").apply(name)
end
vim.cmd.colorscheme("morimo2")
assert(next(vim.api.nvim_get_hl(0, { name = "CmpItemAbbrMatch" })), "applied integration lost on reload")

print("OK: core + " .. #plugin_names .. " integrations (" .. table.concat(plugin_names, ", ") .. ")")
