# 7S-01: SCOPE - simple_graphql

**Document**: 7S-01-SCOPE.md
**Library**: simple_graphql
**Status**: BACKWASH (reverse-engineered from implementation)
**Date**: 2026-01-23

---

## Problem Domain

simple_graphql provides GraphQL client capabilities for Eiffel applications:

1. **Query Execution** - Send GraphQL queries to remote endpoints
2. **Variable Support** - Pass variables with queries
3. **Response Parsing** - Parse GraphQL JSON responses
4. **Error Handling** - Handle GraphQL errors gracefully

## Target Users

- **API Consumers**: Applications consuming GraphQL APIs
- **Data Integrators**: Pulling data from GraphQL services
- **Microservice Clients**: Communicating with GraphQL backends
- **Tool Builders**: Building tools that interact with GraphQL endpoints

## Boundaries

### In Scope
- GraphQL query execution (queries and mutations)
- Variable passing
- Response parsing (data and errors)
- HTTP transport via simple_http
- Header configuration (authentication, etc.)

### Out of Scope
- GraphQL server implementation
- Schema introspection
- Subscriptions (WebSocket)
- Query validation
- Code generation from schema

## Dependencies

- simple_http: HTTP POST requests
- simple_json: JSON encoding/decoding

## Integration Points

- Uses simple_http for transport
- Uses simple_json for serialization
- Provides SIMPLE_GRAPHQL facade class
- Returns GQL_RESULT with data/errors
