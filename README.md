# 📚 NexusDev — Uni Textbook Marketplace
### Technical Validation Repository

> A lightweight database validation demonstrating fast, multi-filter search on student textbook listings.

---

## 🗂️ Table of Contents

- [Overview](#overview)
- [Validation Goals](#validation-goals)
- [Team & Files](#team--files)
- [Database Schema](#database-schema)
- [Indexes](#indexes)
- [Sample Queries](#sample-queries--expected-performance)
- [Docker Setup](#docker-setup)

---

## Overview

This repository contains the technical validation for the **Uni Textbook Marketplace** project. It demonstrates our database design approach — optimised for read-heavy, multi-filter queries — using PostgreSQL running inside Docker.

---

## ✅ Validation Goals

| # | Goal | Status |
|---|------|--------|
| 1 | Design schema for structured textbook listings | ✅ Complete |
| 2 | Create indexes for read-heavy performance | ✅ Complete |
| 3 | Demonstrate multi-filter search capability | ✅ Complete |
| 4 | Document expected performance metrics | ✅ Complete |

---

## 👥 Team & Files

| File | Description | Author |
|------|-------------|--------|
| `README.md` | Project lead, coordination, integration & documentation | **Tiego** |
| `schema.sql` | Database schema with indexes | **Neo** |
| `sample-data.sql` | 10 sample textbook listings | **Gift** |
| `queries.sql` | 4 test queries with `EXPLAIN ANALYZE` | **Omphemetse** |
| `screenshots/` | Performance test screenshots | **Josh** |

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
| `extras` | `JSONB` | Flexible fields (access code, notes) |
| `price` | `DECIMAL(10,2)` | Selling price |
| `module_code` | `VARCHAR(20)` | Course code (e.g. `COS301`) |

---

## ⚡ Indexes

| Index | Purpose |
|-------|---------|
| `idx_listings_module_price` | Most common filter — module + price range |
| `idx_listings_edition_condition` | Edition + condition filtering |
| `idx_listings_module_annotation` | Module + annotation level |

---

## 🔍 Sample Queries & Expected Performance

### Test 1 — Single Filter

```sql
SELECT * FROM listings
WHERE module_code = 'COS301';
```

---

## 🐳 Docker Setup

This project uses **Docker** to run a PostgreSQL instance pre-loaded with schema, sample data, and test queries.

### Connection Details

| Parameter | Value |
|-----------|-------|
| Host | `localhost` |
| Port | `5433` |
| Database | `marketplace` |
| Username | `postgres` |
| Password | `postgres` |

---

### 🚀 Quick Start

**1. Build the container**
```bash
docker build -t textbook-db .
```

**2. Start the container**
```bash
docker compose up --build -d
```

**3. Run verification scripts**
```bash
bash verify.sh
```

---

### 🛠️ Container Management

| Action | Command |
|--------|---------|
| Start container | `docker start textbook-postgres` |
| Stop container | `docker stop textbook-postgres` |
| Shut down & remove volumes | `docker compose down -v` |
| Reset SQL environment | `docker rm textbook-postgres` |

---

<div align="center">

**NexusDev** · Uni Textbook Marketplace · Technical Validation

</div>
