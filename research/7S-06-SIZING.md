# 7S-06: SIZING - simple_graphql

**Document**: 7S-06-SIZING.md
**Library**: simple_graphql
**Status**: BACKWASH (reverse-engineered from implementation)
**Date**: 2026-01-23

---

## Implementation Size

### Source Metrics

| File | Lines | Purpose |
|------|-------|---------|
| simple_graphql.e | 160 | Facade class |
| gql_client.e | 130 | HTTP client |
| gql_query.e | 120 | Query encapsulation |
| gql_result.e | 145 | Response parsing |
| gql_error.e | 60 | Error representation |
| **Total** | ~615 | Core library |

### Test Files

| File | Lines | Purpose |
|------|-------|---------|
| lib_tests.e | 50 | Test suite |
| test_app.e | 30 | Test runner |

### Complexity Assessment

| Component | Complexity | Rationale |
|-----------|------------|-----------|
| SIMPLE_GRAPHQL | Low | Thin facade |
| GQL_CLIENT | Low | HTTP wrapper |
| GQL_QUERY | Low | Data class |
| GQL_RESULT | Medium | JSON parsing |
| GQL_ERROR | Low | Data class |

### Development Effort

- **Initial Implementation**: 8 hours
- **Testing**: 4 hours
- **Documentation**: 2 hours
- **Total**: ~14 hours

### Maintenance Effort

- **Monthly**: 1 hour
- **Per Release**: 2 hours

### Binary Impact

| Target | Size Impact |
|--------|-------------|
| Executable | +50-100 KB |
| Plus dependencies | +500 KB (http, json) |

### Test Coverage

- Query execution: Covered
- Variable handling: Covered
- Error parsing: Covered
- Estimated coverage: 75%
