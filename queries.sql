-- Find all animals whose name ends in "mon".
select * from animals where name like '%mon';

-- List the name of all animals born between 2016 and 2019.
select name from animals where date_of_birth between '2016-01-01' and '2019-12-31';

-- List the name of all animals that are neutered and have less than 3 escape attempts.
select name from animals where neutered and escape_attempts < 3;

-- List the date of birth of all animals named either "Agumon" or "Pikachu".
select date_of_birth from animals where name in ('Agumon', 'Pikachu');

-- List name and escape attempts of animals that weigh more than 10.5kg
select name, escape_attempts from animals where weight_kg > 10.5;

-- Find all animals that are neutered.
select * from animals where neutered;

-- Find all animals not named Gabumon.
select * from animals where name != 'Gabumon';

-- Find all animals with a weight between 10.4kg and 17.3kg (including the animals with the weights that equals precisely 10.4kg or 17.3kg)
select * from animals where weight_kg between 10.4 and 17.3;

-- Set the species column to unspecified inside a transaction then roll back
begin;
update animals
set species = 'unspecified' where species is null;
rollback;

-- start a transaction 1
begin;
-- Update the animals table by setting the species column to 'digimon' for all animals that have a name ending in 'mon'
update animals
set species = 'digimon' where name like '%mon';

-- Update the animals table by setting the species column to 'pokemon' for all animals that don't have species already set.
update animals
set species = 'pokemon' where species is null;
-- Commit the trabsaction
commit;

-- start a transaction 2
begin;
-- delete all records in the animals
delete from animals;
-- roll back the transaction
rollback;

-- start a transaction 3
begin;
-- Delete all animals born after Jan 1st, 2022
delete from animals where date_of_birth > '2022-01-01';
-- Create a savepoint for the transaction.
savepoint sp1;
-- Update all animals' weight to be their weight multiplied by -1.
update animals
set weight_kg = -1 * weight_kg;
-- Rollback to the savepoint
rollback to sp1;