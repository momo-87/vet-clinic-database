-- Insert data into animals table
insert into animals (name, date_of_birth, escape_attempts, neutered, weight_kg) values ('Agumon', '2020-02-03', 0, true, 10.23);
insert into animals (name, date_of_birth, escape_attempts, neutered, weight_kg) values ('Gabumon', '2018-11-15', 2, true, 8);
insert into animals (name, date_of_birth, escape_attempts, neutered, weight_kg) values ('Pikachu', '2021-01-07', 1, false, 15.04);
insert into animals (name, date_of_birth, escape_attempts, neutered, weight_kg) values ('Devimon', '2017-05-12', 5, true, 11);

-- Insert new data into animals table
insert into animals (name, date_of_birth, escape_attempts, neutered, weight_kg)
    values 
        ('Charmander', '2020-02-08', 0, false, -11),
        ('Plantmon', '2021-11-15', 2, true, -5.7),
        ('Squirtle', '1993-04-02', 3, false, -12.13),
        ('Angemon', '2005-06-12', 1, true, -45),
        ('Boarmon', '2005-06-07', 7, true, 20.4),
        ('Blossom', '1998-10-13', 3, true, 17), 
        ('Ditto', '2022-05-14', 4, true, 22);

-- Insert data into owners table
insert into owners (full_name, age)
    values
        ('Sam Smith', 34),
        ('Jennifer Orwell', 19),
        ('Bob', 45),
        ('Melody Pond', 77),
        ('Dean Winchester', 14),
        ('Jodie Whittaker', 38);

-- Insert data into species table
insert into species (name) values ('Pokemon'), ('Digimon');

-- Set species_id = 2 for animals which name ends with 'mon'
update animals
set species_id = 2 where name like '%mon';

-- Set species_id = 1 for others animals
update animals
set species_id = 1 where species_id is null;

-- Modify your inserted animals to include owner information (owner_id):
-- Sam Smith owns Agumon
update animals
set owner_id = 1 where name  = 'Agumon';
-- Jennifer Orwell owns Gabumon and Pikachu
update animals
set owner_id = 2 where name in ('Gabumon', 'Pikachu');
-- Bob owns Devimon and Plantmon.
update animals
set owner_id = 3 where name in ('Devimon', 'Plantmon');
-- Melody Pond owns Charmander, Squirtle, and Blossom.
update animals
set owner_id = 4 where name in ('Charmander', 'Squirtle', 'Blossom');
-- Dean Winchester owns Angemon and Boarmon.
update animals
set owner_id = 5 where name in ('Angemon', 'Boarmon');

-- Insert data into vets table
insert into vets (name, age, date_of_graduation)
values
    ('William Tatcher', 45, '2000-04-23'),
    ('Maisy Smith', 26, '2019-01-17'),
    ('Stephanie Mendez', 64, '1981-05-04'),
    ('Jack Harkness', 38, '2008-06-08');

-- Insert data into specializations table
insert into specializations (species_id, vet_id)
values
    (1, 1), -- Vet William Tatcher is specialized in Pokemon
    -- Vet Stephanie Mendez is specialized in Digimon and Pokemon.
    (2, 3),
    (1, 3),
    (2, 4); -- Vet Jack Harkness is specialized in Digimon.

-- Insert data into visits table
insert into visits (animal_id, vet_id, date_of_visit)
values
    (1, 1, '2020-05-24'),
    (1, 3, '2020-07-22'),
    (2, 4, '2021-02-02'),
    (3, 2, '2020-01-05'),
    (3, 2, '2020-03-08'),
    (3, 2, '2020-05-14'),
    (4, 3, '2021-05-04'),
    (5, 4, '2021-02-24'),
    (6, 2, '2019-12-21'),
    (6, 1, '2020-08-10'),
    (6, 2, '2021-04-07'),
    (7, 3, '2019-09-29'),
    (8, 4, '2020-10-03'),
    (8, 4, '2020-11-04'),
    (9, 2, '2019-01-24'),
    (9, 2, '2019-05-15'),
    (9, 2, '2020-02-27'),
    (9, 2, '2020-08-03'),
    (10, 3, '2020-05-24'),
    (10, 1, '2021-01-11');


-- This will add 3.594.280 visits considering you have 10 animals, 4 vets, and it will use around ~87.000 timestamps (~4min approx.)
INSERT INTO visits (animal_id, vet_id, date_of_visit) SELECT * FROM (SELECT id FROM animals) animal_ids, (SELECT id FROM vets) vets_ids, generate_series('1980-01-01'::timestamp, '2021-01-01', '4 hours') visit_timestamp;

-- This will add 2.500.000 owners with full_name = 'Owner <X>' and email = 'owner_<X>@email.com' (~2min approx.)
insert into owners (full_name, email) select 'Owner ' || generate_series(1,2500000), 'owner_' || generate_series(1,2500000) || '@mail.com';