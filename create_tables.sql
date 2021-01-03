
DROP TABLE IF EXISTS response;
DROP TABLE IF EXISTS vacancy;
DROP TABLE IF EXISTS area;
DROP TABLE IF EXISTS employer;
DROP TABLE IF EXISTS resume;
DROP TABLE IF EXISTS profession;
DROP TABLE IF EXISTS employee;


CREATE TABLE IF NOT EXISTS employee (
    employee_id serial PRIMARY KEY,
    fullname VARCHAR (64) NOT NULL,
    email VARCHAR (255) UNIQUE NOT NULL,
    created_on TIMESTAMP NOT NULL DEFAULT NOW(),
    last_login TIMESTAMP 
);

CREATE TABLE IF NOT EXISTS profession (
    profession_id SERIAL PRIMARY KEY,
    name VARCHAR(128)
);

CREATE TABLE IF NOT EXISTS resume (
    resume_id serial PRIMARY KEY,
    employee_id INT,
    profession_id INT,
    name VARCHAR (64) NOT NULL,
    description TEXT,
    CONSTRAINT fk_profession
        FOREIGN KEY (profession_id) REFERENCES profession(profession_id),
    CONSTRAINT fk_employee
        FOREIGN KEY (employee_id) REFERENCES employee(employee_id)
);

CREATE TABLE IF NOT EXISTS employer (
    employer_id SERIAL PRIMARY KEY,
    name VARCHAR (64) NOT NULL
);

CREATE TABLE IF NOT EXISTS area (
    area_id SERIAL PRIMARY KEY,
    name VARCHAR (64) NOT NULL
);

CREATE TABLE IF NOT EXISTS vacancy (
    vacancy_id SERIAL PRIMARY KEY,
    profession_id INT REFERENCES profession(profession_id),
    employer_id INT REFERENCES employer(employer_id),
    area_id INT REFERENCES area(area_id),
    name VARCHAR (128),
    description TEXT,
    compensation_from INT,
    compensation_to INT,
    compensation_gross BOOLEAN DEFAULT true,
    created_on TIMESTAMP DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS response (
    response_id SERIAL PRIMARY KEY,
    resume_id INTEGER REFERENCES resume,
    vacancy_id INTEGER REFERENCES vacancy,
    created_on TIMESTAMP DEFAULT NOW()
);
