drop schema if exists RecordingCompany cascade;
create schema RecordingCompany;
set search_path to RecordingCompany;

create domain positiveFloat as real
    default null
    check (value >= 0.0);

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
    fee positiveFloat not null,
    studio_id integer references Studio on delete cascade,
    check (start_dt < end_dt),
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
