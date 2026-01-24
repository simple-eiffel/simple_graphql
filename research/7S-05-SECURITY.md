# 7S-05: SECURITY - simple_graphql

**Document**: 7S-05-SECURITY.md
**Library**: simple_graphql
**Status**: BACKWASH (reverse-engineered from implementation)
**Date**: 2026-01-23

---

## Security Considerations

### Attack Vectors

1. **Query Injection**
   - Risk: Malicious GraphQL queries
   - Mitigation: Server-side validation (client cannot prevent)
   - Status: Application responsibility

2. **Credential Exposure**
   - Risk: Auth tokens in logs/errors
   - Mitigation: Headers not logged
   - Status: Application must protect tokens

3. **Response Tampering**
   - Risk: Modified responses
   - Mitigation: HTTPS transport
   - Status: Relies on simple_http TLS

4. **Denial of Service**
   - Risk: Expensive queries overloading server
   - Mitigation: Server-side query complexity limits
   - Status: Server responsibility

### Trust Boundaries

```
+------------------+
|   Application    |  <-- Constructs queries
+------------------+
         |
         v
+------------------+
| simple_graphql   |  <-- Sends over HTTP
+------------------+
         |
         v (HTTPS)
+------------------+
|  GraphQL Server  |  <-- Validates, executes
+------------------+
```

### Recommendations

1. **Use HTTPS**: Always use HTTPS endpoints
2. **Protect Tokens**: Don't log auth headers
3. **Validate Responses**: Check data types
4. **Handle Errors**: Don't expose internal errors to users

### Known Vulnerabilities

None identified in current implementation.

### Authentication Patterns

- Bearer tokens via `set_header`
- API keys via custom headers
- Basic auth via Authorization header
