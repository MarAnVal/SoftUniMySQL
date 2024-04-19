-- Extract from the database, all branches with the count of their issued cards. 
-- Order the results by the count of cards, then by branch name.

SELECT 
    b.`name` AS `name`, COUNT(c.id) AS count_of_cards
FROM
    cards AS c
        JOIN
    bank_accounts AS ba ON ba.id = c.bank_account_id
        JOIN
    employees_clients AS ec ON ba.client_id = ec.client_id
        JOIN
    employees AS e ON ec.employee_id = e.id
        RIGHT JOIN
    branches AS b ON b.id = e.branch_id
GROUP BY `name`
ORDER BY count_of_cards DESC , `name`;