SQL
  - SQL or Structured Query Language 
  - we use to talk to databases.
    - Databases collect and organize data to
    allow for easy retrieval.

TSQL, SQLite, MySQL, Postgres, Oracle and Microsoft SQL 

No SQL 
  MongoDB CouchDB

PostgreSQL

integer
boolean
dates 
varchar 
text 
time 
timestamp


Database
  The term when describing the whole database server

Table
  A container that is stored inside of the database server
  A Table can have many rows

Row
  The actual data that is stored in the table
  Often referred to as a record as well

Column
  Is a value that is stored in a Row

PRIMARY KEY
  All database tables should have a primary key, this should be a 
  unique key that is used as a safe way to look up a row in your 
  database
  id 

NOT NULL
  Means that specific value in the row needs to be there or the 
  database won’t let you save that record  

UNIQUE
  Means that the value of data in that row cannot be in any other row

DEFAULT
  This gives a default value to the column of a row







Most Common PostgreSQL DataTypes:
  integer     1
  varchar     c 
  boolean     true false
  date        YYYY-MM-DD
  text        text
  time        HH:MI:SS 
  timestamp   YYYY-MM-DD HH:MI:SS


CRUD
  create
  Read
  update
  destroy 

SQL Commands
  SELECT - extracts data from a database
  UPDATE - updates data in a database
  DELETE - deletes data from a database
  INSERT INTO - inserts new data into a database
  CREATE DATABASE - creates a new database
  ALTER DATABASE - modifies a database
  CREATE TABLE - creates a new table
  ALTER TABLE - modifies a table
  DROP TABLE - deletes a table
  CREATE INDEX - creates an index (search key)
  DROP INDEX - deletes an index


Constraits
NOT NULL (Links to an external site.) 
  - Ensures that a column cannot have a NULL value
UNIQUE (Links to an external site.) 
  - Ensures that all values in a column are different
PRIMARY KEY (Links to an external site.) 
  - A combination of a NOT NULL and UNIQUE. Uniquely identifies 
    each row in a table
FOREIGN KEY (Links to an external site.) 
  - Uniquely identifies a row/record in another table
CHECK (Links to an external site.) 
  - Ensures that all values in a column satisfy 
  a specific condition
DEFAULT (Links to an external site.) 
  - Sets a default value for a column when no value is specified
INDEX (Links to an external site.) 
  - Use to create and retrieve data from 
  the database very quickly


-- Comment 
CREATE DATABASE dealership_winter20;

\c dealership_winter20;

CREATE TABLE cars(
  id SERIAL PRIMARY KEY, 
  make VARCHAR(50) NOT NULL,
  model VARCHAR(50) NOT NULL,
  year INTEGER NOT NULL,
  color VARCHAR(25) NOT NULL,
  mileage INTEGER NOT NULL,
  runs BOOLEAN DEFAULT true
)

INSERT INTO cars (make, model, color, year, mileage) 
VALUES ('Honda', 'Civic', 'Black', 2010, 160000);

INSERT INTO cars (make, model, color, year, mileage) 
VALUES ("Dodge", "Derango", "Grey", 1994, 200000 );

INSERT INTO cars (make, model, color, year, mileage, runs)
VALUES ('Jeep', 'Cherokee', 'Black', 2011, 332131, DEFAULT),
       ('Toyota', 'Tacoma', 'White', 2017, 50, DEFAULT),
       ('Ford', 'F150', 'Sliver', 1999, 100000, false),
       ('Toyota', 'Prius', 'Green', 2013, 54313, DEFAULT),
       ('Dodge', 'Ram', 'Blue', 1983, 65234132, false),
       ('Ford', 'Focus', 'Purple', 1993, 4321421, DEFAULT),
       ('Jaguar', 'F-Type', 'Gold', 2018, 0, DEFAULT);

SELECT column1, column2 FROM table_name 

SELECT make, model FROM cars 

SELECT * FROM cars 

SELECT * FROM cars 
WHERE cars.year > 2015

-- AND 
SELECT * FROM cars 
WHERE cars.year > 2015 AND cars.runs = true AND cars.mileage < 100000

-- OR 
SELECT * FROM cars 
WHERE cars.year > 2015 OR cars.runs = true


SELECT * FROM cars 
WHERE (cars.year > 2015 AND cars.make = 'Ford') OR cars.runs = true

-- NOT 
SELECT make, model FROM cars 
WHERE NOT cars.make = 'Ford'

SELECT * FROM cars;

-- Order BY
SELECT * FROM cars
ORDER BY cars.year 

SELECT * FROM cars
ORDER BY cars.year DESC

-- UPDATE
UPDATE cars 
SET year = '2004'
WHERE cars.id = 2;

-- warning don't have a where clause it will update all of them
-- no going back

-- Delete 
DELETE FROM cars 
WHERE cars.id = 5

-- warning don't have a where clause it will delete all of them
-- no going back

-- Like 
  % 
  _ 

  SELECT * FROM cars 
  WHERE cars.make LIKE 'J%'

-- In 
  SELECT * FROM cars 
  WHERE cars.year > 2015 OR cars.runs = true OR cars.color = 'yellow'
  
  SELECT * FROM cars 
  WHERE cars.model = 'Ford' OR cars.model = 'Jeep' OR cars.model = 'Honda'

  SELECT * FROM cars 
  WHERE cars.model IN ('Ford', 'Jeep', 'Honda')


-- Between
SELECT * FROM cars 
WHERE cars.mileage > 0 AND cars.mileage < 100000

SELECT * FROM cars 
WHERE cars.mileage BETWEEN 0 AND 100000

-- Alias
SELECT * FROM cars AS c 
WHERE c.year > 2015

SELECT make, model, year AS y, mileage as m
FROM cars 
WHERE m = 1000


-- Relationship
CREATE TABLE parts(
  id SERIAL PRIMARY KEY,
  name VARCHAR(50) NOT NULL, 
  description VARCHAR(50) NOT NULL, 
  serial_number BIGINT UNIQUE NOT NULL,
  broken BOOLEAN DEFAULT false,
  car_id INTEGER REFERENCES cars
)

INSERT INTO parts (name, description, serial_number, car_id, broken)
VALUES (
         'Hood Scoop', 
         '10 More Horse Power', 
         (SELECT floor(random()*(5341254321-1+1))+1), 
         (SELECT id FROM cars ORDER BY RANDOM() LIMIT 1), 
         DEFAULT
       ),
       (
         'Spoiler', 
         '50 More Horse Power', 
         (SELECT floor(random()*(5341254321-1+1))+1), 
         (SELECT id FROM cars ORDER BY RANDOM() LIMIT 1),
         true
       ),
       (
         'Rims And Tires', 
         'Looks So Good!', 
         (SELECT floor(random()*(5341254321-1+1))+1), 
         (SELECT id FROM cars ORDER BY RANDOM() LIMIT 1),
         DEFAULT
       ),
       (
         'Lift Kit', 
         'Climb Mountains!', 
         (SELECT floor(random()*(5341254321-1+1))+1), 
         (SELECT id FROM cars ORDER BY RANDOM() LIMIT 1),
         true
       );

-- Join
Inner Join Returns records that have matches values in both tables
Left (Outer) Join records values in left tables and matches records from the right table
Right (Outer) Join records values in right tables and matches records from the left table
Full Outer Join Returns and match all of the records and matches from both tables 

SELECT p.name, p.broken, p.serial_number, c.make, c.model 
FROM cars AS c 
INNER JOIN parts AS p ON p.car_id = c.id 

SELECT p.name, p.broken, p.serial_number, c.make, c.model 
FROM cars AS c 
LEFT JOIN parts AS p ON p.car_id = c.id 

-- no going back from these statements 
DROP DATABASE databasename

DROP TABLE table_name
DROP TABLE parts 


-- Alter 
-- add column 
ALTER TABLE table_name
ADD column_name datatype constraits

ALTER TABLE cars 
ADD interior VARCHAR(50) NOT NULL

-- delete a column
ALTER TABLE cars
DROP interior 

-- modify
ALTER TABLE table_name
ALTER column_name Newdatatype Newconstraits