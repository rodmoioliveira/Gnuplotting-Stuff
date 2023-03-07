#!/bin/bash

declare TRACE
[[ "${TRACE}" == 1 ]] && set -o xtrace
set -o errexit
set -o nounset
set -o pipefail
set -o noclobber

OUTPUT_FILE="data/plot/proc.png"

plot() {
  gnuplot <<EOF
set terminal pngcairo enhanced size 1700,600 font "Merriweather,16"

set title "Processes" font "Merriweather-Bold,24"
set datafile separator ','

set xdata time
set timefmt "%d/%m-%H:%M:%S"
set format x "%H:%M:%S"

set tics out font ",12"
set xtics rotate by 45 right
set grid xtics ytics

set bmargin 7
set key bottom center outside autotitle columnhead font ",14" horizontal
set ylabel "Processes" offset 1,0 font "Merriweather-Bold,14"
set xlabel "Time" offset 0,1 font "Merriweather-Bold,14"

set style line  1 linecolor rgb '#de2d26' linetype 1 linewidth 1.5 pointtype 1 pointsize 1
set style line  2 linecolor rgb '#1f78b4' linetype 1 linewidth 1.5 pointtype 1 pointsize 1
set style line  3 linecolor rgb '#31a354' linetype 1 linewidth 1.5 pointtype 1 pointsize 1

set border back
set output "${OUTPUT_FILE}"

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


