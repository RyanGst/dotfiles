-- bootstrap lazy.nvim, LazyVim and your plugins
if vim.env.VSCODE then
  vim.g.vscode = true
end

require("config.lazy")
