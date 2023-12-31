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

-- List of all animals that are pokemon (their type is Pokemon).
select animals.name
from animals
join species
on species_id = species.id
where species.id = 1;

-- List all owners and their animals, remember to include those that don't own any animal.
select full_name, name
from owners
left join animals
on owners.id = owner_id;

-- How many animals are there per species?
select count(animals.id), species.name
from animals
join species
on species_id = species.id
group by species.name;

-- List all Digimon owned by Jennifer Orwell.
select animals.name
from species
join animals
on species.id = species_id
join owners
on owner_id = owners.id
where owners.id = 2 and species.name = 'Digimon';

-- List all animals owned by Dean Winchester that haven't tried to escape.
select name
from animals
join owners
on owner_id = owners.id
where full_name = 'Dean Winchester' and escape_attempts = 0;

-- Who owns the most animals?
select full_name
from owners
join animals
on owners.id = owner_id
group by full_name
order by count(*) desc limit 1;

-- WRITE A QUERIES TO ANSWER THE FOLLOWING:
-- Who was the last animal seen by William Tatcher?
select animals.name
from animals
join visits
on animals.id = animal_id
join vets
on vet_id = vets.id
where vets.name = 'William Tatcher'
order by date_of_visit desc limit 1;

-- How many different animals did Stephanie Mendez see?
select count(distinct animals.name) as animals_seen_by_Stephanie_Mendez
from animals
join visits
on animals.id = animal_id
join vets
on vet_id = vets.id
where vets.name = 'Stephanie Mendez';

-- List all vets and their specialties, including vets with no specialties.
select vets.name as vets, species.name as specialties
from vets
left join specializations
on vets.id = vet_id
left join species
on species_id = species.id;

-- List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020.
select animals.name
from animals
join visits
on animals.id = animal_id
join vets
on vet_id = vets.id
where vets.name = 'Stephanie Mendez' and date_of_visit between '2020-04-01' and '2020-08-30';

-- What animal has the most visits to vets?
select animals.name
from animals
join visits
on animals.id = animal_id
join vets
on vet_id = vets.id
group by animals.name
order by count(animals.name) desc limit 1;

-- Who was Maisy Smith's first visit?
select animals.name
from animals
join visits
on animals.id = animal_id
join vets
on vet_id = vets.id
where vets.name = 'Maisy Smith'
group by animals.name
order by min(date_of_visit) asc limit 1;

-- Details for most recent visit: animal information, vet information, and date of visit.
Select animals.*, vets.name, age, date_of_graduation, date_of_visit
from animals
join visits on animals.id = animal_id
join vets on vet_id = vets.id
where date_of_visit = (
  select MAX(date_of_visit)
  from visits
);

-- How many visits were with a vet that did not specialize in that animal's species?
select count (animals.name)
from animals
join species
on animals.species_id = species.id
join visits
on animals.id = animal_id
join vets
on visits.vet_id = vets.id
join specializations
on vets.id = specializations.vet_id
where specializations.species_id != animals.species_id
and vets.name != 'Stephanie Mendez';

-- What specialty should Maisy Smith consider getting? Look for the species she gets the most
select species.name
from species
join animals
on species.id = animals.species_id
join visits
on animals.id = animal_id
join vets
on vet_id = vets.id
where vets.name = 'Maisy Smith'
group by species.name
order by count(*) desc limit 1;

-- Queries for performance investigation
EXPLAIN ANALYZE SELECT COUNT(*) FROM visits where animal_id = 4;
EXPLAIN ANALYZE SELECT * FROM visits where vet_id = 2
EXPLAIN ANALYZE SELECT * FROM owners where email = 'owner_18327@mail.com';