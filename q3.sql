set search_path to recordingcompany;
drop table if exists q3;

create table q3 (
    session_id bigint not null,
    player_id bigint not null,
    player_name varchar(25) not null
);

drop view if exists total_segment_duration cascade;
drop view if exists players_with_sessions cascade;


-- Sum the number of seconds for each session
create view total_segment_duration as
select session_id, sum(duration_seconds) as total_duration
from segment group by session_id;


-- Find the session that produced the greatest total number
-- of seconds of recording segments
create view longest_segment_session as
select session_id from total_segment_duration
where total_duration =
(select max(total_duration) from total_segment_duration);

-- Expand SessionBand to band members on each session
-- and concatenate to individual players
create view players_with_sessions as
select * from
((select session_id, player_id from sessionplayer)
union
(select session_id, player_id
from sessionband natural join bandmembership));


-- Final answer
-- First we find players who played in that session,
-- concatenate that with band players who played in that session,
-- then join the person table to find the names of the players
-- (we used "session_id in" for the case that
-- there might be multiple sessions with
-- the longest total segment length)
insert into q3
select session_id, player_id, name as player_name
from players_with_sessions
join person on player_id = person_id
where session_id in
(select * from longest_segment_session);