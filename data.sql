
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

insert into Management(start_dt, end_dt, studio_id, manager_id) values
    ('2018-12-02', null, 1, 1233),
    ('2017-01-13', '2018-12-01', 1, 1234),
    ('2008-03-21', '2017-01-12', 1, 1231),
    ('2011-05-07', null, 2, 1233),
    ('2020-09-05', null, 3, 1232),
    ('2016-09-05', '2020-09-04', 3, 1234),
    ('2010-09-05', '2016-09-04', 3, 1232);

do $$
begin
    -- Session 1
    for i in 1..10 loop
        insert into Segment(duration_seconds, format, session_id) values (60, 'WAV', 1);
    end loop;

    -- Session 2
    for i in 1..5 loop
        insert into Segment(duration_seconds, format, session_id) values (60, 'WAV', 2);
    end loop;

    -- Session 3
    for i in 1..4 loop
        insert into Segment(duration_seconds, format, session_id) values (60, 'WAV', 3);
    end loop;

    -- Session 4
    for i in 1..2 loop
        insert into Segment(duration_seconds, format, session_id) values (120, 'WAV', 4);
    end loop;

    -- Session 6
    for i in 1..5 loop
        insert into Segment(duration_seconds, format, session_id) values (60, 'WAV', 6);
    end loop;

    -- Session 7
    for i in 1..9 loop
        insert into Segment(duration_seconds, format, session_id) values (180, 'AIFF', 7);
    end loop;

    -- Session 8
    for i in 1..6 loop
        insert into Segment(duration_seconds, format, session_id) values (180, 'WAV', 8);
    end loop;
end;
$$;

insert into Track(name) values
    ('5,000 Candles in the Wind'),
    ('Catch Your Dream'),
    ('May Song'),
    ('The Pit'),
    ('Remember'),
    ('The Way You Look Tonight'),
    ('Another Song');

do $$
begin
    -- Session 2
    for i in 11..15 loop
        insert into TrackSegment(segment_id, track_id) values (i, 1);
    end loop;

    -- Session 3
    for i in 16..19 loop
        insert into TrackSegment(segment_id, track_id) values (i, 2);
    end loop;

    -- Session 4
    for i in 20..21 loop
        insert into TrackSegment(segment_id, track_id) values (i, 2);
    end loop;

    -- Session 6
    for i in 22..26 loop
        insert into TrackSegment(segment_id, track_id) values (i, 1);
        insert into TrackSegment(segment_id, track_id) values (i, 2);
    end loop;

    -- Session 7
    for i in 32..33 loop
        insert into TrackSegment(segment_id, track_id) values (i, 3);
    end loop;

    -- Session 7
    for i in 34..35 loop
        insert into TrackSegment(segment_id, track_id) values (i, 4);
    end loop;

    -- Session 8
    for i in 36..37 loop
        insert into TrackSegment(segment_id, track_id) values (i, 5);
    end loop;

    -- Session 8
    for i in 38..39 loop
        insert into TrackSegment(segment_id, track_id) values (i, 6);
    end loop;

    -- Session 8
    for i in 40..41 loop
        insert into TrackSegment(segment_id, track_id) values (i, 7);
    end loop;
end;
$$;

insert into Album(name, release_date) values
    ('The Awesome Album', '2023-05-25'),
    ('Another Awesome Album', '2023-10-29');

insert into TrackAlbum(track_id, album_id) values
    (1, 1),
    (2, 1),
    (3, 2),
    (4, 2),
    (5, 2),
    (6, 2),
    (7, 2);

insert into SessionPlayer(session_id, player_id) values
    (1, 1000),
    (2, 1000),
    (3, 1000),
    (6, 6754),
    (6, 1234),
    (7, 6754),
    (8, 6754);

insert into SessionBand(session_id, band_id) values
    (1, 1),
    (2, 1),
    (3, 1),
    (4, 1),
    (5, 1);