return {
  "f4z3r/gruvbox-material.nvim",
  lazy = false,
  name = "gruvbox-material",
  opts = {},
  priority = 1000, -- load this before all the other start plugins
  config = function()
    local colors = require("gruvbox-material.colors").get(vim.o.background, "hard")

    require("gruvbox-material").setup({
      contrast = "hard",
      customize = function(g, o)
        if o.bg == colors.bg0 then
          o.bg = "#101314"
        end
        return o
      end,
    })
  end,
  ,
}
