-- After many kilometers and over the years, the condition of cars is expected to deteriorate.
-- Update all cars and set the condition to be 'C'.
-- The cars  must have a mileage greater than 800000 (inclusive) or NULL and must be older than 2010(inclusive).
-- Skip the cars that contain a make value of Mercedes-Benz. They can work for many more years.

UPDATE cars 
SET 
    `condition` = 'C'
WHERE
    id IN (SELECT 
            a.id
        FROM
            (SELECT 
                *
            FROM
                cars
            WHERE
                mileage >= 800000 OR mileage IS NULL) AS a
        WHERE
            a.`year` <= 2010
                AND a.make <> 'Mercedes-Benz');
