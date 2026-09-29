-- Editor-wide mappings loaded on VeryLazy. Keep plugin mappings in their specs.

vim.keymap.set("n", "<leader>fN", function()
  local dir = vim.fn.expand("%:h")
  vim.ui.input({ prompt = "New file name: ", default = dir .. "/" }, function(input)
    if input and #input > 0 then
      vim.cmd("edit " .. vim.fn.fnameescape(input))
    end
  end)
end, { desc = "Create new file in same directory" })
