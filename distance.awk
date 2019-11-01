#!/usr/bin/awk -f

# convert degrees to radians
function deg2rad(deg) {
	return deg * 3.1415926536 / 180;
}

# Haversine formula for great circle distance,
# implemented here for our earth
function earthDistanceMetersHaversine(lat1, lon1, lat2, lon2) {
	r = 6371 * 1000; # earth radius in meters
	dLat = deg2rad(lat2 - lat1);
	dLon = deg2rad(lon2 - lon1);
	a = sin(dLat/2)^2 + cos(deg2rad(lat1)) * cos(deg2rad(lat2)) * sin(dLon/2)^2;
	c = 2*atan2(sqrt(a), sqrt(1-a));
	return r*c;
}

# process all lines, assuming that each one is lat1,lon1,lat2,lon2 format
{
	print $0, " => ", earthDistanceMetersHaversine($1,$2,$3,$4);
}
