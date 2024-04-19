-- You will have to insert records of data into the cards table, based on the clients table. 
-- For clients with id between 191 and 200 (inclusive), insert data in the cards table with the following values:
-- card_number – set it to full name of the client, but reversed!   
-- card_status – set it to "Active".
-- bank_account_id –set it to client's id value. 
INSERT into cards (card_number, card_status, bank_account_id)
SELECT DISTINCT
    REVERSE(c.full_name) AS card_number,
    'Active' AS card_status,
    c.id AS bank_account_id
FROM
    cards AS cr
        RIGHT JOIN
    bank_accounts AS ba ON ba.id = cr.bank_account_id
        RIGHT JOIN
    clients AS c ON c.id = ba.client_id
WHERE
    c.id BETWEEN 191 AND 200;

