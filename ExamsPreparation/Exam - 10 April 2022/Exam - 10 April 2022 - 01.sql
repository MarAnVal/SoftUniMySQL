create DATABASE exam;
use exam;

-- <--
CREATE TABLE countries (
    id INT(11) PRIMARY KEY AUTO_INCREMENT,
    `name` VARCHAR(30) NOT NULL UNIQUE,
    continent VARCHAR(30) NOT NULL,
    currency VARCHAR(5) NOT NULL
);

CREATE TABLE genres(
id int(11) PRIMARY KEY AUTO_INCREMENT,
`name` varchar(50) not null UNIQUE
);

CREATE TABLE actors (
    id INT(11) PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    birthdate DATE NOT NULL,
    height INT(11),
    awards INT(11),
    country_id INT(11) NOT NULL,
    CONSTRAINT fk_actors_countries FOREIGN KEY (country_id)
        REFERENCES countries (id)
);

CREATE TABLE movies_additional_info (
    id INT(11) PRIMARY KEY AUTO_INCREMENT,
    rating DECIMAL(10 , 2 ) NOT NULL,
    runtime INT(11) NOT NULL,
    picture_url VARCHAR(80) NOT NULL,
    budget DECIMAL(10 , 2 ),
    release_date DATE NOT NULL,
    has_subtitles BOOLEAN,
    `description` TEXT
);

CREATE TABLE movies (
    id INT(11) PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(70) NOT NULL UNIQUE,
    country_id INT(11) NOT NULL,
    CONSTRAINT fk_movies_countries FOREIGN KEY (country_id)
        REFERENCES countries (id),
    movie_info_id INT(11) NOT NULL UNIQUE,
    CONSTRAINT fk_movies_movies_additional_info FOREIGN KEY (movie_info_id)
        REFERENCES movies_additional_info (id)
);

CREATE TABLE movies_actors (
    movie_id INT(11),
    CONSTRAINT fk_movies FOREIGN KEY (movie_id)
        REFERENCES movies (id),
    actor_id INT(11),
    CONSTRAINT fk_actors FOREIGN KEY (actor_id)
        REFERENCES actors (id)
);

CREATE TABLE genres_movies (
    genre_id INT(11),
    CONSTRAINT fk_genres_movies FOREIGN KEY (genre_id)
        REFERENCES genres (id),
    movie_id INT(11),
    CONSTRAINT fk_movies_genres FOREIGN KEY (movie_id)
        REFERENCES movies (id)
);