-- Create vet_clinic database
create database vet_clinic;

-- Create animals table
create table animals(
id INT GENERATED ALWAYS AS IDENTITY,
name VARCHAR(250),
date_of_birth DATE,
escape_attempts INT,
neutered  BOOLEAN,
weight_kg DECIMAL
);

-- Add a column species of type string to animals table
alter table animals
add column species varchar(250);