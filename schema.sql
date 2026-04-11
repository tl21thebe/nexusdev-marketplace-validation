-- UUID generation in PostgreSQL
CREATE EXTENSION IF NOT EXISTS pgcrypto;



DROP TABLE IF EXISTS listings;

DROP TYPE IF EXISTS condition_enum;
DROP TYPE IF EXISTS annotation_level_enum;

-- Set ENUM types


CREATE TYPE condition_enum AS ENUM (
    'Like New',
    'Good',
    'Acceptable',
    'Poor'
);

CREATE TYPE annotation_level_enum AS ENUM (
    'None',
    'Light',
    'Heavy'
);

--table creation

CREATE TABLE listings (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),

    user_id UUID NOT NULL,

    title VARCHAR(255) NOT NULL,
    isbn VARCHAR(20) NOT NULL,
    edition INTEGER NOT NULL CHECK (edition > 0),

    condition condition_enum NOT NULL,
    annotation_level annotation_level_enum NOT NULL,

    extras JSONB NOT NULL DEFAULT '{}'::jsonb,

    price DECIMAL(10, 2) NOT NULL CHECK (price >= 0),

    module_code VARCHAR(20) NOT NULL,

    created_at TIMESTAMP NOT NULL DEFAULT NOW()

    -- Foreign key to user's table , will be uncommented after users table is created
    -- ,FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);


-- indexes


-- module code + price
CREATE INDEX idx_module_price
ON listings (module_code, price);

-- edition + condition
CREATE INDEX idx_edition_condition
ON listings (edition, condition);

-- module code + annotation level
CREATE INDEX idx_module_annotation
ON listings (module_code, annotation_level);

-- ISBN lookup
CREATE INDEX idx_isbn
ON listings (isbn);

