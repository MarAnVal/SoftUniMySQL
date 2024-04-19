create database gamebar;
use gamebar;

CREATE TABLE employees (
    id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    first_name VARCHAR(50),
    last_name VARCHAR(50)
);

CREATE TABLE categories (
    id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL
);

CREATE TABLE products (
  id INT PRIMARY KEY NOT NULL,
  `name` VARCHAR(50),
  category_id INT,
  CONSTRAINT fk_categories_products
  foreign key products(category_id)
  references categories(id)
  );

