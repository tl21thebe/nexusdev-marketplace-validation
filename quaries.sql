
//TEST 1
EXPLAIN ANALYZE
SELECT * FROM listings 
WHERE module_code = 'Cos 301';

//TEST 2
EXPLAIN ANALYZE
SELECT * FROM listings 
WHERE module_code = 'Cos 301' AND price < 500;

//TEST 3
EXPLAIN ANALYZE
SELECT * FROM listings 
WHERE module_code = 'Cos 301' AND price < 500 AND condition = 'Like New';

//TEST 4
EXPLAIN ANALYZE
SELECT * FROM listings
WHERE module_code = 'Cos 301' 
AND edition = 9
AND price BETWEEN 200 AND 600  
AND condition IN ('Like New','Good') 
AND annotation_level != 'Heavy'
ORDER BY price ASC; 