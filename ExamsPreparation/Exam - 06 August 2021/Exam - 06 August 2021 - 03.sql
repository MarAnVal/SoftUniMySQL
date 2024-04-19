-- After a good work in recent months, management has decided to raise the salaries of all young team leaders.
-- Update all young employees (only team leaders) with age under 40(exclusive) and increase their salary with 1000. 
-- Skip the employees with salary over 5000(inclusive). Their salaries are already high.
SET SQL_SAFE_UPDATES = 0;
UPDATE employees 
SET 
    salary = salary + 1000
WHERE
    id IN (SELECT 
            t.leader_id
        FROM
            teams as t)
        AND salary < 5000
        AND age < 40;

