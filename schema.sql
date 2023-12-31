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

-- Create a table named vets
create table vets(
id int generated always as identity primary key,
name varchar(255),
age int,
date_of_graduation date
 );

--  Create a 'join table' called specializations to handle the  relationship between species and vets tables
create table specializations(
species_id int,
vet_id int,
foreign key (species_id) references species(id),
foreign key (vet_id) references vets(id)
);

--  Create a 'join table' called visits to handle the relationship between animals and vets
create table visits(
animal_id int,
vet_id int,
date_of_visit date,
foreign key (animal_id) references animals(id),
foreign key (vet_id) references vets(id)
);

-- Add column email to owners table
ALTER TABLE owners ADD COLUMN email VARCHAR(120);

-- create index visits_animals_id_index on visits(animal_id asc) for performance optimization
create index visits_animals_id_index on visits(animal_id asc);

-- create index visits_vet_id_index on visits(vet_id)
create index visits_vet_id_index on visits(vet_id);

-- create index owners_email_index on owners (email asc)
create index owners_email_index on owners (email asc);