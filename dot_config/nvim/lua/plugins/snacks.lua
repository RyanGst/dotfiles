---@module 'lazy'

return {
  {
    "snacks.nvim",
    ---@type snacks.Config
    opts = {
      dashboard = {
        preset = {
          header = "",
        },
      },
      statuscolumn = { folds = { open = false } },
      notifier = { sort = { "added" } },
      scroll = { debug = false },
      image = {
        force = false,
        enabled = true,
        debug = { request = false, convert = false, placement = false },
        math = { enabled = true },
        doc = { inline = true, float = true },
      },
      picker = {
        previewers = {
          diff = { builtin = false },
          git = { builtin = false },
        },
        hidden = true,
        ignored = true,
        exclude = { "node_modules", "vendor" },
        sources = {
          explorer = {
            layout = {
              preset = "right",
              preview = false,
            },
            win = {
              list = {
                keys = {
                  ["<C-l>"] = "tmux_navigate_right",
                },
              },
            },
          },
          files_with_symbols = {
            multi = { "files", "lsp_symbols" },
            filter = {
              ---@param p snacks.Picker
              ---@param filter snacks.picker.Filter
              transform = function(p, filter)
                local symbol_pattern = filter.pattern:match("^.-@(.*)$")
                -- store the current file buffer
                if filter.source_id ~= 2 then
                  local item = p:current()
                  if item and item.file then
                    filter.meta.buf = vim.fn.bufadd(item.file)
                  end
                end

                if symbol_pattern and filter.meta.buf then
                  filter.pattern = symbol_pattern
                  filter.current_buf = filter.meta.buf
                  filter.source_id = 2
                else
                  filter.source_id = 1
                end
              end,
            },
          },
        },
        actions = {
          yankit = { action = "yank", notify = true },
          tmux_navigate_right = function()
            local pane = vim.env.TMUX_PANE
            if pane and pane ~= "" then
              vim.fn.system({ "tmux", "select-pane", "-t", pane, "-R" })
            end
          end,
          toggle_lua = function(p)
            local opts = p.opts --[[@as snacks.picker.grep.Config]]
            opts.ft = not opts.ft and "lua" or nil
            p:find()
          end,
        },
      },
      indent = {
        chunk = { enabled = true },
      },
    },
    -- stylua: ignore
    keys = {
      { "<leader><space>", function() Snacks.picker.smart() end, desc = "Smart Open" },
      { "<leader>dd", function() Snacks.picker.grep({search = "^(?!\\s*--).*\\b(bt|dd)\\(", args = {"-P"}, live = false, ft = "lua"}) end, desc = "Debug Searcher" },
      { "<leader>t", function() Snacks.scratch({ icon = " ", name = "Todo", ft = "markdown", file = "~/dot/TODO.md" }) end, desc = "Todo List" },
      { "<leader>ct", function() local dir = vim.fn.expand("%:p:h") if dir == "" or vim.bo.buftype ~= "" then dir = vim.fn.getcwd() end Snacks.terminal(nil, { cwd = dir }) end, desc = "Terminal (file dir)" },
   },
  },
}
