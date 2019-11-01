set term pdf
set title '20191027 140419'
set xdata time
set timefmt '%Y-%m-%dT%H:%M:%SZ'
set format x "%H:%M"
set xtics rotate
set xlabel "Time"

set ylabel "Heartrate"
set y2tics
set y2label "Elevation"

set output "20191027_140419.pdf"
set datafile separator ","
set grid
plot "20191027_140419.csv" using 1:5 smooth csplines title "Heartrate" axes x1y1\
    ,"20191027_140419.csv" using 1:4 smooth csplines title "Elevation" axes x1y2
