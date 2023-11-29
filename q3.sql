set search_path to recordingcompany;
drop table if exists q3;

create table q3 (
    player_id bigint not null,
    name varchar(25) not null
);

drop view if exists total_segment_duration cascade;


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


-- Final answer
-- First we find players who played in that session,
-- concatenate that with band players who played in that session,
-- then join the person table to find the names of the players
-- (we used "session_id in" for the case that
-- there might be multiple sessions with
-- the longest total segment length)
insert into q3
select player_id, name from
((select player_id from sessionplayer
where session_id in (select * from longest_segment_session))
union
(select player_id from sessionband
natural join bandmembership
where session_id in (select * from longest_segment_session))) s
join person on player_id = person_id;