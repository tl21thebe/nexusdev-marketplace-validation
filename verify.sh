#!/bin/bash
echo "========================================"
echo "Marketplace Technical Spike Verification"
echo "========================================"
echo ""
# Wait for PostgreSQL to be ready
echo "Waiting for PostgreSQL to start...
"
sleep 5
echo ""
# Test 1
echo "Test 1: Single filter (module code only)"
echo "----------------------------------------"
psql -h localhost -p 5433 -U postgres -d marketplace -c "EXPLAIN ANALYZE SELECT * FROM
listings WHERE module_code = 'COS301';"
echo ""
echo "Press Enter to continue to Test 2..."
read -p ""

# Test 2

echo ""
echo "Test 2: Two filters (module + price)"
echo "----------------------------------------"
psql -h localhost -p 5433 -U postgres -d marketplace -c "EXPLAIN ANALYZE SELECT * FROM
listings WHERE module_code = 'COS301' AND price < 500;"
echo ""
echo "Press Enter to continue to Test 3..."
read -p ""

# Test 3

echo ""
echo "Test 3: Three filters (module + price + condition)"
echo "---------------------------------------------------"
psql -h localhost -p 5433 -U postgres -d marketplace -c "EXPLAIN ANALYZE SELECT * FROM
listings WHERE module_code = 'COS301' AND price < 500 AND condition = 'Like New';"
echo ""
echo "Press Enter to continue to Test 4..."
read -p ""

# Test 4

echo ""
echo "Test 4: Full multi-filter"
echo "-------------------------"
psql -h localhost -p 5433 -U postgres -d marketplace -c "EXPLAIN ANALYZE SELECT * FROM
listings WHERE module_code = 'COS301' AND edition = 9 AND price BETWEEN 200 AND 600
AND condition IN ('Like New','Good') AND annotation_level != 'Heavy' ORDER BY price ASC;"
echo ""
echo "========================================"
echo "Verification complete."
echo "========================================"