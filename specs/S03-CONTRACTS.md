# S03: CONTRACTS - simple_graphql

**Document**: S03-CONTRACTS.md
**Library**: simple_graphql
**Status**: BACKWASH (reverse-engineered from implementation)
**Date**: 2026-01-23

---

## SIMPLE_GRAPHQL Contracts

### Class Invariant
```eiffel
invariant
    endpoint_not_empty: not endpoint_url.is_empty
    last_error_attached: last_error /= Void
    client_attached: client /= Void
    headers_attached: default_headers /= Void
```

### Creation
```eiffel
make (a_endpoint: STRING)
    require
        endpoint_not_empty: not a_endpoint.is_empty
        valid_url: a_endpoint.has_substring ("://")
    ensure
        endpoint_set: endpoint_url.same_string (a_endpoint)
        no_error: last_error.is_empty
        no_result: last_result = Void
```

### Query Operations
```eiffel
query (a_query: STRING)
    require
        query_not_empty: not a_query.is_empty
    ensure
        result_set: last_result /= Void

query_with_variables (a_query: STRING; a_variables: SIMPLE_JSON_OBJECT)
    require
        query_not_empty: not a_query.is_empty
        variables_attached: a_variables /= Void
    ensure
        result_set: last_result /= Void

mutation (a_mutation: STRING)
    require
        mutation_not_empty: not a_mutation.is_empty
    ensure
        result_set: last_result /= Void
```

### Configuration
```eiffel
set_header (a_name, a_value: STRING)
    require
        name_not_empty: not a_name.is_empty
        value_not_empty: not a_value.is_empty
    ensure
        header_set: attached default_headers.item (a_name) as h
                    and then h.same_string (a_value)
```

## GQL_CLIENT Contracts

### Class Invariant
```eiffel
invariant
    http_attached: http /= Void
    endpoint_not_empty: not endpoint.is_empty
    headers_attached: headers /= Void
```

### Operations
```eiffel
execute (a_query: GQL_QUERY): GQL_RESULT
    require
        query_attached: a_query /= Void
    ensure
        result_attached: Result /= Void
```

## GQL_QUERY Contracts

### Class Invariant
```eiffel
invariant
    query_not_empty: not query.is_empty
```

### Conversion
```eiffel
to_json: STRING
    ensure
        result_not_empty: not Result.is_empty
        contains_query: Result.has_substring ("query")
```

## GQL_RESULT Contracts

### Class Invariant
```eiffel
invariant
    errors_attached: errors /= Void
    raw_json_attached: raw_json /= Void
```

### Status
```eiffel
is_successful: BOOLEAN
    ensure
        definition: Result = (data /= Void and errors.is_empty)

has_errors: BOOLEAN
    ensure
        definition: Result = not errors.is_empty
```
