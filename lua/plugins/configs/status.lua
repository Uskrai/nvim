
require("lualine").setup {
  options = {theme = "ayu"},
  sections = {
      lualine_c = {
          {
              'filename',
              path = 1
          },
      }
  }
}
