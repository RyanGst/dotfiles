return {
  "obsidian-nvim/obsidian.nvim",
  version = "*", -- recommended, use latest release instead of latest commit
  ft = "markdown",
  ---@module 'obsidian'
  ---@type obsidian.config
  opts = {
    workspaces = {
      {
        name = "research",
        path = "~/Developer/ryangst/research",
      },
    },
    daily_notes = {
      folder = "daily",
    },
  },
}
