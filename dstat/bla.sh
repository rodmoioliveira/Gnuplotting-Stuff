#!/bin/bash

declare TRACE
[[ "${TRACE}" == 1 ]] && set -o xtrace
set -o errexit
set -o pipefail
set -o noclobber

clean_tempdir() {
  rm -rf "${TMP_DIR}"
}

trap clean_tempdir EXIT

DSTAT_FILE="data/dstat/data.dstat"

mktempdir() {
  if ! TMP_DIR=$(mktemp -d -t gnuplot-dstat-XXXXXXXXXX); then
    printf 1>&2 "Couldn't create %s\n" "${TMP_DIR}"
    exit 1
  fi

  CSV_PARSED="${TMP_DIR}/parsed.csv"
  CSV_SORTED="${TMP_DIR}/sorted.csv"
  CSV_NUMFMT="${TMP_DIR}/numfmt.csv"
}

dstat_to_csv() {
  array_counter=0
  local -a headers
  local -a headers_stats
  local -a headers_parsed
  local -a headers_parsed_new_line
  while IFS= read -r q; do headers+=("${q}"); done < <(cat "${DSTAT_FILE}" | sd -- '- ' '-|' | sd -- '-{2,}' '' | sd -s -- '-|' '|' | sd -s -- '|-' '|' | head -n1 | sd '\|' '\n')
  while IFS= read -r q; do headers_stats+=("${q}"); done < <(cat "${DSTAT_FILE}" | sd -- '- ' '-|' | sd -- '-{2,}' '' | sd -s -- '-|' '|' | sd -s -- '|-' '|' | head -n2 | tail -n1 | sd '\|' '\n' | sd '^ {1,1000}' '' | sd ' {2,1000}' ' ' | sd ' {0,1000}\n' '\n')

  for hs in "${headers_stats[@]}"; do
    local -a stats
    while IFS= read -r q; do stats+=("${q}"); done < <(echo "${hs}" | sd ' ' '\n')
    for s in "${stats[@]}"; do headers_parsed+=("${headers[${array_counter}]}/$s"); done
    stats=()
    array_counter=$((array_counter + 1))
  done

  headers_parsed_new_line=$(echo "${headers_parsed[@]}" | sd ' ' '\n')

  if memory_usage_lines=$(echo "${headers_parsed_new_line}" | rg memory-usage --line-number); then
    numfmt_memory_usage=$(echo "${memory_usage_lines}" | awk -F':' '{print $1}' | awk 'NR==1; END{print}' | sd -- '\n' '-' | sd -- '-$' '' | sd '(.+)' ' | numfmt --header --field $1 --from=si --delimiter=","')
  fi

  if disk_total_lines=$(echo "${headers_parsed_new_line}" | rg -F "dsk/total" --line-number); then
    numfmt_disk_total=$(echo "${disk_total_lines}" | awk -F':' '{print $1}' | awk 'NR==1; END{print}' | sd -- '\n' '-' | sd -- '-$' '' | sd '(.+)' ' | numfmt --header --field $1 --from=si --delimiter=","')
  fi

  if net_total_lines=$(echo "${headers_parsed_new_line}" | rg -F "net/total" --line-number); then
    numfmt_net_total=$(echo "${net_total_lines}" | awk -F':' '{print $1}' | awk 'NR==1; END{print}' | sd -- '\n' '-' | sd -- '-$' '' | sd '(.+)' ' | numfmt --header --field $1 --from=si --delimiter=","')
  fi

  if swap_lines=$(echo "${headers_parsed_new_line}" | rg -F "swap/" --line-number); then
    numfmt_swap=$(echo "${swap_lines}" | awk -F':' '{print $1}' | awk 'NR==1; END{print}' | sd -- '\n' '-' | sd -- '-$' '' | sd '(.+)' ' | numfmt --header --field $1 --from=si --delimiter=","')
  fi

  if inodes_lines=$(echo "${headers_parsed_new_line}" | rg -F "filesystem/inodes" --line-number); then
    numfmt_inodes=$(echo "${inodes_lines}" | awk -F':' '{print $1}' | awk 'NR==1; END{print}' | sd -- '\n' '-' | sd -- '-$' '' | sd '(.+)' ' | numfmt --header --field $1 --from=si --delimiter=","')
  fi

  if vm_lines=$(echo "${headers_parsed_new_line}" | rg -F "virtual-memory/" --line-number); then
    numfmt_vm=$(echo "${vm_lines}" | awk -F':' '{print $1}' | awk 'NR==1; END{print}' | sd -- '\n' '-' | sd -- '-$' '' | sd '(.+)' ' | numfmt --header --field $1 --from=si --delimiter=","')
  fi

  if io_total=$(echo "${headers_parsed_new_line}" | rg -F "io/total/" --line-number); then
    numfmt_io=$(echo "${io_total}" | awk -F':' '{print $1}' | awk 'NR==1; END{print}' | sd -- '\n' '-' | sd -- '-$' '' | sd '(.+)' ' | numfmt --header --field $1 --from=si --delimiter=","')
  fi

  if sys=$(echo "${headers_parsed_new_line}" | rg '(system/int|system/csw)' --line-number); then
    numfmt_sys=$(echo "${sys}" | awk -F':' '{print $1}' | awk 'NR==1; END{print}' | sd -- '\n' '-' | sd -- '-$' '' | sd '(.+)' ' | numfmt --header --field $1 --from=si --delimiter=","')
  fi

  echo "${headers_parsed[@]}" | sd ' ' ',' >|"${CSV_PARSED}"
  awk 'NR > 2 { print }' "${DSTAT_FILE}" |
    sd '(^\d{2}-\d{2}) ((\d{2}:){2}\d{2})' '${1}_${2}' |
    sd -s '|' ' ' |
    sd ' {1,1000}' ' ' |
    sd '^ ' '' |
    sd ' ' ',' |
    sd ',$' '' |
    sort -u |
    tac |
    sort -k1 >>"${CSV_PARSED}"

  cat "${CSV_PARSED}" | sd '(^\d{2})(-)(\d{2})_(\d{2}:\d{2}:\d{2})(.+)' '$1/$3-$4${5}' | sd '(\d)k' '${1}K' | sd '(\d)B' '${1}' >|"${CSV_SORTED}"
  eval "cat ${CSV_SORTED} ${numfmt_memory_usage} ${numfmt_disk_total} ${numfmt_net_total} ${numfmt_swap} ${numfmt_inodes} ${numfmt_vm} ${numfmt_io} ${numfmt_sys}" | tee "${CSV_NUMFMT}"

  # echo "${memory_usage_lines}"
  # echo "${disk_total_lines}"
  # echo "${net_total_lines}"
  # echo "${swap_lines}"
  # echo "${inodes_lines}"
  # echo "${vm_lines}"
}

main() {
  mktempdir
  dstat_to_csv
}

main
