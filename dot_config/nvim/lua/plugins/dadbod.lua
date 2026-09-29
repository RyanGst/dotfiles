return {
  {
    "tpope/vim-dadbod",
    init = function()
      vim.g.dbs = {
        masters = "duckdb:" .. vim.fn.expand("~/Documents/my-void/Mestrado/mestrado-2027.duckdb"),
      }

      -- DuckDB 1.5 renders `.tables` as a rich table, which Dadbod cannot parse.
      vim.g.db_adapter_duckdb = "db#adapter#duckdb_compat#"
    end,
  },
}
