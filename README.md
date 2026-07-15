<h1 align="center">morimo2</h1>
<div align="center">
  <p>Performance-focused Neovim colorscheme designed for colorblind users.</p>
</div>

Successor of [morimo](https://github.com/ttak0422/morimo), rewritten in pure Lua.

## Requirements

[Neovim (v0.10+)](https://github.com/neovim/neovim)

## Features

- **Colorblind-Friendly**: Accessible for users with color blindness.
- **Performance-Oriented**: Eager core, on-demand integrations. Integrations you don't apply are never read from disk. No cache, no compile step — nothing to invalidate.
- **Borderless Compatibility**: Optimized for `border=none` settings, ensuring a clean appearance.

## Usage

```lua
-- optional configuration (must be set before :colorscheme)
vim.g.morimo2 = {
  -- Integrations applied at startup.
  plugins = { gitsigns = true },
  -- Remove the editor background color.
  transparent = false,
  -- Mutate highlight tables in place before they are applied.
  -- Called once for the core table and once per applied integration,
  -- so assign whole groups; don't read-modify keys that may be absent.
  overrides = function(hl, palette)
    hl.Comment = { fg = palette.grey2 }
  end,
}
vim.cmd.colorscheme("morimo2")
```

Integrations can also be applied on demand, which pairs well with lazy.nvim:

```lua
{
  "lewis6991/gitsigns.nvim",
  config = function()
    require("morimo2").apply("gitsigns")
    require("gitsigns").setup()
  end,
}
```

## Integrations

Treesitter captures and diagnostics are part of the core — no integration needed.

- [nvim-cmp (cmp)](https://github.com/hrsh7th/nvim-cmp)
- [gitsigns.nvim (gitsigns)](https://github.com/lewis6991/gitsigns.nvim)
- [nvim-dap-ui (dap)](https://github.com/rcarriga/nvim-dap-ui)
- [nvim-notify (nvim-notify)](https://github.com/rcarriga/nvim-notify)

## Extras

Generated from the palette by `nvim -l scripts/build.lua`:

- [WezTerm](extras/wezterm/morimo2.lua)
- [Zellij](extras/zellij/morimo2.kdl)
- [Ghostty](extras/ghostty/morimo2)
