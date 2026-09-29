return {
  "nickjvandyke/opencode.nvim",
  dependencies = {
    {
      ---@module "snacks"
      "folke/snacks.nvim",
      optional = true,
      opts = {
        input = {},
        picker = {
          actions = {
            opencode_send = function(picker)
              local items = vim.tbl_map(function(item)
                return item.file
                    and require("opencode").format({ path = item.file, from = item.pos, to = item.end_pos })
                  or item.text
              end, picker:selected({ fallback = true }))

              require("opencode").prompt(table.concat(items, ", ") .. " ")
            end,
          },
          win = {
            input = {
              keys = {
                ["<a-a>"] = { "opencode_send", mode = { "n", "i" } },
              },
            },
          },
        },
      },
    },
  },
  config = function()
    ---@type opencode.Opts
    vim.g.opencode_opts = {
      server = {
        start = false,
      },
    }

    vim.o.autoread = true

    local function focus_opencode_pane()
      if not vim.env.TMUX_PANE then
        vim.notify("Not inside tmux", vim.log.levels.WARN)
        return
      end

      local panes =
        vim.fn.systemlist({ "tmux", "list-panes", "-t", vim.env.TMUX_PANE, "-F", "#{pane_id} #{pane_current_command}" })
      if vim.v.shell_error ~= 0 then
        vim.notify("Could not list tmux panes", vim.log.levels.ERROR)
        return
      end

      for _, line in ipairs(panes) do
        local pane, command = line:match("^(%%%d+) (.+)$")
        if command == "opencode" or command == "opencode-cli" then
          vim.fn.system({ "tmux", "select-pane", "-t", pane })
          if vim.v.shell_error ~= 0 then
            vim.notify("Could not focus OpenCode pane", vim.log.levels.ERROR)
          end
          return
        end
      end

      vim.notify("No OpenCode pane in this tmux window", vim.log.levels.WARN)
    end

    vim.keymap.set({ "n", "x" }, "<C-a>", function()
      require("opencode").ask("@this: ")
    end, { desc = "Ask opencode…" })
    vim.keymap.set({ "n", "x" }, "<C-x>", function()
      require("opencode").select()
    end, { desc = "Execute opencode action…" })
    vim.keymap.set({ "n", "t" }, "<C-.>", focus_opencode_pane, { desc = "Focus OpenCode tmux pane" })

    vim.keymap.set({ "n", "x" }, "go", function()
      return require("opencode").operator("@this ")
    end, { desc = "Add range to opencode", expr = true })
    vim.keymap.set("n", "goo", function()
      return require("opencode").operator("@this ") .. "_"
    end, { desc = "Add line to opencode", expr = true })

    vim.keymap.set("n", "<S-C-u>", function()
      require("opencode").command("session.half.page.up")
    end, { desc = "Scroll opencode up" })
    vim.keymap.set("n", "<S-C-d>", function()
      require("opencode").command("session.half.page.down")
    end, { desc = "Scroll opencode down" })

    -- Keep increment/decrement available when opencode owns <C-a>/<C-x>.
    vim.keymap.set("n", "+", "<C-a>", { desc = "Increment under cursor", noremap = true })
    vim.keymap.set("n", "-", "<C-x>", { desc = "Decrement under cursor", noremap = true })
  end,
}
