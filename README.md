<p align="center">
  <img src="docs/images/logo.svg" alt="simple_graphql logo" width="400">
</p>

# simple_graphql

**[Documentation](https://simple-eiffel.github.io/simple_graphql/)** | **[GitHub](https://github.com/simple-eiffel/simple_graphql)**

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Eiffel](https://img.shields.io/badge/Eiffel-25.02-blue.svg)](https://www.eiffel.org/)
[![Design by Contract](https://img.shields.io/badge/DbC-enforced-orange.svg)]()

GraphQL client library for querying remote GraphQL endpoints from Eiffel.

Part of the [Simple Eiffel](https://github.com/simple-eiffel) ecosystem.

## Status

**Development** - Core query/mutation functionality

## Overview

SIMPLE_GRAPHQL provides an easy-to-use API for querying remote GraphQL endpoints. It handles HTTP transport, JSON encoding, and response parsing with full Design by Contract support.

## Features

- **Query Execution** - Execute GraphQL queries with simple API
- **Mutations** - Full mutation support
- **Variables** - Parameterized queries with JSON variables
- **Headers** - Custom HTTP headers (Authorization, etc.)
- **Error Handling** - GraphQL error extraction and reporting
- **Design by Contract** - Full preconditions, postconditions, invariants
- **Void Safe** - Fully void-safe implementation
- **SCOOP Compatible** - Ready for concurrent use

## Installation

1. Set the ecosystem environment variable (one-time setup for all simple_* libraries):
```bash
export SIMPLE_EIFFEL=D:\prod
```

2. Add to your ECF:
```xml
<library name="simple_graphql" location="$SIMPLE_EIFFEL/simple_graphql/simple_graphql.ecf"/>
```

## Quick Start

### Basic Query

```eiffel
local
    gql: SIMPLE_GRAPHQL
do
    create gql.make ("https://api.example.com/graphql")
    gql.query ("{ users { id name email } }")

    if attached gql.last_result as res and then res.is_successful then
        -- Process res.data
        print (res.data.to_json)
    elseif gql.has_error then
        print ("Error: " + gql.last_error)
    end
end
```

### Query with Variables

```eiffel
local
    gql: SIMPLE_GRAPHQL
    vars: SIMPLE_JSON_OBJECT
do
    create gql.make ("https://api.example.com/graphql")

    create vars.make
    vars.put_integer (123, "userId")

    gql.query_with_variables ("query GetUser($userId: ID!) { user(id: $userId) { name } }", vars)

    if attached gql.last_result as res then
        -- Use result
    end
end
```

### With Authentication

```eiffel
local
    gql: SIMPLE_GRAPHQL
do
    create gql.make ("https://api.example.com/graphql")
    gql.set_header ("Authorization", "Bearer your-token-here")
    gql.query ("{ me { id name } }")
end
```

### Mutations

```eiffel
local
    gql: SIMPLE_GRAPHQL
do
    create gql.make ("https://api.example.com/graphql")
    gql.mutation ("mutation { createUser(name: %"Alice%") { id } }")

    if attached gql.last_result as res and then res.is_successful then
        print ("Created user!")
    end
end
```

## API Reference

### SIMPLE_GRAPHQL

| Feature | Description |
|---------|-------------|
| `make (endpoint)` | Create client for GraphQL endpoint |
| `query (query_string)` | Execute GraphQL query |
| `query_with_variables (query, vars)` | Execute query with JSON variables |
| `mutation (mutation_string)` | Execute GraphQL mutation |
| `set_header (name, value)` | Set HTTP header for all requests |
| `last_result` | Result from last operation |
| `last_error` | Error message from last operation |
| `has_error` | Check if last operation failed |

### GQL_RESULT

| Feature | Description |
|---------|-------------|
| `is_successful` | Query completed without errors |
| `has_errors` | Query returned GraphQL errors |
| `data` | The data portion of response |
| `errors` | List of GraphQL errors |
| `first_error_message` | First error message if any |

## Dependencies

- simple_json
- simple_http

## License

MIT License - Copyright (c) 2024-2025, Larry Rix
