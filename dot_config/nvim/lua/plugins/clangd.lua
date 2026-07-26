local function matches(pattern)
  local paths = vim.fn.glob(pattern, false, true)
  table.sort(paths)
  return paths
end

local home = assert(vim.env.HOME)
local esp_clangd_matches = matches(home .. "/.espressif/tools/esp-clang/*/esp-clang/bin/clangd")
local esp_clangd = esp_clangd_matches[#esp_clangd_matches]
local query_drivers = vim.list_extend(
  matches(home .. "/.espressif/tools/xtensa-esp-elf/*/xtensa-esp-elf/bin/*-gcc"),
  matches(home .. "/.espressif/tools/riscv32-esp-elf/*/riscv32-esp-elf/bin/*-gcc")
)

local cmd = {
  esp_clangd or "clangd",
  "--background-index",
  "--clang-tidy",
  "--header-insertion=iwyu",
  "--completion-style=detailed",
  "--function-arg-placeholders",
  "--fallback-style=llvm",
}

if #query_drivers > 0 then
  table.insert(cmd, "--query-driver=" .. table.concat(query_drivers, ","))
end

local server = {
  cmd = cmd,
  root_markers = {
    ".clangd",
    "compile_commands.json",
    "compile_flags.txt",
    "CMakeLists.txt",
    ".git",
  },
  capabilities = {
    offsetEncoding = { "utf-16" },
  },
  init_options = {
    usePlaceholders = true,
    completeUnimported = true,
    clangdFileStatus = true,
  },
}

if esp_clangd then
  server.mason = false
end

return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        clangd = server,
      },
    },
  },
}
