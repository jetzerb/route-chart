# Route-Chart

Analytics on GPX &amp; TCX route data you get from your sports tracker.

I use [Endomondo](https://www.endomondo.com) to track my workouts. It has a nice
UI that allows you to zoom in on specific parts of the route and see information
about the data points (time, speed, distance, etc) as well as showing you a
moving cursor on a map to show your position.

However, it seems to only allow you to mouse over a subset of points rather than
every point that was logged.

This project is mostly a learning experience for me to
- get familiar with GPX and TCX (at least the attributes populated by Endomondo)
- save GPX/TCX data in tabular format and use it to
  - compute the distance between two lat/lon points, leveraging
    [PostGIS](https://postgis.net)'s `ST_Distance` functions which implement
    both the [Haversine](https://en.wikipedia.org/wiki/Haversine_formula)
    and [Vincenty](https://en.wikipedia.org/wiki/Vincenty%27s_formulae) formulas
  - compute linear speed along the route
  - investigate whether it's worth it to try and take elevation gain into
    account when computing distances, given the variability in the logged
    numbers on a device by device basis
- produce some static charts using gnuplot
- produce some interactive charts using D3 or other JS toolkit

To avoid having to install a bunch of software locally, I'll use Docker
Compose to start up whatever containers I need:
- jetzerb/nix-nice
- mdillon/postgis
