-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set("n", "<leader>fN", function()
  local dir = vim.fn.expand("%:h")
  vim.ui.input({ prompt = "New file name: ", default = dir .. "/" }, function(input)
    if input and #input > 0 then
      vim.cmd("edit " .. vim.fn.fnameescape(input))
    end
  end)
end, { desc = "Create new file in same directory" })
