-- Identify duplicates based on email
SELECT email, COUNT(*) AS count
FROM raw_data
GROUP BY email
HAVING COUNT(*) > 1;

-- Delete duplicate records based on email
DELETE FROM raw_data
WHERE id NOT IN (
    SELECT MIN(id)
    FROM raw_data
    GROUP BY email
);

-- Convert all email addresses to lowercase
UPDATE raw_data
SET email = LOWER(email);

-- Capitalize the first letter of names
UPDATE raw_data
SET first_name = INITCAP(first_name),
    last_name = INITCAP(last_name);
Handling Missing or Incorrect Values:

-- Replace missing phone numbers with 'Not Provided'
UPDATE raw_data
SET phone_number = 'Not Provided'
WHERE phone_number IS NULL OR phone_number = '';

-- Replace incorrect zip codes with correct ones
UPDATE raw_data
SET zip_code = '12345'
WHERE LENGTH(zip_code) <> 5;
Validating and Formatting Dates:

-- Validate and format date_of_birth column (assuming it's in a specific format)
UPDATE raw_data
SET date_of_birth = TO_DATE(date_of_birth, 'MM/DD/YYYY')
WHERE TO_DATE(date_of_birth, 'MM/DD/YYYY') IS NOT NULL;
Cleaning Text Fields:

-- Remove leading/trailing spaces in the address column
UPDATE raw_data
SET address = TRIM(address);

-- Remove special characters in the city column
UPDATE raw_data
SET city = REGEXP_REPLACE(city, '[^a-zA-Z ]', '');
Checking and Handling Data Integrity Issues:

-- Identify records with inconsistent state names
SELECT DISTINCT state
FROM raw_data
WHERE state NOT IN ('NY', 'CA', 'TX', 'FL', 'IL'); -- Example states

-- Update incorrect state names
UPDATE raw_data
SET state = 'CA'
WHERE state = 'California';
