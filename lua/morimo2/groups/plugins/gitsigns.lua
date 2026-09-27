-- https://github.com/lewis6991/gitsigns.nvim
return function(C)
  return {
    -- xterm-256 fallbacks for TUI setups without termguicolors.
    GitSignsAdd = { fg = C.lightGreen, ctermfg = 114 },
    GitSignsChange = { fg = C.lightBlue, ctermfg = 110 },
    GitSignsDelete = { fg = C.lightRed, ctermfg = 203 },
  }
end
