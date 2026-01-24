# 7S-03: SOLUTIONS - simple_graphql

**Document**: 7S-03-SOLUTIONS.md
**Library**: simple_graphql
**Status**: BACKWASH (reverse-engineered from implementation)
**Date**: 2026-01-23

---

## Existing Solutions Comparison

### GraphQL Clients

| Solution | Language | Pros | Cons |
|----------|----------|------|------|
| Apollo Client | JavaScript | Full-featured, caching | Wrong language |
| graphql-request | JavaScript | Minimal, simple | Wrong language |
| gql | Python | Async support | Wrong language |
| graphql-client | Ruby | Simple API | Wrong language |
| simple_graphql | Eiffel | Native, DBC | Client-only |

### Why Not Raw HTTP?

- GraphQL has specific request format
- Response parsing handles data + errors
- Variable substitution logic
- Operation name handling

## Why simple_graphql?

1. **Native Eiffel**: First-class Eiffel types
2. **Design by Contract**: Full DBC support
3. **Ecosystem Integration**: Uses simple_http, simple_json
4. **Simple API**: Minimal learning curve
5. **Error Handling**: GraphQL-specific error types

## Design Decisions

1. **Facade Pattern**: SIMPLE_GRAPHQL wraps complexity
2. **Result Object**: GQL_RESULT encapsulates response
3. **Error Collection**: Multiple errors supported
4. **Header Support**: Easy authentication

## Trade-offs

- No caching (keep it simple)
- No subscriptions (WebSocket complexity)
- No schema validation (client-only)
- Relies on server for validation

## Recommendation

Use simple_graphql for:
- Consuming GraphQL APIs
- Simple query/mutation operations
- Applications needing DBC guarantees
