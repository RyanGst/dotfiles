return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    opts = {
      flavour = "latte",
      background = {
        light = "latte",
        dark = "latte",
      },
      custom_highlights = function(colors)
        return {
          -- Snacks uses CursorLine for the selected explorer entry while the
          -- editor window is focused.
          CursorLine = { bg = colors.surface0, bold = true },
        }
      end,
    },
  },
}
