#!/bin/bash

declare TRACE
[[ "${TRACE}" == 1 ]] && set -o xtrace
set -o errexit
set -o nounset
set -o pipefail
set -o noclobber

OUTPUT_FILE="data/plot/wrk.png"

clean_tempdir() {
  rm -rf "${tmp_dir}"
}

trap clean_tempdir EXIT

mktempdir() {
  if ! tmp_dir=$(mktemp -d -t gnuplot-wrk-XXXXXXXXXX); then
    printf 1>&2 "Couldn't create %s\n" "${tmp_dir}"
    exit 1
  fi

  echo "1.0,0.0,0" >"${tmp_dir}/xlabels.csv"
  echo "10.0,0.0,90%" >>"${tmp_dir}/xlabels.csv"
  echo "100.0,0.0,99%" >>"${tmp_dir}/xlabels.csv"
  echo "1000.0,0.0,99.9%" >>"${tmp_dir}/xlabels.csv"
  echo "10000.0,0.0,99.99%" >>"${tmp_dir}/xlabels.csv"
  echo "100000.0,0.0,99.999%" >>"${tmp_dir}/xlabels.csv"
  echo "1000000.0,0.0,99.9999%" >>"${tmp_dir}/xlabels.csv"
  echo "10000000.0,0.0,100%" >>"${tmp_dir}/xlabels.csv"
}

plot() {
  local -a wrk_files
  local counter=1
  local xlabels="${tmp_dir}/xlabels.csv"
  local plot_directives="plot '${xlabels}' with labels center offset 0, -1 point notitle, "

  while IFS= read -r q; do wrk_files+=("${q}"); done < <(ls -1v data/csv)
  for wrk in "${wrk_files[@]}"; do
    plot_directives+=$(printf '"%s" using 1:2 with lines linestyle %d, ' "data/csv/${wrk}" "${counter}")
    counter=$((counter + 1))
  done

  gnuplot <<EOF
set terminal pngcairo enhanced size 1700,700 font "Merriweather,16"

set title "Latency Distribution" font "Merriweather-Bold,24"
set datafile separator ','

set tics out font ",12"
set xtics rotate
set grid xtics ytics

set key bottom center outside autotitle columnhead font ",14" horizontal
set ylabel "Milliseconds" offset 1,0 font "Merriweather-Bold,14"
set xlabel "Percentile" offset 0,-1.5 font "Merriweather-Bold,14"

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
unset xtics
set bmargin 6

set border back
set output "${OUTPUT_FILE}"

set terminal pngcairo font ",12"
$(echo "${plot_directives}" | sd ", $" '')
exit
EOF
}

open_plot() {
  xdg-open "${OUTPUT_FILE}"
}

main() {
  mktempdir
  plot
  open_plot
}

main
