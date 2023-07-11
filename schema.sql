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

-- Create owners table
create table owners(
id int generated always as identity primary key,
full_name varchar(250),
age int
);

-- Create species table
create table species(
id int generated always as identity primary key,
name varchar(250)
);