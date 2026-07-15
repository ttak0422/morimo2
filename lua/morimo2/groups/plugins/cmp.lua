-- https://github.com/hrsh7th/nvim-cmp
return function(C)
  return {
    CmpItemAbbr = { link = "Pmenu" },
    CmpItemAbbrDeprecated = { fg = C.grey1, strikethrough = true },
    CmpItemAbbrMatch = { fg = C.fg0, bold = true },
    CmpItemAbbrMatchFuzzy = { link = "CmpItemAbbr" },
    CmpItemMenu = { link = "Pmenu" },
  }
end
