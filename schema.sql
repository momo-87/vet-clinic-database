/* Database schema to keep the structure of entire database. */
CREATE TABLE animals (
    name varchar(100)
);

create database vet_clinic;

create table animals(
id INT GENERATED ALWAYS AS IDENTITY,
name VARCHAR(250),
date_of_birth DATE,
escape_attempts INT,
neutered  BOOLEAN,
weight_kg DECIMAL
);

