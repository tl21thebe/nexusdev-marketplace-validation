
DROP TABLE IF EXISTS textbooks;


CREATE TABLE textbooks (
    id SERIAL PRIMARY KEY,

    title VARCHAR(255) NOT NULL,
    isbn VARCHAR(20) NOT NULL,
    edition INTEGER NOT NULL CHECK (edition > 0),

   condition condition_enum NOT NULL,
    annotation_level annotation_level_enum NOT NULL,

    extras BOOLEAN NOT NULL DEFAULT FALSE, 

    price DECIMAL(10, 2) NOT NULL CHECK (price >= 0),

    module_code VARCHAR(10) NOT NULL
);


-- INDEXES 


-- module code + price
CREATE INDEX idx_module_price
ON textbooks (module_code, price);

--edition + condition
CREATE INDEX idx_edition_condition
ON textbooks (edition, condition);

-- module code + annotation level
CREATE INDEX idx_module_annotation
ON textbooks (module_code, annotation_level);

-- isbn index 
CREATE INDEX idx_isbn
ON textbooks (isbn);