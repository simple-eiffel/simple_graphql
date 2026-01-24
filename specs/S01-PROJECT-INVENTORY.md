# S01: PROJECT INVENTORY - simple_graphql

**Document**: S01-PROJECT-INVENTORY.md
**Library**: simple_graphql
**Status**: BACKWASH (reverse-engineered from implementation)
**Date**: 2026-01-23

---

## Project Structure

```
simple_graphql/
├── src/
│   ├── simple_graphql.e   -- Main facade class
│   ├── gql_client.e       -- HTTP client wrapper
│   ├── gql_query.e        -- Query encapsulation
│   ├── gql_result.e       -- Response parsing
│   └── gql_error.e        -- Error representation
├── testing/
│   ├── test_app.e         -- Test runner
│   └── lib_tests.e        -- Test suite
├── research/              -- 7S research documents
├── specs/                 -- Specification documents
└── simple_graphql.ecf     -- ECF configuration
```

## Source Files

### Core Classes (src/)

| File | Lines | Purpose |
|------|-------|---------|
| simple_graphql.e | 160 | High-level facade for GraphQL operations |
| gql_client.e | 130 | Low-level HTTP transport |
| gql_query.e | 120 | Query with variables and operation name |
| gql_result.e | 145 | Response with data and errors |
| gql_error.e | 60 | Individual error from GraphQL response |

### Test Files (testing/)

| File | Lines | Purpose |
|------|-------|---------|
| test_app.e | 30 | Application entry point for tests |
| lib_tests.e | 50 | Test case implementations |

## Configuration Files

| File | Purpose |
|------|---------|
| simple_graphql.ecf | Main ECF configuration |

## Dependencies

| Library | Purpose |
|---------|---------|
| simple_http | HTTP POST requests |
| simple_json | JSON encoding/decoding |
