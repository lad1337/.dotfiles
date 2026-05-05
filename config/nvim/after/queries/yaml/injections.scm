; extends

; Inject SQL highlighting for keys named "sql" or "query"
((block_mapping_pair
  key: (flow_node
    (plain_scalar
      (string_scalar) @_key))
  value: (block_node
    (block_scalar) @injection.content))
  (#any-of? @_key "sql" "query")
  (#set! injection.language "sql")
  (#set! priority 200))

; Also match keys ending with "_sql" or "_query"
((block_mapping_pair
  key: (flow_node
    (plain_scalar
      (string_scalar) @_key))
  value: (block_node
    (block_scalar) @injection.content))
  (#lua-match? @_key "_sql$")
  (#set! injection.language "sql")
  (#set! priority 200))

((block_mapping_pair
  key: (flow_node
    (plain_scalar
      (string_scalar) @_key))
  value: (block_node
    (block_scalar) @injection.content))
  (#lua-match? @_key "_query$")
  (#set! injection.language "sql")
  (#set! priority 200))
