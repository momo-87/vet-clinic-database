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

-- Inside a transaction set the species column to unspecified  then roll back
begin;
update animals
set species = 'unspecified'; -- make changes
SELECT species from animals; -- verify that change was made 
rollback; -- undo change
SELECT species from animals; -- verify that change was undone
COMMIT; -- end transaction

-- NEW TRANSACTION
begin;
-- Update the animals table by setting the species column to 'digimon' for all animals that have a name ending in 'mon'
update animals
set species = 'digimon' where name like '%mon';
-- Update the animals table by setting the species column to 'pokemon' for all animals that don't have species already set.
update animals
set species = 'pokemon' where species is null;
SELECT species FROM animals; -- Verify that change was made
commit; -- Commit the trabsaction
SELECT species FROM animals; -- Verify that change persists after commit

-- NEW TRANSACTION
begin;
delete from animals; -- delete all records in the animals
SELECT COUNT(*) FROM animals; -- Verify that change was made
rollback; -- roll back the transaction
SELECT COUNT(*) FROM animals; -- Verify that change was made

-- NEW TRANSACTION
begin;
delete from animals where date_of_birth > '2022-01-01'; -- Delete all animals born after Jan 1st, 2022
savepoint sp1; -- Create a savepoint for the transaction.
-- Update all animals' weight to be their weight multiplied by -1.
update animals
set weight_kg = -1 * weight_kg;
rollback to sp1; -- Rollback to the savepoint
-- Update all animals' weights that are negative to be their weight multiplied by -1.
update animals
set weight_kg = -1 * weight_kg where weight_kg < 0;
commit; -- Commit transaction

-- WRITE QUERIES TO ANSWER THE FOLLOWING QUESTIONS:
select count(id) from animals; -- How many animals are there?
select count(escape_attempts) from animals where escape_attempts = 0; -- How many animals have never tried to escape?
select avg(weight_kg) from animals; -- What is the average weight of animals?
-- Who escapes the most, neutered or not neutered animals?
select neutered, max(escape_attempts) from animals
group by neutered;
-- What is the minimum and maximum weight of each type of animal?
select species, min(weight_kg), max(weight_kg) from animals
group by species;
-- What is the average number of escape attempts per animal type of those born between 1990 and 2000?
select species, avg(escape_attempts) from animals where date_of_birth between '1990-01-01' and '2000-12-31'
group by species;

-- WRITE QUERIES TO ANSWER THE FOLLOWING QUESTIONS:
-- What animals belong to Melody Pond?
select name
from animals
join owners
on owner_id = owners.id
where owners.id = 4;


