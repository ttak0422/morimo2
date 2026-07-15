<h1 align="center">morimo2</h1>
<div align="center">
  <p>Performance-focused Neovim colorscheme designed for colorblind users.</p>
</div>

Successor of [morimo](https://github.com/ttak0422/morimo), rewritten in pure Lua.

## Requirements

[Neovim (v0.10+)](https://github.com/neovim/neovim)

## Features

- **Colorblind-Friendly**: Accessible for users with color blindness.
- **Zero-Config**: `:colorscheme morimo2` just works; `setup()` is optional.
- **Borderless Compatibility**: Optimized for `border=none` settings, ensuring a clean appearance.

## Usage

```lua
vim.cmd.colorscheme("morimo2")
```

Optionally configure before loading:

```lua
require("morimo2").setup({
  -- Remove the editor background color.
  transparent = false,
  -- Mutate the final highlight table in place before it is applied.
  overrides = function(hl, palette)
    hl.Comment = { fg = palette.grey2 }
  end,
})
vim.cmd.colorscheme("morimo2")
```

## Integrations

Always applied. Treesitter captures and diagnostics are part of the core.

- [nvim-cmp (cmp)](https://github.com/hrsh7th/nvim-cmp)
- [gitsigns.nvim (gitsigns)](https://github.com/lewis6991/gitsigns.nvim)
- [nvim-dap-ui (dap)](https://github.com/rcarriga/nvim-dap-ui)
- [nvim-notify (nvim-notify)](https://github.com/rcarriga/nvim-notify)

## Extras

Generated from the palette by `nvim -l scripts/build.lua`:

- [WezTerm](extras/wezterm/morimo2.lua)
- [Zellij](extras/zellij/morimo2.kdl)
- [Ghostty](extras/ghostty/morimo2)
