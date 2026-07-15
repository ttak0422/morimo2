---@meta
-- LuaCATS annotations only — never require()d at runtime.

---@class morimo2.Config
---Remove the editor background color.
---@field transparent? boolean
---Mutate the final merged highlight table in place before it is applied.
---@field overrides? fun(highlights: table<string, vim.api.keyset.highlight>, palette: table<string, string>)
