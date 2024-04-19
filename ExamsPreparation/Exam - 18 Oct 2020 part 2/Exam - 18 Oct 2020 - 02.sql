-- Update all employees that hire after 2003(exclusive) year and not work in store Cardguard and Veribet. 
-- Set their manager to be Carolyn Q Dyett (with id 3) and decrease salary with 500.
SET SQL_SAFE_UPDATES = 0;
UPDATE employees AS e
        JOIN
    stores AS s ON e.store_id = s.id 
SET 
    manager_id = (CASE
        WHEN
            YEAR(e.hire_date) > 2003
                AND s.`name` NOT IN ('Cardguard' , 'Veribet')
        THEN
            3
        ELSE manager_id
    END);
UPDATE employees AS e
        JOIN
    stores AS s ON e.store_id = s.id 
SET 
    salary = (CASE
        WHEN
            YEAR(e.hire_date) > 2003
                AND s.`name` NOT IN ('Cardguard' , 'Veribet')
        THEN
            salary - 500
        ELSE salary
    END);