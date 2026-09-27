-- https://github.com/akinsho/git-conflict.nvim
return function(C)
  -- git-conflict.nvim's default=true groups are RGB-only. Define both color
  -- paths so conflict sections and marker labels remain visible without truecolor.
  local current = { fg = C.bg0, bg = C.fg0, ctermfg = 236, ctermbg = 151 }
  local incoming = { fg = C.fg0, bg = C.sub_green0, ctermfg = 151, ctermbg = 22 }
  local ancestor = { fg = C.fg0, bg = C.sub_blue0, ctermfg = 151, ctermbg = 24 }

  return {
    GitConflictCurrent = current,
    GitConflictIncoming = incoming,
    GitConflictAncestor = ancestor,
    GitConflictCurrentLabel = {
      fg = current.fg,
      bg = current.bg,
      ctermfg = current.ctermfg,
      ctermbg = current.ctermbg,
      bold = true,
    },
    GitConflictIncomingLabel = {
      fg = incoming.fg,
      bg = incoming.bg,
      ctermfg = incoming.ctermfg,
      ctermbg = incoming.ctermbg,
      bold = true,
    },
    GitConflictAncestorLabel = {
      fg = ancestor.fg,
      bg = ancestor.bg,
      ctermfg = ancestor.ctermfg,
      ctermbg = ancestor.ctermbg,
      bold = true,
    },
  }
end
