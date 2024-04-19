-- Due to inflation and the rising cost of living some universities must raise their tuition fees.
-- Raise the tuition fee by 300 for all universities with id equal or greater than 5 and less than 12 (inclusive).
UPDATE universities 
SET 
    tuition_fee = tuition_fee + 300
WHERE
    id BETWEEN 5 AND 12;