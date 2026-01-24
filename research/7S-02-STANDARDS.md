# 7S-02: STANDARDS - simple_graphql

**Document**: 7S-02-STANDARDS.md
**Library**: simple_graphql
**Status**: BACKWASH (reverse-engineered from implementation)
**Date**: 2026-01-23

---

## Applicable Standards

### GraphQL Specification

1. **GraphQL Spec (October 2021)**
   - Reference: https://spec.graphql.org/October2021/
   - Query language syntax
   - Response format (data, errors, extensions)
   - Variable definitions

2. **GraphQL over HTTP**
   - Reference: https://graphql.github.io/graphql-over-http/
   - POST requests with JSON body
   - Content-Type: application/json
   - Response format

### HTTP Standards

1. **RFC 7231 - HTTP/1.1 Semantics**
   - POST method for queries and mutations
   - Content-Type headers

2. **RFC 7159 - JSON**
   - Request/response body format

## Protocol Format

### Request Format
```json
{
  "query": "{ users { id name } }",
  "variables": { "id": 123 },
  "operationName": "GetUser"
}
```

### Response Format
```json
{
  "data": { "users": [...] },
  "errors": [{ "message": "...", "locations": [...], "path": [...] }]
}
```

## Implementation Compliance

| Standard | Compliance Level | Notes |
|----------|------------------|-------|
| GraphQL Spec | Client-side only | Queries/mutations |
| GraphQL over HTTP | Full | POST with JSON |
| JSON (RFC 7159) | Full | Via simple_json |
| HTTP/1.1 | Full | Via simple_http |
