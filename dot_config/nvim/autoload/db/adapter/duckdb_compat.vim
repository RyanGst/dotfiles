function! db#adapter#duckdb_compat#canonicalize(url) abort
  return db#adapter#duckdb#canonicalize(a:url)
endfunction

function! db#adapter#duckdb_compat#test_file(file) abort
  return db#adapter#duckdb#test_file(a:file)
endfunction

function! db#adapter#duckdb_compat#dbext(url) abort
  return db#adapter#duckdb#dbext(a:url)
endfunction

function! db#adapter#duckdb_compat#command(url) abort
  return db#adapter#duckdb#command(a:url)
endfunction

function! db#adapter#duckdb_compat#interactive(url) abort
  return db#adapter#duckdb#interactive(a:url)
endfunction

function! db#adapter#duckdb_compat#tables(url) abort
  let query = "select table_name from information_schema.tables where table_schema not in ('information_schema', 'pg_catalog') order by table_name"
  return db#systemlist(db#adapter#duckdb#command(a:url) + ['-csv', '-noheader', '-c', query])
endfunction

function! db#adapter#duckdb_compat#massage(input) abort
  return db#adapter#duckdb#massage(a:input)
endfunction
