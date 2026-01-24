# S04: FEATURE SPECS - simple_graphql

**Document**: S04-FEATURE-SPECS.md
**Library**: simple_graphql
**Status**: BACKWASH (reverse-engineered from implementation)
**Date**: 2026-01-23

---

## SIMPLE_GRAPHQL Features

### Initialization
| Feature | Signature | Description |
|---------|-----------|-------------|
| make | (a_endpoint: STRING) | Create client for endpoint |

### Access
| Feature | Signature | Description |
|---------|-----------|-------------|
| endpoint_url | STRING | GraphQL endpoint URL |
| last_result | detachable GQL_RESULT | Result from last operation |
| last_error | STRING | Last error message |

### Status Report
| Feature | Signature | Description |
|---------|-----------|-------------|
| has_error | BOOLEAN | Did last operation have error? |

### Query Operations
| Feature | Signature | Description |
|---------|-----------|-------------|
| query | (a_query: STRING) | Execute GraphQL query |
| query_with_variables | (STRING, SIMPLE_JSON_OBJECT) | Query with variables |

### Mutation Operations
| Feature | Signature | Description |
|---------|-----------|-------------|
| mutation | (a_mutation: STRING) | Execute GraphQL mutation |

### Configuration
| Feature | Signature | Description |
|---------|-----------|-------------|
| set_header | (a_name, a_value: STRING) | Set HTTP header |

## GQL_CLIENT Features

### Initialization
| Feature | Signature | Description |
|---------|-----------|-------------|
| make | (a_endpoint: STRING) | Create for endpoint |

### Operations
| Feature | Signature | Description |
|---------|-----------|-------------|
| execute | (GQL_QUERY): GQL_RESULT | Execute query |
| build_request_body | (GQL_QUERY): STRING | Build JSON body |
| parse_response | (STRING): GQL_RESULT | Parse JSON response |

### Configuration
| Feature | Signature | Description |
|---------|-----------|-------------|
| add_header | (a_name, a_value: STRING) | Add HTTP header |
| clear_headers | | Clear all headers |

## GQL_QUERY Features

### Initialization
| Feature | Signature | Description |
|---------|-----------|-------------|
| make | (a_query: STRING) | Simple query |
| make_with_variables | (STRING, SIMPLE_JSON_OBJECT) | With variables |
| make_with_operation | (STRING, JSON_OBJECT, STRING) | With operation name |

### Access
| Feature | Signature | Description |
|---------|-----------|-------------|
| query | STRING | Query text |
| variables | detachable SIMPLE_JSON_OBJECT | Variables |
| operation_name | detachable STRING | Operation name |

### Conversion
| Feature | Signature | Description |
|---------|-----------|-------------|
| to_json | STRING | Serialize to JSON |

## GQL_RESULT Features

### Initialization
| Feature | Signature | Description |
|---------|-----------|-------------|
| make | (a_json: STRING) | Parse response |
| make_error | (a_message: STRING) | Create error result |

### Access
| Feature | Signature | Description |
|---------|-----------|-------------|
| data | detachable SIMPLE_JSON_VALUE | Response data |
| errors | ARRAYED_LIST [GQL_ERROR] | Error list |
| raw_json | STRING | Original JSON |
| first_error_message | STRING | First error message |

### Status Report
| Feature | Signature | Description |
|---------|-----------|-------------|
| is_successful | BOOLEAN | Has data, no errors |
| has_errors | BOOLEAN | Has errors |
| has_data | BOOLEAN | Has data |
