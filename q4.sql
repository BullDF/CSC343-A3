set search_path to recordingcompany;

drop view if exists albums_with_sessions cascade;
drop view if exists players_with_sessions cascade;

-- Match albums with sessions
create view albums_with_sessions as
select album_id, session_id
from trackalbum natural join tracksegment
natural join segment;

-- Count number of sessions for each album
create view count_sessions as
select album_id, count(distinct session_id) as num_sessions
from albums_with_sessions
group by album_id;

-- Find the album that required
-- the greatest number of recording sessions
create view album_with_most_sessions as
select album_id, num_sessions
from count_sessions
where (num_sessions =
(select max(num_sessions) from count_sessions));


-- Find sessions that the album required
-- (the "album_id in" is for the case that
-- there might be multiple albums
-- requiring the most number of sessions)
create view required_sessions as
select album_id, session_id from albums_with_sessions
where album_id in
(select album_id from album_with_most_sessions);


-- Expand SessionBand to band members on each session
-- and concatenate to individual players
create view players_with_sessions as
select * from
((select session_id, player_id from sessionplayer)
union
(select session_id, player_id
from sessionband natural join bandmembership)) s;

-- Find players who have played on the target album
create view album_with_players as
select album_id, player_id
from required_sessions natural join players_with_sessions;

-- Count number of players who have played on the target album
create view count_players as
select album_id, count(distinct player_id) as num_players
from album_with_players
group by album_id;

-- Final answer
select album_id, name as album_name, num_sessions, num_players
from album_with_most_sessions
natural join album
natural join count_players;
