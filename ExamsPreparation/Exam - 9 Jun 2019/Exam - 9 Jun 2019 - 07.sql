-- Extract from the database, all of the cards, and the clients that own them, so that they end up in the following format:
-- {card_number} : {full_name}
-- Order the results descending by card id.
SELECT 
    cr.id AS id,
    CONCAT_WS(' : ',
            UPPER(cr.card_number),
            cl.full_name) AS card_token
FROM
    cards AS cr
        JOIN
    bank_accounts AS ba ON ba.id = cr.bank_account_id
        JOIN
    clients AS cl ON cl.id = ba.client_id
ORDER BY id DESC;

