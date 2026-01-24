# S02: CLASS CATALOG - simple_graphql

**Document**: S02-CLASS-CATALOG.md
**Library**: simple_graphql
**Status**: BACKWASH (reverse-engineered from implementation)
**Date**: 2026-01-23

---

## Core Classes

| Class | Type | Description |
|-------|------|-------------|
| SIMPLE_GRAPHQL | Effective | High-level facade for GraphQL operations |
| GQL_CLIENT | Effective | Low-level HTTP client for GraphQL |
| GQL_QUERY | Effective | Represents a GraphQL query with variables |
| GQL_RESULT | Effective | Parsed GraphQL response (data + errors) |
| GQL_ERROR | Effective | Individual GraphQL error |

## Class Details

### SIMPLE_GRAPHQL
**Purpose**: Main entry point for GraphQL operations

**Key Features**:
- `make (endpoint)`: Create client for endpoint
- `query (query_string)`: Execute query
- `query_with_variables (query, vars)`: Query with variables
- `mutation (mutation_string)`: Execute mutation
- `set_header (name, value)`: Configure headers
- `last_result`: Access response
- `has_error`: Check for errors

### GQL_CLIENT
**Purpose**: HTTP transport layer

**Key Features**:
- `make (endpoint)`: Create for endpoint
- `execute (query)`: Send query and get result
- `add_header / clear_headers`: Header management

### GQL_QUERY
**Purpose**: Query encapsulation

**Key Features**:
- `make (query)`: Simple query
- `make_with_variables (query, vars)`: With variables
- `make_with_operation (query, vars, op_name)`: Full form
- `to_json`: Serialize for HTTP

### GQL_RESULT
**Purpose**: Response parsing

**Key Features**:
- `make (json)`: Parse response
- `make_error (message)`: Create error result
- `data`: Response data (SIMPLE_JSON_VALUE)
- `errors`: List of GQL_ERROR
- `is_successful`: No errors and has data

### GQL_ERROR
**Purpose**: Error representation

**Key Features**:
- `make (message)`: Create with message
- `make_from_json (obj)`: Parse from JSON
- `message`: Error message
- `locations`: Error locations
- `path`: Error path

## Inheritance

```
SIMPLE_GRAPHQL
    uses GQL_CLIENT
    uses GQL_QUERY
    uses GQL_RESULT
        uses GQL_ERROR
```
