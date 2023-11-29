
set search_path to RecordingCompany;

insert into Studio(name, address) values
    ('Pawnee Recording Studio', '123 Valley Spring Lane, Pawnee, Indiana'),
    ('Pawnee Sound', '353 Western Ave, Pawnee, Indiana'),
    ('Eagleton Recording Studio', '829 Division, Eagleton, Indiana');

insert into Person(person_id, name, email, phone) values
    (1233, 'Donna Meagle', 'dmeagle@gmail.com', '000-000-1233'),
    (1234, 'Tom Haverford', 'thaverford@gmail.com', '000-000-1234'),
    (1231, 'April Ludgate', 'aludgate@gmail.com', '000-000-1231'),
    (1232, 'Leslie Knope', 'lknope@gmail.com', '000-000-1232'),
    (5678, 'Ben Wyatt', 'bwyatt@gmail.com', '000-000-5678'),
    (9942, 'Ann Perkins', 'aperkins@gmail.com', '000-000-9942'),
    (6521, 'Chris Traeger', 'ctraeger@gmail.com', '000-000-6521'),
    (6754, 'Andy Dwyer', 'adwyer@gmail.com', '000-000-6754'),
    (4523, 'Andrew Burlinson', 'aburlinson@gmail.com', '000-000-4523'),
    (2224, 'Michael Chang', 'mchang@gmail.com', '000-000-2224'),
    (7832, 'James Pierson', 'jpierson@gmail.com', '000-000-7832'),
    (1000, 'Duke Silver', 'dsilver@gmail.com', '000-000-1000');

insert into Session(start_dt, end_dt, fee, studio_id) values
    ('2023-01-08 10:00', '2023-01-08 15:00', 1500, 1),
    ('2023-01-10 13:00', '2023-01-11 14:00', 1500, 1),
    ('2023-01-12 18:00', '2023-01-13 20:00', 1500, 1),
    ('2023-03-10 11:00', '2023-03-10 23:00', 2000, 1),
    ('2023-03-11 13:00', '2023-03-12 15:00', 2000, 1),
    ('2023-03-13 10:00', '2023-03-13 20:00', 1000, 1),
    ('2023-09-25 11:00', '2023-09-26 23:00', 1000, 3),
    ('2023-09-29 11:00', '2023-09-30 23:00', 1000, 3);

insert into SessionEngineer(session_id, engineer_id) values
    (1, 5678),
    (2, 5678),
    (3, 5678),
    (1, 9942),
    (2, 9942),
    (3, 9942),
    (4, 5678),
    (5, 5678),
    (6, 6521),
    (7, 5678),
    (8, 5678);

insert into Band(name) values
    ('Mouse Rat');

insert into BandMembership(band_id, player_id) values
    (1, 6754),
    (1, 4523),
    (1, 2224),
    (1, 7832);

insert into Certification(engineer_id, certificate) values
    (5678, 'ABCDEFGH-123I'),
    (5678, 'JKLMNOPQ-456R'),
    (9942, 'SOUND-123-AUDIO');