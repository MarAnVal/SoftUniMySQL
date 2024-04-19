CREATE DATABASE minions;
use minions;
-- 1
CREATE TABLE minions (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50),
    age INT
);

CREATE TABLE towns (
    town_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50)
);

-- 2
alter table minions
add column town_id int;

alter table minions
add constraint fk_minions_towns
foreign key minions(town_id)
references towns(id);

-- 3
insert into towns(id, name) values
(1, 'Sofia'),
(2, 'Plovdiv'),
(3, 'Varna');
insert into minions(name, age,town_id) values
('Kevin', 22, 1),
('Bob', 15, 3),
('Steward', NULL, 2);

SELECT 
    *
FROM
    minions;
--
-- 4
truncate table minions;

-- 5
drop table minions;
drop table towns;

-- 6 
CREATE TABLE people (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(200) NOT NULL,
    picture BLOB,
    height DOUBLE(10 , 2 ),
    weight DOUBLE(10 , 2 ),
    gender CHAR(1) NOT NULL,
    birthdate DATE NOT NULL,
    biography TEXT
);
insert into people (id, name, gender, birthdate) values
(1, 'test', 'm', date(now())),
(2, 'test', 'm', date(now())),
(3, 'test', 'm', date(now())),
(4, 'test', 'm', date(now())),
(5, 'test', 'm', date(now()));

-- 7
CREATE TABLE users (
    id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(30) NOT NULL,
    password VARCHAR(26) NOT NULL,
    profile_picture BLOB,
    last_login_time DATETIME,
    is_deleted BOOLEAN
);

insert into users (id, username, password) values
(1, 'test', '1234'),
(2, 'test', '1234'),
(3, 'test', '1234'),
(4, 'test', '1234'),
(5, 'test', '1234');

-- 8
alter table users
drop primary key,
add constraint pk_users2
primary key users(id, usernae);

-- 9
alter table users
change column last_login_time last_login_time datetime default now();

-- 10
alter table users
drop primary key,
add constraint pk_users
primary key users(id),
change column username username varchar(30) unique;

-- 11
create database movies;
use movies;
CREATE TABLE directors (
    id INT PRIMARY KEY AUTO_INCREMENT,
    director_name VARCHAR(100) NOT NULL,
    notes TEXT
);

insert into directors(id, director_name) values
(1, 'test'),
(2, 'test'),
(3, 'test'),
(4, 'test'),
(5, 'test');

CREATE TABLE genres (
    id INT PRIMARY KEY AUTO_INCREMENT,
    genre_name VARCHAR(50) NOT NULL,
    notes TEXT
);

insert into genres(id, genre_name) values
(1, 'test'),
(2, 'test'),
(3, 'test'),
(4, 'test'),
(5, 'test');

CREATE TABLE categories (
    id INT PRIMARY KEY AUTO_INCREMENT,
    category_name VARCHAR(50) NOT NULL,
    notes TEXT
);

insert into categories(id, category_name) values
(1, 'test'),
(2, 'test'),
(3, 'test'),
(4, 'test'),
(5, 'test');

CREATE TABLE movies (
    id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(100) NOT NULL,
    director_id INT,
    copyright_year YEAR,
    length DOUBLE(2 , 2),
    genre_id INT,
    category_id INT,
    rating DOUBLE(3 , 2),
    notes TEXT,
    CONSTRAINT fk_movies_directors FOREIGN KEY (director_id)
        REFERENCES directors (id),
    CONSTRAINT fk_movies_genres FOREIGN KEY (genre_id)
        REFERENCES genres (id),
    CONSTRAINT fk_movies_categories FOREIGN KEY (category_id)
        REFERENCES categories (id)
);

insert into movies(id, title, director_id, genre_id, category_id) values
(1, 'test', 1, 2, 3),
(2, 'test', 2, 3, 4),
(3, 'test', 3, 4, 5),
(4, 'test', 4, 5, 1),
(5, 'test', 5, 1, 2);

-- 12
create database soft_uni;
use soft_uni;

CREATE TABLE towns (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50)
);

insert into towns (name) values
('Sofia'),
('Plovdiv'),
('Varna'),
('Burgas');

CREATE TABLE addresses (
    id INT PRIMARY KEY AUTO_INCREMENT,
    address_text TEXT,
    town_id INT,
    CONSTRAINT fk_addresses_towns FOREIGN KEY (town_id)
        REFERENCES towns (id)
);

CREATE TABLE departments (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50)
);

insert into departments (name) values
('Engineering'),
('Sales'),
('Marketing'),
('Software Development'),
('Quality Assurance');

CREATE TABLE employees (
    id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    middle_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    job_title VARCHAR(50) NOT NULL,
    department_id INT,
    hire_date DATE NOT NULL,
    salary DOUBLE(10 , 2 ) NOT NULL,
    address_id INT,
    CONSTRAINT fk_employees_departments FOREIGN KEY (department_id)
        REFERENCES departments (id),
    CONSTRAINT fk_employees_addresses FOREIGN KEY (address_id)
        REFERENCES addresses (id)
);
 
 insert into employees (first_name, middle_name, last_name, job_title, department_id, hire_date, salary) values
 ('Ivan', 'Ivanov', 'Ivanov', '.NET Developer', 4, 20130201, 3500.00),
 ('Petar', 'Petrov', 'Petrov', 'Senior Engineer', 1, 20040302, 4000.00),
 ('Maria', 'Petrova', 'Ivanova','Intern', 5, 20160828, 525.25),
 ('Georgi', 'Terziev', 'Ivanov', 'CEO', 2, 20071209, 3000.00),
 ('Peter', 'Pan', 'Pan', 'Intern', 3, 20160828, 599.88);
 
 -- 14
SELECT 
    *
FROM
    towns;
SELECT 
    *
FROM
    departments;
SELECT 
    *
FROM
    employees;
    
-- 15
SELECT 
    *
FROM
    towns as t order by t.name;
SELECT 
    *
FROM
    departments as d order by d.name;
SELECT 
    *
FROM
    employees as e order by e.salary desc;
    
-- 16
SELECT
    t.name
FROM
    towns as t order by t.name;
SELECT 
    d.name
FROM
    departments AS d
ORDER BY d.name;
SELECT 
    e.first_name, e.last_name, e.job_title, e.salary
FROM
    employees AS e
ORDER BY e.salary DESC;

-- 17
update employees
set salary = salary * 1.1;
select salary from employees;

-- 12 !!!!!
create database car_rental;
use car_rental;

CREATE TABLE categories (
    id INT PRIMARY KEY AUTO_INCREMENT,
    category VARCHAR(50),
    daily_rate DOUBLE(10 , 2 ) NOT NULL,
    weekly_rate DOUBLE(10 , 2 ),
    monthly_rate DOUBLE(10 , 2 ),
    weekend_rate DOUBLE(10 , 2 )
);
insert into categories (daily_rate) values
(1.2),
(1.2),
(1.2);

CREATE TABLE cars (
    id INT PRIMARY KEY AUTO_INCREMENT,
    plate_number VARCHAR(12),
    make VARCHAR(50),
    model VARCHAR(50) NOT NULL,
    car_year YEAR,
    category_id INT,
    doors INT,
    picture BLOB,
    car_condition VARCHAR(50),
    available BOOLEAN,
    CONSTRAINT fk_cars_categories FOREIGN KEY (category_id)
        REFERENCES categories (id)
);

insert into cars (model) values
('test'),
('test'),
('test');

CREATE TABLE employees (
    id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    title VARCHAR(50),
    notes TEXT
);

insert into employees (first_name, last_name) values
('test', 'test'),
('test', 'test'),
('test', 'test');

CREATE TABLE customers (
    id INT PRIMARY KEY AUTO_INCREMENT,
    driver_licence_number INT,
    full_name VARCHAR(150) NOT NULL,
    address TEXT,
    city VARCHAR(50),
    zip_code INT,
    notes TEXT
);
insert into customers (full_name) values
('test'),
('test'),
('test');

CREATE TABLE rental_orders (
    id INT PRIMARY KEY AUTO_INCREMENT,
    employee_id INT NOT NULL,
    customer_id INT NOT NULL,
    car_id INT NOT NULL,
    car_condition VARCHAR(50),
    tank_level INT,
    kilometrage_start INT,
    kilometrage_end INT,
    total_kilometrage INT,
    start_date DATE,
    end_date DATE,
    total_days INT,
    rate_applied DOUBLE(10 , 2 ),
    tax_rate DOUBLE(10 , 2 ),
    order_status VARCHAR(50),
    notes TEXT    -- ,
   --  CONSTRAINT fk_rental_orders_employees FOREIGN KEY (employee_id)
--         REFERENCES employees (id),
--     CONSTRAINT fk_rental_orders_customers FOREIGN KEY (customer_id)
--         REFERENCES customers (id),
--     CONSTRAINT fk_rental_orders_cars FOREIGN KEY (car_id)
--         REFERENCES cars (id)
);

insert into rental_orders (employee_id, customer_id, car_id) values
(1, 2, 3),
(2, 3, 1),
(3, 1, 2);


    
 