## API Specification Overview

This system follows OpenAPI 3.0 standard for defining REST APIs.

### Features:
- Account management APIs
- Transaction APIs with pagination
- Standardized error responses
- Rate limiting per tier

### Pagination:
Cursor-based pagination is used for scalability.

### Error Handling:
All errors follow a unified schema with error_code and message.

### Rate Limiting:
Implemented using token bucket algorithm per user tier.

### Conclusion:
The API design ensures scalability, consistency, and high performance for financial operations.






## Cursor-Based Pagination

We use cursor-based pagination instead of offset pagination.

### Why:
- Faster for large datasets
- No duplicate or missing records
- Stable under data changes

### Example:
GET /transactions?cursor=abc123&limit=10

Response:
{
  "next_cursor": "xyz789",
  "data": []
}

## Error Response Design

Standard format:

{
  "error_code": "INSUFFICIENT_FUNDS",
  "message": "Account balance is too low"
}

### HTTP Status Codes:
- 400 → Bad Request
- 401 → Unauthorized
- 403 → Forbidden
- 404 → Not Found
- 409 → Conflict (duplicate transaction)
- 500 → Server Error


## Rate Limiting Strategy

### Per Tier:

| Tier | Requests/sec |
|------|-------------|
| Free | 10 req/sec |
| Standard | 50 req/sec |
| Premium | 200 req/sec |

### Per Endpoint:
- /transactions → strict limit (5/sec)
- /accounts → moderate (20/sec)

### Algorithm:
- Token Bucket
- Sliding Window for fairness