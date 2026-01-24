# S07: SPEC SUMMARY - simple_graphql

**Document**: S07-SPEC-SUMMARY.md
**Library**: simple_graphql
**Status**: BACKWASH (reverse-engineered from implementation)
**Date**: 2026-01-23

---

## Executive Summary

simple_graphql provides a GraphQL client for Eiffel applications, enabling queries and mutations against GraphQL endpoints with full Design by Contract support.

## Key Components

| Component | Purpose | Status |
|-----------|---------|--------|
| SIMPLE_GRAPHQL | High-level facade | Complete |
| GQL_CLIENT | HTTP transport | Complete |
| GQL_QUERY | Query encapsulation | Complete |
| GQL_RESULT | Response parsing | Complete |
| GQL_ERROR | Error handling | Complete |

## Core Capabilities

- Execute GraphQL queries
- Execute GraphQL mutations
- Pass variables with queries
- Configure HTTP headers (authentication)
- Parse response data and errors
- Handle GraphQL-specific errors

## API Highlights

```eiffel
-- Basic query
local
    gql: SIMPLE_GRAPHQL
do
    create gql.make ("https://api.example.com/graphql")
    gql.query ("{ users { id name } }")

    if attached gql.last_result as res then
        if res.is_successful then
            -- Access res.data
        else
            -- Handle res.errors
        end
    end
end

-- With authentication
gql.set_header ("Authorization", "Bearer " + token)

-- With variables
local
    vars: SIMPLE_JSON_OBJECT
do
    create vars.make
    vars.put_string ("John", "name")
    gql.query_with_variables ("query($name: String!) { user(name: $name) { id } }", vars)
end
```

## Quality Attributes

- **Design by Contract**: Full preconditions/postconditions
- **Void Safety**: All code void-safe
- **Error Handling**: GraphQL-specific error types
- **Simple API**: Minimal learning curve

## Dependencies

- simple_http: HTTP transport
- simple_json: JSON encoding/decoding
