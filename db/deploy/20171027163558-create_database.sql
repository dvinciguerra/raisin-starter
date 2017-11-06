-- Deploy raisin:20171027163558-create_database to pg

-- execute
-- CREATE DATABASE :DBNAME

CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
ALTER DATABASE :DBNAME SET timezone TO 'UTC';

