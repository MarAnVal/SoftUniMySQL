CREATE TABLE pictures (
    id INT(11) PRIMARY KEY AUTO_INCREMENT,
    url VARCHAR(100) NOT NULL,
    added_on DATETIME NOT NULL
);

CREATE TABLE categories (
    id INT(11) PRIMARY KEY AUTO_INCREMENT,
    `name` VARCHAR(40) UNIQUE NOT NULL
);

CREATE TABLE products (
    id INT(11) PRIMARY KEY AUTO_INCREMENT,
    `name` VARCHAR(40) UNIQUE NOT NULL,
    best_before DATE,
    price DECIMAL(10 , 2 ) NOT NULL,
    `description` TEXT,
    category_id INT(11) NOT NULL,
     CONSTRAINT fk_products_categories FOREIGN KEY (category_id)
        REFERENCES categories (id),
    picture_id INT(11) NOT NULL,   
    CONSTRAINT fk_products_pictures FOREIGN KEY (picture_id)
        REFERENCES pictures (id)
);

CREATE TABLE towns (
    id INT(11) PRIMARY KEY AUTO_INCREMENT,
    `name` VARCHAR(20) UNIQUE NOT NULL
);

CREATE TABLE addresses (
    id INT(11) PRIMARY KEY AUTO_INCREMENT,
    `name` VARCHAR(50) UNIQUE NOT NULL,
    town_id INT(11) NOT NULL,
    CONSTRAINT fk_addresses_towns FOREIGN KEY (town_id)
        REFERENCES towns (id)
);

CREATE TABLE stores (
    id INT(11) PRIMARY KEY AUTO_INCREMENT,
    `name` VARCHAR(20) UNIQUE NOT NULL,
    rating FLOAT NOT NULL,
    has_parking BOOLEAN DEFAULT 0,
    address_id INT(11) NOT NULL,
    CONSTRAINT fk_stores_addresses FOREIGN KEY (address_id)
        REFERENCES addresses (id)
);

CREATE TABLE products_stores (
    product_id INT(11) NOT NULL,
    CONSTRAINT fk_products FOREIGN KEY (product_id)
        REFERENCES products (id),
    store_id INT(11) NOT NULL,
    CONSTRAINT fk_stores FOREIGN KEY (store_id)
        REFERENCES stores (id),
        constraint pk_products_stores PRIMARY KEY (product_id, store_id)
);

CREATE TABLE employees (
    id INT(11) PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(15) NOT NULL,
    middle_name CHAR(1),
    last_name VARCHAR(20) NOT NULL,
    salary DECIMAL(19 , 2 ) NOT NULL DEFAULT 0,
    hire_date DATE NOT NULL,
    manager_id INT(11),
    CONSTRAINT fk_employees_managers FOREIGN KEY (manager_id)
        REFERENCES employees (id),
    store_id INT(11) NOT NULL,    
    CONSTRAINT fk_employees_stores FOREIGN KEY (store_id)
        REFERENCES stores (id)
);