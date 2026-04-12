
EXPLAIN ANALYZE
SELECT * FROM listings 
WHERE module_code = 'COS301';


EXPLAIN ANALYZE
SELECT * FROM listings 
WHERE module_code = 'COS301' AND price < 500;

EXPLAIN ANALYZE
SELECT * FROM listings 
WHERE module_code = 'COS301' AND price < 500 AND condition = 'Like New';


EXPLAIN ANALYZE
SELECT * FROM listings
WHERE module_code = 'COS301' 
  AND price BETWEEN 200 AND 600  
  AND edition = 9
  AND condition IN ('Like New', 'Good') 
  AND annotation_level != 'Heavy'
ORDER BY price ASC;
