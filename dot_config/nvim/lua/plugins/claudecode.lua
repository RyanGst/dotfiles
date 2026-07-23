return {
  "coder/claudecode.nvim",
  enabled = true,
  dependencies = { "folke/snacks.nvim" },
  lazy = false,
  opts = {
    auto_start = true,
    terminal = {
      provider = "none",
    },
  },
  keys = {
    { "<leader>ab", "<cmd>ClaudeCodeAdd %<cr>", desc = "Add buffer to Claude" },
    { "<leader>as", "<cmd>ClaudeCodeSend<cr>", mode = "v", desc = "Send selection to Claude" },
    { "<leader>aa", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "Accept Claude diff" },
    { "<leader>ad", "<cmd>ClaudeCodeDiffDeny<cr>", desc = "Deny Claude diff" },
  },
}
