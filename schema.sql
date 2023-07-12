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

-- Modify animals table
alter table animals add primary key(id); -- Set Id column as primary key in animals table
-- Remove column species
alter table animals
drop column species;
-- Add species_id column to animals table an set it as foreign key referencing species table
alter table animals add column species_id int;
alter table animals add foreign key (species_id) references species(id);
-- Add owners_id column to animals table an set it as foreign key referencing owners table
alter table animals add column owner_id int;
alter table animals add foreign key (owner_id) references owners(id);
