-- COULD NOT
-- There are not gaps in management, a manager is in their role until the day when the next 
-- manager begins. This is a constraint that could not be enforced.

-- DID NOT
-- There is at least 1 recording engineer and at most 3 in each session. This constraint
-- can be enforced without triggers or assertions. We could have done it by storing the 
-- relations and the instances in one table. But we did not do this because we prioritize 
-- eliminating redundancy and NULL values--for example, we could have atrributes engineer1, 
-- engineer2, engineer3 for each session, but this can result in NULL values in two of them. 
-- Therefore we created the relations/membership tables as separate tables, thus we cannot 
-- check for any constraint relating to amounts or cardinalities. 
-- Other constraints we did not enforce for the same reason are:
-- Albums contains at least two tracks
-- A band has at least one person in it
-- A track appears in at least one album

-- EXTRA CONSTRAINTS
-- We didn't make any extra constraints.

-- ASSUMPTIONS:
-- 1. We assumed that fee can be 0 for a session. It is possible that
-- a band is a friend of the manager and the manager decides to give them
-- a free session.

-- 2. We assumed that a person can be of multiple roles.
-- For example, a sound engineer can be a manager, a band member,
-- an individual player of a session, etc.
-- Hence we didn't specify the type of people in the Person table.

-- Besides this, we didn't make any other assumptions other than the one specified.

drop schema if exists RecordingCompany cascade;
create schema RecordingCompany;
set search_path to RecordingCompany;

create sequence person_id_seq
    as bigint
    increment by 1
    minvalue 1;

create table Person (
    person_id bigint primary key default nextval('person_id_seq'),
    name varchar(25) not null,
    email varchar(50) not null,
    phone varchar(25) not null
);

create sequence studio_id_seq
    as bigint
    increment by 1
    minvalue 1;

create table Studio (
    studio_id bigint primary key default nextval('studio_id_seq'),
    name varchar(25) not null,
    address varchar(100) not null
);

create sequence session_id_seq
    as bigint
    increment by 1
    minvalue 1;

create table Session (
    session_id bigint primary key default nextval('session_id_seq'),
    start_dt timestamp not null,
    end_dt timestamp not null,
    fee float not null,
    studio_id integer references Studio on delete cascade,
    check (start_dt < end_dt),
    check (fee >= 0),
    unique (start_dt, studio_id)
);

create table SessionEngineer (
    session_id integer references Session on delete cascade,
    engineer_id integer references Person on delete cascade,
    primary key (session_id, engineer_id)
);

create sequence band_id_seq
    as bigint
    increment by 1
    minvalue 1;

create table Band (
    band_id bigint primary key default nextval('band_id_seq'),
    name varchar(25) not null
);

create table BandMembership (
    band_id integer references Band on delete cascade,
    player_id integer references Person on delete cascade,
    primary key (band_id, player_id)
);

create table SessionPlayer (
    session_id integer references Session on delete cascade,
    player_id integer references Person on delete cascade,
    primary key (session_id, player_id)
);

create table SessionBand (
    session_id integer references Session on delete cascade,
    band_id integer references Band on delete cascade,
    primary key (session_id , band_id)
);

create table Certification (
    engineer_id integer references Person on delete cascade,
    certificate varchar(100) not null,
    primary key (engineer_id, certificate)
);

create table Management (
    start_dt timestamp not null,
    end_dt timestamp,
    studio_id integer references Studio on delete cascade,
    manager_id integer references Person on delete cascade,
    check (start_dt <= end_dt),
    primary key (start_dt, studio_id)
);

create sequence segment_id_seq
    as bigint
    increment by 1
    minvalue 1;

create table Segment (
    segment_id bigint primary key default nextval('segment_id_seq'),
    duration_seconds integer not null,
    format varchar(10) not null,
    session_id integer references Session on delete cascade
);

create sequence track_id_seq
    as bigint
    increment by 1
    minvalue 1;

create table Track (
    track_id bigint primary key default nextval('track_id_seq'),
    name varchar(50) not null
);

create table TrackSegment (
    segment_id integer references Segment on delete cascade,
    track_id integer references Track on delete cascade,
    primary key (segment_id, track_id)
);

create sequence album_id_seq
    as bigint
    increment by 1
    minvalue 1;

create table Album (
    album_id bigint primary key default nextval('album_id_seq'),
    name varchar(50) not null,
    release_date timestamp not null
);

create table TrackAlbum (
    track_id integer references Track on delete cascade,
    album_id integer references Album on delete cascade,
    primary key (track_id, album_id)
);
