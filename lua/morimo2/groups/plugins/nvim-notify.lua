-- https://github.com/rcarriga/nvim-notify
return function(C)
  return {
    NotifyERRORBorder = { fg = C.darkRed },
    NotifyWARNBorder = { fg = C.darkYellow },
    NotifyINFOBorder = { fg = C.darkBlue },
    NotifyDEBUGBorder = { fg = C.darkCyan },
    NotifyTRACEBorder = { fg = C.darkCyan },
    NotifyERRORIcon = { fg = C.red },
    NotifyWARNIcon = { fg = C.yellow },
    NotifyINFOIcon = { fg = C.blue },
    NotifyDEBUGIcon = { fg = C.cyan },
    NotifyTRACEIcon = { fg = C.cyan },
    NotifyERRORTitle = { fg = C.red },
    NotifyWARNTitle = { fg = C.yellow },
    NotifyINFOTitle = { fg = C.blue },
    NotifyDEBUGTitle = { fg = C.cyan },
    NotifyTRACETitle = { fg = C.cyan },
    NotifyERRORBody = { link = "Normal" },
    NotifyWARNBody = { link = "Normal" },
    NotifyINFOBody = { link = "Normal" },
    NotifyDEBUGBody = { link = "Normal" },
    NotifyTRACEBody = { link = "Normal" },
  }
end
