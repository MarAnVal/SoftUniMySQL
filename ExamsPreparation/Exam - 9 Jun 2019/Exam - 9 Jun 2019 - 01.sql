create DATABASE exam;
use exam;
-- branches – contains information about the branches.
CREATE TABLE branches (
    id INT(11) PRIMARY KEY AUTO_INCREMENT,
    `name` VARCHAR(30) NOT NULL
);
-- employees – contains information about the employees.
CREATE TABLE employees (
    id INT(11) PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(20) NOT NULL,
    last_name VARCHAR(20) NOT NULL,
    salary DECIMAL(10 , 2 ) NOT NULL,
    started_on DATE NOT NULL,
    branch_id INT(11) NOT NULL,
    CONSTRAINT fk_employees_branches FOREIGN KEY (branch_id)
        REFERENCES branches (id)
);
-- Each employee has a branch. 
-- clients – contains information about the clients.
CREATE TABLE clients (
    id INT(11) PRIMARY KEY AUTO_INCREMENT,
    full_name VARCHAR(50) NOT NULL,
    age INT(11) NOT NULL
);
-- employees_clients – a many to many mapping table between the employees and the clients.
CREATE TABLE employees_clients (
    employee_id INT(11),
    CONSTRAINT fk_employees_clients FOREIGN KEY (employee_id)
        REFERENCES employees (id),
    client_id INT(11),
    CONSTRAINT fk_clients_employees FOREIGN KEY (client_id)
        REFERENCES clients (id)
);
-- bank_accounts – contains information about the bank accounts.
CREATE TABLE bank_accounts (
    id INT(11) PRIMARY KEY AUTO_INCREMENT,
    account_number VARCHAR(10) NOT NULL,
    balance DECIMAL(10 , 2 ) NOT NULL,
    client_id INT(11) UNIQUE NOT NULL,
    CONSTRAINT fk_bank_accounts_clients FOREIGN KEY (client_id)
        REFERENCES clients (id)
);
-- Each bank_account has a client. 
-- cards – contains information about the cards.
CREATE TABLE cards (
    id INT(11) PRIMARY KEY AUTO_INCREMENT,
    card_number VARCHAR(19) NOT NULL,
    card_status VARCHAR(7) NOT NULL,
    bank_account_id INT(11) NOT NULL,
    CONSTRAINT fk_cards_bank_accounts FOREIGN KEY (bank_account_id)
        REFERENCES bank_accounts (id)
);
-- Each card has a client.
-- Each card has a bank_account.
SELECT COLUMN_KEY,TABLE_NAME, COLUMN_NAME FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_SCHEMA = DATABASE()
AND COLUMN_NAME IN ('id', 'branch_id', 'employee_id', 'client_id', 'bank_account_id', 'card_id')
ORDER BY TABLE_NAME, COLUMN_KEY;