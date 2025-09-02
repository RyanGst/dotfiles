-- lua/plugins/bufferline.lua
return {
  {
    "akinsho/bufferline.nvim",
    optional = true, -- keep it optional as in LazyVim
    dependencies = { "catppuccin/nvim" }, -- ensure catppuccin is present
    opts = function(_, opts)
      local ok, cat = pcall(require, "catppuccin.groups.integrations.bufferline")
      if ok and type(cat.get) == "function" then
        opts.highlights = cat.get()
      else
        -- fallback: don't set highlights if integration isn't available yet
        -- opts.highlights = nil
      end
    end,
  },
}
