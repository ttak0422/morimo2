-- https://github.com/lewis6991/gitsigns.nvim
return function(C)
  return {
    GitSignsAdd = { fg = C.lightGreen },
    GitSignsChange = { fg = C.lightBlue },
    GitSignsDelete = { fg = C.lightRed },
  }
end
