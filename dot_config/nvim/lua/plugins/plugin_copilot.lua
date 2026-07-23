return {
  "zbirenbaum/copilot.lua",
  cmd = "Copilot",
  event = "InsertEnter",
  requires = {
    "copilotlsp-nvim/copilot-lsp", -- (optional) for NES functionality
    init = function()
      vim.g.copilot_nes_debounce = 500
    end,
  },
  opts = {
    nes = {
      enabled = true,
      keymap = {
        accept = false,
        dismiss = "<Esc>",
      },
    },
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
