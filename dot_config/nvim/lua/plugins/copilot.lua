return {
  "zbirenbaum/copilot.lua",
  cmd = "Copilot",
  event = "InsertEnter",
  opts = {
    suggestion = {
      enabled = true,
      auto_trigger = true,
      keymap = {
        accept = "<Tab>", -- Most common
        next = "<C-n>",
        prev = "<C-p>",
        dismiss = "<C-e>",
      },
    },
    panel = { enabled = false },
  },
}
