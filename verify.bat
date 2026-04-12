@echo off

echo ========================================
echo Marketplace Technical Spike Verification
echo ========================================
echo.

echo Waiting for PostgreSQL to start...
timeout /t 5 /nobreak > nul

echo.
echo Test 1: Single filter (module code only)
echo ----------------------------------------

psql -h localhost -p 5433 -U postgres -d marketplace -c "EXPLAIN ANALYZE SELECT * FROM listings WHERE module_code = 'COS301';"

echo.
echo Press any key to continue to Test 2...
pause > nul

echo.
echo Test 2: Two filters (module + price)
echo ----------------------------------------

psql -h localhost -p 5433 -U postgres -d marketplace -c "EXPLAIN ANALYZE SELECT * FROM listings WHERE module_code = 'COS301' AND price < 500;"

echo.
echo Press any key to continue to Test 3...
pause > nul

echo.
echo Test 3: Three filters
echo ----------------------------------------

psql -h localhost -p 5433 -U postgres -d marketplace -c "EXPLAIN ANALYZE SELECT * FROM listings WHERE module_code = 'COS301' AND price < 500 AND condition = 'Like New';"

echo.
echo Press any key to continue to Test 4...
pause > nul

echo.
echo Test 4: Full multi-filter
echo ----------------------------------------

psql -h localhost -p 5433 -U postgres -d marketplace -c "EXPLAIN ANALYZE SELECT * FROM listings WHERE module_code = 'COS301' AND edition = 9 AND price BETWEEN 200 AND 600 AND condition IN ('Like New','Good') AND annotation_level != 'Heavy' ORDER BY price ASC;"

echo.
echo ========================================
echo Verification complete
echo ========================================
pause