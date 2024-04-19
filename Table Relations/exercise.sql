create DATABASE people;
use people;

-- 1
CREATE TABLE people (
    person_id INT NOT NULL UNIQUE AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    salary DECIMAL(10 , 2 ) DEFAULT 0,
    passport_id INT UNIQUE
);

CREATE TABLE passports (
    passport_id INT PRIMARY KEY AUTO_INCREMENT,
    passport_number VARCHAR(8) UNIQUE
);

INSERT INTO people(person_id, first_name, salary, passport_id) VALUES
(1, 'Roberto', 43300.00, 102),
(2, 'Tom', 56100.00, 103),
(3, 'Yana', 60200.00, 101);

INSERT into passports(passport_id, passport_number) VALUES
(101, 'N34FG21B'),
(102, 'K65LO4R7'),
(103, 'ZE657QP2');

ALTER TABLE people
ADD CONSTRAINT pk_people 
PRIMARY KEY (person_id),
ADD CONSTRAINT fk_people_passports
FOREIGN KEY (passport_id)
REFERENCES passports (passport_id);

-- 2
create DATABASE cars;
use cars;

CREATE TABLE manufacturers (
    manufacturer_id INT PRIMARY KEY AUTO_INCREMENT,
    `name` VARCHAR(50) UNIQUE,
    established_on DATE
);

CREATE TABLE models (
    model_id INT PRIMARY KEY AUTO_INCREMENT,
    `name` VARCHAR(50) NOT NULL,
    manufacturer_id INT,
    CONSTRAINT fk_models_manufacturers FOREIGN KEY (manufacturer_id)
        REFERENCES manufacturers (manufacturer_id)
);

ALTER TABLE models AUTO_INCREMENT = 101;

INSERT INTO manufacturers(`name`, established_on) VALUES
('BMW', '1916-03-01'),
('Tesla', '2003-01-01'),
('Lada', '1966-05-01');

INSERT INTO models(`name`, manufacturer_id) VALUES
('X1', 1),
('i6', 1),
('Model S', 2),
('Model X', 2),
('Model 3', 2),
('Nova', 3);

-- 3
create DATABASE students;
use students;

CREATE TABLE exams (
    exam_id INT PRIMARY KEY AUTO_INCREMENT,
    `name` VARCHAR(50) NOT NULL
)  AUTO_INCREMENT=101;

INSERT INTO exams(`name`) VALUES
('Spring MVC'),
('Neo4j'),
('Oracle 11g');

CREATE TABLE students (
    student_id INT PRIMARY KEY AUTO_INCREMENT,
    `name` VARCHAR(50) NOT NULL
);

insert into students(`name`) values
('Mila'),
('Toni'),
('Ron');

CREATE TABLE students_exams (
    student_id INT,
    exam_id INT,
    CONSTRAINT pk_students_exams PRIMARY KEY (exam_id , student_id),
    CONSTRAINT fk_students_exams FOREIGN KEY (exam_id)
        REFERENCES exams (exam_id),
    CONSTRAINT fk_exams_students FOREIGN KEY (student_id)
        REFERENCES students (student_id)
);

INSERT into students_exams(student_id, exam_id) VALUES
(1, 101),
(1, 102),
(2, 101),
(3, 103),
(2, 102),
(2, 103);

-- 4
CREATE TABLE teachers (
    teacher_id INT PRIMARY KEY AUTO_INCREMENT,
    `name` VARCHAR(50) NOT NULL,
    manager_id INT,
    CONSTRAINT `fk` FOREIGN KEY (`manager_id`)
        REFERENCES `teachers` (`teacher_id`)
        ON UPDATE CASCADE
)  AUTO_INCREMENT=101;

INSERT INTO teachers(`name`) VALUES
('John'),
('Maya'),
('Silvia'),
('Ted'),
('Mark'),
('Greta');

UPDATE teachers 
SET 
    manager_id = 106
WHERE
    teacher_id = 102;
UPDATE teachers 
SET 
    manager_id = 106
WHERE
    teacher_id = 103;
UPDATE teachers 
SET 
    manager_id = 105
WHERE
    teacher_id = 104;
UPDATE teachers 
SET 
    manager_id = 101
WHERE
    teacher_id = 105;
UPDATE teachers 
SET 
    manager_id = 101
WHERE
    teacher_id = 106;
    
-- 5
create DATABASE `Online Store`;
use `Online Store`;

CREATE TABLE cities (
    city_id INT(11) PRIMARY KEY AUTO_INCREMENT,
    `name` VARCHAR(50)
);

CREATE TABLE customers (
    customer_id INT(11) PRIMARY KEY AUTO_INCREMENT,
    `name` VARCHAR(50),
    birthday DATE,
    city_id INT(11),
    CONSTRAINT fk_customers_cities FOREIGN KEY (city_id)
        REFERENCES cities (city_id)
);

CREATE TABLE orders (
    order_id INT(11) PRIMARY KEY AUTO_INCREMENT,
    customer_id INT(11),
    CONSTRAINT fk_orders_customers FOREIGN KEY (customer_id)
        REFERENCES customers (customer_id)
);

CREATE TABLE item_types (
    item_type_id INT(11) PRIMARY KEY AUTO_INCREMENT,
    `name` VARCHAR(50)
);

CREATE TABLE items(
item_id INT(11) PRIMARY KEY AUTO_INCREMENT,
`name` VARCHAR(50),
item_type_id INT(11),
CONSTRAINT fk_item_item_types FOREIGN KEY (item_type_id)
        REFERENCES item_types (item_type_id)
);

CREATE TABLE order_items (
    order_id INT(11),
    item_id INT(11),
    CONSTRAINT fk_order_item FOREIGN KEY (order_id)
        REFERENCES orders (order_id),
    CONSTRAINT fk_item_order FOREIGN KEY (item_id)
        REFERENCES items (item_id),
    CONSTRAINT PRIMARY KEY (order_id , item_id)
);

-- 6
CREATE DATABASE `University`;
use `University`;

CREATE TABLE majors (
    major_id INT(11) PRIMARY KEY AUTO_INCREMENT,
    `name` VARCHAR(50)
);

CREATE TABLE students (
    student_id INT(11) PRIMARY KEY AUTO_INCREMENT,
    student_number VARCHAR(12),
    student_name VARCHAR(50),
    major_id INT(11),
    CONSTRAINT fk_students_majors FOREIGN KEY (major_id)
        REFERENCES majors (major_id)
);

CREATE TABLE payments (
    payment_id INT(11) PRIMARY KEY AUTO_INCREMENT,
    payment_date DATE,
    payment_amount DECIMAL(8 , 2 ),
    student_id INT(11),
    CONSTRAINT fk_payments_students FOREIGN KEY (student_id)
        REFERENCES students (student_id)
);

CREATE TABLE subjects (
    subject_id INT(11) PRIMARY KEY AUTO_INCREMENT,
    subject_name VARCHAR(50)
);

CREATE TABLE agenda (
    student_id INT(11),
    subject_id INT(11),
    CONSTRAINT fk_agenda_students FOREIGN KEY (student_id)
        REFERENCES students (student_id),
    CONSTRAINT fk_agenda_subjects FOREIGN KEY (subject_id)
        REFERENCES subjects (subject_id),
    CONSTRAINT pk_agenda PRIMARY KEY (student_id , subject_id)
);


-- 6
SELECT 
    m.mountain_range, p.peak_name, p.elevation AS peak_elevation
FROM
    peaks AS p
        JOIN
    mountains AS m
WHERE
    p.mountain_id = m.id
        AND mountain_range = 'Rila'
ORDER BY peak_elevation DESC;
