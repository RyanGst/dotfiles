-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--

local map = vim.keymap.set

map("n", "<leader>fN", function()
  local current_dir = vim.fn.expand("%:p:h") .. "/"
  vim.ui.input({ prompt = "New file name:", default = current_dir }, function(input)
    if input and input ~= "" then
      vim.cmd("e " .. input)
    end
  end)
end, { desc = "Create File in Buffer Dir" })

-- :lua vim.ui.open(vim.fn.expand('%'))

map("n", "<leader>fO", function()
  local current_file = vim.fn.expand("%")
  if current_file and current_file ~= "" then
    vim.ui.open(current_file)
  else
    print("No file to open in buffer directory.")
  end
end, { desc = "Open file" })
