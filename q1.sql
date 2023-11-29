set search_path to recordingcompany;

drop view if exists current_managers cascade;
drop view if exists albums_with_studios cascade;


-- Find the ids of the current managers
create view current_managers as
select studio_id, manager_id from management
where end_dt is null;

-- Find the names of the current managers
create view current_managers_with_names as
select studio_id, name as current_manager
from current_managers join person on manager_id = person_id;

-- Find albums that studios contributed to
create view albums_with_studios as
select album_id, studio_id
from trackalbum natural join tracksegment
natural join segment
natural join session;

-- Count number of albums studios contributed to
create view num_albums_contributed as
select studio_id, count(distinct album_id) as num_albums
from albums_with_studios
group by studio_id;

-- Final answer
select studio_id, current_manager, coalesce(num_albums, 0) as num_albums
from current_managers_with_names
natural left join num_albums_contributed;