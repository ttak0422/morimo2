-- Regenerate extras/ from the palette. Run from the repo root: nvim --clean -l scripts/build.lua
vim.opt.runtimepath:prepend(vim.uv.cwd())

local C = require("morimo2.palette")

local function render(template)
  return (template:gsub("%${(%w+)}", function(key)
    return assert(C[key], "unknown palette key: " .. key)
  end))
end

local extras = {
  ["extras/wezterm/morimo2.lua"] = [[
return {
  colors = {
    foreground = "${fg0}",
    background = "${bg0}",

    cursor_bg = "${fg1}",
    cursor_fg = "${fg1}",
    cursor_border = "${fg1}",

    selection_fg = "${fg1}",
    selection_bg = "${cyan}",

    scrollbar_thumb = "${bg1}",
    split = "${bg1}",

    ansi = { "${bg0}", "${red}", "${green}", "${yellow}", "${blue}", "${magenta}", "${cyan}", "${fg1}" },
    brights = { "${grey3}", "${lightRed}", "${lightGreen}", "${lightYellow}", "${lightBlue}", "${lightMagenta}", "${lightCyan}", "${fg0}" },
  },
}
]],
  ["extras/zellij/morimo2.kdl"] = [[
themes {
    morimo2 {
        fg "${fg0}"
        bg "${grey0}"
        red "${red}"
        green "${green}"
        yellow "${yellow}"
        blue "${blue}"
        magenta "${magenta}"
        orange "${orange}"
        cyan "${cyan}"
        black "${bg0}"
        white "${fg1}"
    }
}
]],
  ["extras/ghostty/morimo2"] = [[
palette = 0=${bg0}
palette = 1=${red}
palette = 2=${green}
palette = 3=${yellow}
palette = 4=${blue}
palette = 5=${magenta}
palette = 6=${cyan}
palette = 7=${fg1}
palette = 8=${grey3}
palette = 9=${lightRed}
palette = 10=${lightGreen}
palette = 11=${lightYellow}
palette = 12=${lightBlue}
palette = 13=${lightMagenta}
palette = 14=${lightCyan}
palette = 15=${fg0}
background = ${bg0}
foreground = ${fg0}
cursor-color = ${fg1}
selection-background = ${cyan}
selection-foreground = ${fg1}
]],
}

for path, template in pairs(extras) do
  vim.fn.mkdir(vim.fs.dirname(path), "p")
  local f = assert(io.open(path, "w"))
  f:write(render(template))
  f:close()
  print("generated " .. path)
end
