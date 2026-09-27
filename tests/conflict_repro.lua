-- Integration regression test for git-conflict.nvim. Run in a TUI with
-- GIT_CONFLICT_RUNTIME set to the plugin's runtime directory.
-- nvim --clean -c 'set rtp+=.' -c 'luafile tests/conflict_repro.lua' -c 'qa!'
vim.opt.runtimepath:prepend(vim.uv.cwd())
vim.opt.runtimepath:append(assert(vim.env.GIT_CONFLICT_RUNTIME))
vim.o.termguicolors = false

local function git(root, args, stdin)
  local command = { "git", "-C", root }
  vim.list_extend(command, args)
  local result = vim.system(command, { stdin = stdin, text = true }):wait()
  assert(result.code == 0, result.stderr)
  return (result.stdout or ""):gsub("%s+$", "")
end

local root = vim.fn.tempname()
vim.fn.mkdir(root, "p")
git(root, { "init", "--quiet" })
local base = git(root, { "hash-object", "-w", "--stdin" }, "base\n")
local ours = git(root, { "hash-object", "-w", "--stdin" }, "ours\n")
local theirs = git(root, { "hash-object", "-w", "--stdin" }, "theirs\n")
git(
  root,
  { "update-index", "--index-info" },
  table.concat({
    "100644 " .. base .. " 1\tconflict.txt",
    "100644 " .. ours .. " 2\tconflict.txt",
    "100644 " .. theirs .. " 3\tconflict.txt",
    "",
  }, "\n")
)

local filename = root .. "/conflict.txt"
vim.fn.writefile({
  "<<<<<<< HEAD",
  "ours",
  "||||||| base",
  "base",
  "=======",
  "theirs",
  ">>>>>>> incoming",
}, filename)
vim.cmd.colorscheme("morimo2")
local conflicts = require("git-conflict")
conflicts.setup()
vim.cmd("cd " .. vim.fn.fnameescape(root))
vim.cmd("edit " .. vim.fn.fnameescape(filename))
local detected = false
vim.wait(3000, function()
  vim.cmd.redraw()
  local ok, count = pcall(conflicts.conflict_count, 0)
  detected = ok and count == 1
  return detected
end, 10)
assert(detected, "git-conflict.nvim did not parse fixture")

for _, name in ipairs({ "GitConflictCurrent", "GitConflictIncoming", "GitConflictAncestor" }) do
  local attrs = vim.api.nvim_get_hl_by_name(name, false)
  assert(attrs.background, name .. " has no terminal background")
end

vim.fn.delete(root, "rf")
