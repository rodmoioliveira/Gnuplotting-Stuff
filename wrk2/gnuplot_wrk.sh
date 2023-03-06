#!/bin/bash

declare TRACE
[[ "${TRACE}" == 1 ]] && set -o xtrace
set -o errexit
set -o nounset
set -o pipefail
set -o noclobber

OUTPUT_FILE="data/plot/wrk.png"

plot() {
  local -a wrk_files
  local counter=1
  local plot_directives="plot "

  while IFS= read -r q; do wrk_files+=("${q}"); done < <(ls -1v data/csv)
  for wrk in "${wrk_files[@]}"; do
    plot_directives+=$(printf '"%s" using 1:2 with lines linestyle %d, ' "data/csv/${wrk}" "${counter}")
    counter=$((counter + 1))
  done

  gnuplot <<EOF
set terminal pngcairo size 1700,700 font "Roboto,16"

set title "Latency Distribution" font "{:Bold},24"
set datafile separator ','

set tics out font ",12"
set xtics rotate
set grid xtics ytics

set key bottom center outside autotitle columnhead font ",14" horizontal
set ylabel "Milliseconds" offset 1,0 font "{:Bold},14"
set xlabel "Percentile" offset 0,3 font "{:Bold},14"

set style line  1 linecolor rgb '#a6cee3' linetype 1 linewidth 1.5 pointtype 1 pointsize 1
set style line  2 linecolor rgb '#1f78b4' linetype 1 linewidth 1.5 pointtype 1 pointsize 1
set style line  3 linecolor rgb '#b2df8a' linetype 1 linewidth 1.5 pointtype 1 pointsize 1
set style line  4 linecolor rgb '#33a02c' linetype 1 linewidth 1.5 pointtype 1 pointsize 1
set style line  5 linecolor rgb '#fb9a99' linetype 1 linewidth 1.5 pointtype 1 pointsize 1
set style line  6 linecolor rgb '#e31a1c' linetype 1 linewidth 1.5 pointtype 1 pointsize 1
set style line  7 linecolor rgb '#fdbf6f' linetype 1 linewidth 1.5 pointtype 1 pointsize 1
set style line  8 linecolor rgb '#ff7f00' linetype 1 linewidth 1.5 pointtype 1 pointsize 1
set style line  9 linecolor rgb '#cab2d6' linetype 1 linewidth 1.5 pointtype 1 pointsize 1
set style line 10 linecolor rgb '#6a3d9a' linetype 1 linewidth 1.5 pointtype 1 pointsize 1
set style line 11 linecolor rgb '#ffff99' linetype 1 linewidth 1.5 pointtype 1 pointsize 1
set style line 12 linecolor rgb '#b15928' linetype 1 linewidth 1.5 pointtype 1 pointsize 1

set logscale x
set xtics (0.99,0.999,0.9999,1)
set xrange [0.99:1]

set border back
set output "${OUTPUT_FILE}"

$(echo "${plot_directives}" | sd ", $" '')
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
