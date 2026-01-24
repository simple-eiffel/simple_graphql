# S06: BOUNDARIES - simple_graphql

**Document**: S06-BOUNDARIES.md
**Library**: simple_graphql
**Status**: BACKWASH (reverse-engineered from implementation)
**Date**: 2026-01-23

---

## System Boundaries

```
+---------------------------------------------+
|              Application Layer              |
|    (Code consuming GraphQL APIs)            |
+---------------------------------------------+
                     |
                     v
+---------------------------------------------+
|             simple_graphql                  |
|  +---------------+  +-------------------+   |
|  | SIMPLE_GRAPHQL|  | GQL_RESULT        |   |
|  | (facade)      |  | GQL_ERROR         |   |
|  +---------------+  +-------------------+   |
|  +---------------+  +-------------------+   |
|  | GQL_CLIENT    |  | GQL_QUERY         |   |
|  | (transport)   |  | (data)            |   |
|  +---------------+  +-------------------+   |
+---------------------------------------------+
                     |
         +-----------+-----------+
         v                       v
+------------------+   +-------------------+
|   simple_http    |   |   simple_json     |
| (HTTP transport) |   | (JSON encoding)   |
+------------------+   +-------------------+
                     |
                     v
+---------------------------------------------+
|              GraphQL Server                 |
|    (External API)                           |
+---------------------------------------------+
```

## Interface Boundaries

### Public API (Exported to ANY)

- SIMPLE_GRAPHQL: Main facade
- GQL_RESULT: Response access
- GQL_ERROR: Error information
- GQL_QUERY: Query construction (advanced use)

### Internal Implementation (Not Exported)

- GQL_CLIENT: Used internally by SIMPLE_GRAPHQL
- HTTP details hidden from consumers
- JSON serialization hidden

## Data Boundaries

### Input
- GraphQL query strings
- Variable objects (SIMPLE_JSON_OBJECT)
- HTTP headers (STRING pairs)
- Endpoint URL (STRING)

### Output
- GQL_RESULT with data and errors
- Response data as SIMPLE_JSON_VALUE
- Error messages as STRING

## Trust Boundaries

```
+------------------+
| Application Code |  <-- Constructs queries (trusted)
+------------------+
         |
         v
+------------------+
| simple_graphql   |  <-- Transports (trusted)
+------------------+
         |
         v (network)
+------------------+
| GraphQL Server   |  <-- Validates/executes (external)
+------------------+
```

- Application responsible for query correctness
- Server responsible for validation and authorization
- simple_graphql trusts both ends
