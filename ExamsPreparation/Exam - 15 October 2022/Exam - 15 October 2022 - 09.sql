-- Write a query that returns the table_id, capacity, count_clients  and availability of all tables from the 1st floor.
-- Count_clients is the number of people from all orders that are sitting on that table. 
-- Availability is based on how many people are sitting and the capacity of the table. 
-- If the capacity is greater than count_clients than it should be "Free seats", 
-- if the capacity is equal to the count_clients it should be "Full", 
-- and if the capacity is lower than the count_clients it should be "Extra seats".
-- Order the results descending by table_id. 
SELECT 
    t.id AS table_id,
    t.capacity AS capacity,
    (SELECT 
            COUNT(*)
        FROM
            (SELECT 
                oc.client_id
            FROM
                orders AS o
            JOIN orders_clients AS oc ON o.id = oc.order_id
            WHERE
                o.table_id = t.id) AS x) AS count_clients,
    (CASE
        WHEN
            t.capacity > (SELECT 
                    COUNT(*)
                FROM
                    (SELECT 
                        oc.client_id
                    FROM
                        orders AS o
                    JOIN orders_clients AS oc ON o.id = oc.order_id
                    WHERE
                        o.table_id = t.id) AS x)
        THEN
            'Free seats'
        WHEN
            t.capacity < (SELECT 
                    COUNT(*)
                FROM
                    (SELECT 
                        oc.client_id
                    FROM
                        orders AS o
                    JOIN orders_clients AS oc ON o.id = oc.order_id
                    WHERE
                        o.table_id = t.id) AS x)
        THEN
            'Extra seats'
        ELSE 'Full'
    END) AS availability
FROM
    `tables` AS t
WHERE
    floor = 1
        AND (SELECT 
            COUNT(*)
        FROM
            (SELECT 
                oc.client_id
            FROM
                orders AS o
            JOIN orders_clients AS oc ON o.id = oc.order_id
            WHERE
                o.table_id = t.id) AS x) > 1
ORDER BY id DESC;

