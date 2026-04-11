# NexusDev - Uni Textbook Marketplace Technical Validation

## Overview
This repository contains a lightweight technical validation for the Uni Textbook Marketplace project. We demonstrate our database design approach for fast, multi-filter search on textbook listings.

## Validation Goals
- ✅ Design schema for structured textbook listings
- ✅ Create indexes for read-heavy performance
- ✅ Demonstrate multi-filter search capability
- ✅ Document expected performance metrics

## Files in This Repository
| File | Description | Author |
|------|-------------|--------|
| `README` | Project Lead, Coordination, Integration & Documentation | Tiego |
| `schema.sql` | Database schema with indexes | Neo |
| `sample-data.sql` | 10 sample textbook listings | Gift |
| `queries.sql` | 4 test queries with EXPLAIN ANALYZE | Omphemetse |
| `screenshots/` | Performance test screenshots | Josh |

## Database Schema

### Table: listings
| Field | Type | Description |
|-------|------|-------------|
| id | UUID | Primary key |
| title | VARCHAR(500) | Textbook title |
| isbn | VARCHAR(13) | ISBN identifier |
| edition | INTEGER | Edition number |
| condition | VARCHAR(50) | Like New, Good, Acceptable, Poor |
| annotation_level | VARCHAR(50) | None, Light, Heavy |
| extras | JSONB | Flexible fields (access code, notes) |
| price | DECIMAL(10,2) | Selling price |
| module_code | VARCHAR(20) | Course code (e.g., COS301) |

### Indexes
| Index | Purpose |
|-------|---------|
| `idx_listings_module_price` | Most common filter (module + price) |
| `idx_listings_edition_condition` | Edition + condition filtering |
| `idx_listings_module_annotation` | Module + annotation level |

## Sample Queries & Expected Performance

### Test 1: Single Filter
```sql
SELECT * FROM listings WHERE module_code = 'COS301';
