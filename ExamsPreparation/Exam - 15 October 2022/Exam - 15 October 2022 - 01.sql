CREATE DATABASE exam;
USE exam;

-- <--
CREATE TABLE products (
    id INT(11) PRIMARY KEY AUTO_INCREMENT,
    `name` VARCHAR(30) NOT NULL UNIQUE,
    `type` VARCHAR(30) NOT NULL,
    price DECIMAL(10 , 2 ) NOT NULL
);

CREATE TABLE clients (
    id INT(11) PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    birthdate DATE NOT NULL,
    card VARCHAR(50),
    review TEXT
);

CREATE TABLE `tables` (
    id INT(11) PRIMARY KEY AUTO_INCREMENT,
    floor INT(11) NOT NULL,
    reserved BOOLEAN,
    capacity INT(11) NOT NULL
);

CREATE TABLE waiters (
    id INT(11) PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(50) NOT NULL,
    phone VARCHAR(50),
    salary DECIMAL(10 , 2 )
);

CREATE TABLE orders (
    id INT(11) PRIMARY KEY AUTO_INCREMENT,
    table_id INT(11) NOT NULL,
    CONSTRAINT fk_orders_tables FOREIGN KEY (table_id)
        REFERENCES `tables` (id),
    waiter_id INT(11) NOT NULL,
    CONSTRAINT fk_orders_waiters FOREIGN KEY (waiter_id)
        REFERENCES waiters (id),
    order_time TIME NOT NULL,
    payed_status BOOLEAN
);

CREATE TABLE orders_clients (
    order_id INT(11),
    CONSTRAINT fk_clients_orders FOREIGN KEY (order_id)
        REFERENCES orders (id),
    client_id INT(11),
    CONSTRAINT fk_orders_clients FOREIGN KEY (client_id)
        REFERENCES clients (id)
);

CREATE TABLE orders_products (
    order_id INT(11),
    CONSTRAINT fk_products_orders FOREIGN KEY (order_id)
        REFERENCES orders (id),
    product_id INT(11),
    CONSTRAINT fk_orders_products FOREIGN KEY (product_id)
        REFERENCES products (id)
);