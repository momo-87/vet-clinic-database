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


