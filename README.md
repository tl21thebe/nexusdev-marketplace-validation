<div align="center">

# 📚 NexusDev
## Uni Textbook Marketplace — Technical Validation

*Proving sub-millisecond multi-filter search for student textbook listings*

[![PostgreSQL](https://img.shields.io/badge/PostgreSQL-16-336791?style=flat-square&logo=postgresql&logoColor=white)](https://www.postgresql.org/)
[![Docker](https://img.shields.io/badge/Docker-Compose-2496ED?style=flat-square&logo=docker&logoColor=white)](https://www.docker.com/)
[![Status](https://img.shields.io/badge/Status-Complete-22c55e?style=flat-square)](#)

</div>

---

## 📌 Overview

This repository is a **lightweight technical validation** for the Uni Textbook Marketplace project. It demonstrates our database design approach — optimised for read-heavy, multi-filter queries — using PostgreSQL running inside Docker.

The hardest part of the Marketplace platform is **fast search with multiple filters**. Students need to search by module, price, condition, edition, and annotation level simultaneously. This spike proves we can design a database that delivers results in **under 1 millisecond**.

> **Note:** This is not application code. This validation focuses exclusively on SQL (database design and queries) and documentation — the professional groundwork required for our tender submission.

---

## ✅ Validation Goals

| # | Goal | Status |
|---|------|:------:|
| 1 | Design schema for structured textbook listings | ✅ |
| 2 | Create indexes for read-heavy performance | ✅ |
| 3 | Demonstrate multi-filter search capability | ✅ |
| 4 | Document expected performance metrics (sub-millisecond) | ✅ |

---

## 👥 Team

| File | Description | Author |
|------|-------------|--------|
| `README.md` | Project coordination, integration & documentation | **Tiego** |
| `schema.sql` | Database schema with indexes | **Neo** |
| `sample-data.sql` | 10 realistic textbook listings | **Gift** |
| `queries.sql` | 4 test queries with `EXPLAIN ANALYZE` | **Omphemetse** |
| `docker-compose.yml` + `verify.sh` | Docker setup & verification scripts | **Josh** |
| `screenshots/` | Performance test screenshots | **Josh** |

---

## 🌿 Branching Strategy

```
main
  ├── feature/schema-design       (Neo)
  ├── feature/sample-data         (Gift)
  ├── feature/test-queries        (Omphemetse)
  ├── feature/docker-setup        (Josh)
  └readme-update       (Tiego)
```

---

## 🗃️ Database Schema

### Table: `listings`

| Field | Type | Description |
|-------|------|-------------|
| `id` | `UUID` | Primary key |
| `title` | `VARCHAR(500)` | Textbook title |
| `isbn` | `VARCHAR(13)` | ISBN identifier |
| `edition` | `INTEGER` | Edition number |
| `condition` | `VARCHAR(50)` | `Like New` · `Good` · `Acceptable` · `Poor` |
| `annotation_level` | `VARCHAR(50)` | `None` · `Light` · `Heavy` |
| `extras` | `JSONB` | Flexible fields — e.g. `{"access_code": "unused"}` |
| `price` | `DECIMAL(10,2)` | Selling price in Rands (ZAR) |
| `module_code` | `VARCHAR(20)` | Course code — e.g. `COS301` |

### Indexes

| Index | Columns | Purpose |
|-------|---------|---------|
| `idx_listings_module_price` | `module_code, price` | Most common filter — module + price range |
| `idx_listings_edition_condition` | `edition, condition` | Edition + condition filtering |
| `idx_listings_module_annotation` | `module_code, annotation_level` | Module + annotation level |

---

## 🔍 Test Queries

All queries use `EXPLAIN ANALYZE` to capture real execution times and confirm index usage.

| Test | Filters Applied |
|------|----------------|
| **Test 1** | Module code only |
| **Test 2** | Module code + price under R500 |
| **Test 3** | Module code + price + condition (`Like New`) |
| **Test 4** | Module + edition + price range + condition + annotation level, sorted by price |

### Example — Test 1 (Single Filter)

```sql
EXPLAIN ANALYZE
SELECT * FROM listings
WHERE module_code = 'COS301';
```

### Example — Test 4 (Full Multi-Filter)

```sql
EXPLAIN ANALYZE
SELECT * FROM listings
WHERE module_code      = 'COS301'
  AND edition          = 9
  AND price            BETWEEN 200 AND 600
  AND condition        IN ('Like New', 'Good')
  AND annotation_level <> 'Heavy'
ORDER BY price ASC;
```

Performance screenshots for all four tests are in the [`screenshots/`](./screenshots/) folder.

---

## 📦 Sample Data

10 realistic listings representing UP modules, with at least 3 entries for `COS301`. Modules covered:

`COS151` · `COS212` · `COS221` · `COS301` · `COS331` · `COS341`

---

## 🐳 Docker Setup

### Connection Details

| Parameter | Value |
|-----------|-------|
| Host | `localhost` |
| Port | `5433` |
| Database | `marketplace` |
| Username | `postgres` |
| Password | `postgres` |

### Quick Start

```bash
# 1. Build and start the container
docker compose up --build -d

# 2. Run all verification queries
bash verify.sh        # Mac / Linux
verify.bat            # Windows
```

### Container Management

| Action | Command |
|--------|---------|
| Build image | `docker build -t textbook-db .` |
| Start (background) | `docker compose up --build -d` |
| Start existing | `docker start textbook-postgres` |
| Stop | `docker stop textbook-postgres` |
| Shut down + remove volumes | `docker compose down -v` |
| Reset SQL environment | `docker rm textbook-postgres` |

---

## 📸 Performance Screenshots

Evidence of sub-millisecond query performance for all four test cases:

| File | Test |
|------|------|
| `screenshots/test-1.png` | Single filter |
| `screenshots/test-2.png` | Two filters |
| `screenshots/test-3.png` | Three filters |
| `screenshots/test-4.png` | Full multi-filter |

Each screenshot shows the `EXPLAIN ANALYZE` output, execution time (e.g. `actual time=0.045..0.052`), and confirmation that an index scan was used.

---

<div align="center">

**NexusDev** · University of Pretoria · Uni Textbook Marketplace · Technical Validation

</div>
