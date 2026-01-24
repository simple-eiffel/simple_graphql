# S05: CONSTRAINTS - simple_graphql

**Document**: S05-CONSTRAINTS.md
**Library**: simple_graphql
**Status**: BACKWASH (reverse-engineered from implementation)
**Date**: 2026-01-23

---

## Technical Constraints

### Endpoint Requirements

1. **URL Format**
   - Must contain "://" (http:// or https://)
   - Must not be empty
   - Should point to valid GraphQL endpoint

2. **Protocol Support**
   - HTTP and HTTPS supported
   - HTTPS strongly recommended for production
   - Relies on simple_http for transport

### Query Constraints

1. **Query Format**
   - Must be valid GraphQL syntax
   - No client-side validation (server validates)
   - Must not be empty string

2. **Variables**
   - Must be SIMPLE_JSON_OBJECT
   - Keys must match query variable names
   - Values must be JSON-serializable

3. **Operation Names**
   - Optional but recommended for multi-operation documents
   - Must not be empty if provided

### Response Constraints

1. **JSON Format**
   - Server must return valid JSON
   - Must have "data" and/or "errors" field
   - "data" can be any JSON value
   - "errors" must be array

2. **Error Format**
   - Each error must have "message" field
   - "locations" and "path" optional

### Performance Constraints

- HTTP timeout controlled by simple_http
- No connection pooling
- Synchronous execution only

### Platform Constraints

- Depends on simple_http platform support
- UTF-8 encoding assumed
- Windows, Linux, macOS supported

## Memory Constraints

- Response fully loaded into memory
- Large responses may impact performance
- No streaming support
