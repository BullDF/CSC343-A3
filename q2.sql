set search_path to recordingcompany;

drop view if exists count_players_sessions;

-- Count the number of sessions the players have played in
create view count_players_sessions as
select player_id, count(distinct session_id) as num_sessions from
((select * from sessionplayer)
union
(select session_id, player_id from sessionband
natural join bandmembership)) s
group by player_id;

-- Final answer
select person_id, coalesce(num_sessions, 0) as num_sessions
from person left join count_players_sessions
on person_id = player_id;