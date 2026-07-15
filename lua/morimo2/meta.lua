---@meta
-- LuaCATS annotations only — never require()d at runtime.

---@class morimo2.Config
---Integrations to apply at load time (file names in lua/morimo2/groups/plugins/).
---Anything else can be applied later with require("morimo2").apply(name).
---@field plugins? table<string, boolean>
---Remove the editor background color.
---@field transparent? boolean
---Mutate the highlight table in place right before it is applied.
---Called for the core table and once per applied integration.
---@field overrides? fun(highlights: table<string, vim.api.keyset.highlight>, palette: table<string, string>)

---@type morimo2.Config?
vim.g.morimo2 = vim.g.morimo2
