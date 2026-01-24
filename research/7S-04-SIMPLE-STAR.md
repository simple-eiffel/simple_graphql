# 7S-04: SIMPLE-STAR - simple_graphql

**Document**: 7S-04-SIMPLE-STAR.md
**Library**: simple_graphql
**Status**: BACKWASH (reverse-engineered from implementation)
**Date**: 2026-01-23

---

## Ecosystem Integration

### Dependencies (Incoming)

| Library | Usage |
|---------|-------|
| simple_http | HTTP POST transport |
| simple_json | JSON encoding/decoding |

### Dependents (Outgoing)

| Library | Usage |
|---------|-------|
| (applications) | GraphQL API consumption |

### Integration Patterns

1. **Basic Query Pattern**
```eiffel
local
    gql: SIMPLE_GRAPHQL
do
    create gql.make ("https://api.example.com/graphql")
    gql.query ("{ users { id name } }")
    if attached gql.last_result as res and then res.is_successful then
        -- process res.data
    end
end
```

2. **Query with Variables Pattern**
```eiffel
local
    gql: SIMPLE_GRAPHQL
    vars: SIMPLE_JSON_OBJECT
do
    create gql.make ("https://api.example.com/graphql")
    create vars.make
    vars.put_integer (123, "userId")
    gql.query_with_variables ("query($userId: ID!) { user(id: $userId) { name } }", vars)
end
```

3. **Authentication Pattern**
```eiffel
local
    gql: SIMPLE_GRAPHQL
do
    create gql.make ("https://api.example.com/graphql")
    gql.set_header ("Authorization", "Bearer " + token)
    gql.query ("{ me { name } }")
end
```

### API Compatibility

- Follows simple_* naming conventions
- Uses SIMPLE_JSON types for data
- Returns domain-specific result/error types
- Fluent-style API where applicable
