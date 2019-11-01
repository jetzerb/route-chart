with src as (
	select st_geomfromtext('POINT(-88.9997020 37.1501430)',4326) pt1
	      ,st_geomfromtext('POINT(-88.9366422 37.0422041)',4326) pt2)
select ST_DistanceSpheroid(pt1, pt2, 'SPHEROID["WGS 84",6378137,298.257223563]') Dist_Spheroid
      ,ST_Distance(pt1::geography, pt2::geography) Dist_Great_Circle
from src;

/*
dist_sphere       |dist_great_circle|
------------------|-----------------|
13225.861748224565|   13225.86174822|
*/
