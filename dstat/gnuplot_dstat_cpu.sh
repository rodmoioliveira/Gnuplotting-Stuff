#!/bin/bash

declare TRACE
[[ "${TRACE}" == 1 ]] && set -o xtrace
set -o errexit
set -o nounset
set -o pipefail
set -o noclobber

OUTPUT_FILE="data/plot/multiplot.png"

plot() {
  gnuplot <<EOF
set terminal pngcairo enhanced size 1400,1800 font "Merriweather,16"
set output "${OUTPUT_FILE}"

set lmargin at screen 0.08
# set rmargin at screen 0.98

set key right top inside autotitle columnhead font ",10" vertical
set multiplot layout 5, 1 title "dstat" font "Merriweather-Bold,24"
set datafile separator ','

set xdata time
set timefmt "%d/%m-%H:%M:%S"
set format x "%H:%M:%S"

set tics out font ",12"
set grid back xtics ytics

set style line  1 linecolor rgb '#de2d26' linetype 1 linewidth 1.5 pointtype 1 pointsize 1
set style line  2 linecolor rgb '#1f78b4' linetype 1 linewidth 1.5 pointtype 1 pointsize 1
set style line  3 linecolor rgb '#31a354' linetype 1 linewidth 1.5 pointtype 1 pointsize 1
set style line  4 linecolor rgb '#c51b8a' linetype 1 linewidth 1.5 pointtype 1 pointsize 1
set style line  5 linecolor rgb '#756bb1' linetype 1 linewidth 1.5 pointtype 1 pointsize 1

set border back

set title "CPU (% Utilization)" font "Merriweather-Bold,18"
plot "data/csv/data.csv" using 1:2 with lines linestyle 1, \
       '' using 1:3 with lines linestyle 2, \
       '' using 1:4 with lines linestyle 3, \
       '' using 1:5 with lines linestyle 4, \
       '' using 1:6 with lines linestyle 5

set title "Memory (Bytes)" font "Merriweather-Bold,18"
plot "data/csv/data.csv" using 1:14 with lines linestyle 1, \
       '' using 1:15 with lines linestyle 2, \
       '' using 1:16 with lines linestyle 3, \
       '' using 1:17 with lines linestyle 4

set title "Network (Bytes)" font "Merriweather-Bold,18"
plot "data/csv/data.csv" using 1:18 with lines linestyle 1, \
       '' using 1:19 with lines linestyle 2

set title "IO Requests" font "Merriweather-Bold,18"
plot "data/csv/data.csv" using 1:23 with lines linestyle 1, \
       '' using 1:24 with lines linestyle 2

set title "Processes" font "Merriweather-Bold,18"
plot "data/csv/data.csv" using 1:20 with lines linestyle 1, \
       '' using 1:21 with lines linestyle 2, \
       '' using 1:22 with lines linestyle 3
exit
EOF
}

open_plot() {
  xdg-open "${OUTPUT_FILE}"
}

main() {
  plot
  open_plot
}

main
