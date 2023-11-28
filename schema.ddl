drop schema if exists recordingcompany CASCADE;
create schema recordingcompany;
set search_path to recordingcompany;

CREATE DOMAIN positiveFloat AS real
    DEFAULT NULL
    CHECK (VALUE > 0.0);

CREATE SEQUENCE person_id_seq
    AS bigint
    INCREMENT BY 1
    MINVALUE 1;

create table person (
    person_id bigint primary key default nextval('person_id_seq'),
    name varchar(25) not null,
    email varchar(50) not null,
    phone varchar(25) not null
);

CREATE SEQUENCE studio_id_seq
    AS bigint
    INCREMENT BY 1
    MINVALUE 1;

create table studio (
    studio_id bigint primary key default nextval('studio_id_seq'),
    name varchar(25) not null,
    address varchar(10) not null
);

CREATE SEQUENCE session_id_seq
    AS bigint
    INCREMENT BY 1
    MINVALUE 1;

create table session (
    session_id bigint primary key default nextval('session_id_seq'),
    start_dt timestamp not null,
    end_dt timestamp not null,
    fee positiveFloat not null,
    studio_id integer REFERENCES studio on delete CASCADE,
    check (start_dt < end_dt),
    unique (start_dt, studio_id)
);

create table sessionengineer (
    session_id integer references session on delete cascade,
    engineer_id integer references person on delete cascade,
    primary key (session_id, engineer_id)
);

CREATE SEQUENCE band_id_seq
    AS bigint
    INCREMENT BY 1
    MINVALUE 1;

create table band (
    band_id bigint primary key default nextval('band_id_seq'),
    name varchar(25) not null
);

create table membership (
    band_id integer references band on delete cascade,
    player_id integer references person on delete CASCADE,
    primary key (band_id, player_id)
);

create table certification (
    engineer_id integer references person on delete cascade,
    certificate varchar(100) not NULL,
    organization varchar(50) not null,
    primary key (engineer_id, certificate, organization)
);

create table management (
    start_dt timestamp not null,
    end_dt timestamp not null,
    studio_id integer references studio on delete cascade,
    manager_id integer references person on delete cascade,
    check (start_dt < end_dt),
    primary key (start_dt, end_dt, studio_id)
);

CREATE SEQUENCE segment_id_seq
    AS bigint
    INCREMENT BY 1
    MINVALUE 1;

create table segment (
    segment_id bigint primary key default nextval('segment_id_seq'),
    integer_seconds integer not null,
    format varchar(25) not null,
    session_id integer references session on delete cascade
);

CREATE SEQUENCE track_id_seq
    AS bigint
    INCREMENT BY 1
    MINVALUE 1;

create table track (
    track_id bigint primary key default nextval('track_id_seq'),
    name varchar(50) not null
);

create table tracksegment (
    segment_id integer references segment on delete cascade,
    track_id integer references track on delete cascade,
    primary key (segment_id, track_id)
);

CREATE SEQUENCE album_id_seq
    AS bigint
    INCREMENT BY 1
    MINVALUE 1;

create table album (
    alubm_id bigint primary key default nextval('album_id_seq'),
    release_date timestamp not null
);

create table trackalbum (
    track_id integer references track on delete cascade,
    album_id integer references album on delete cascade,
    primary key (track_id, album_id)
);

create table sessionplayer (
    session_id integer references session on delete cascade,
    player_id integer references person on delete cascade,
    primary key (session_id , player_id)
);

create table sessionband (
    session_id integer references session on delete cascade,
    band_id integer references band on delete cascade,
    primary key (session_id , band_id)
);
