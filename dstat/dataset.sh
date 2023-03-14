#!/bin/bash

declare TRACE
[[ "${TRACE}" == 1 ]] && set -o xtrace
set -o errexit
set -o pipefail
set -o noclobber

TIMER=600

generate_dstat() {
  dstat --time --cpu 1 "${TIMER}" | tee data/dstat/test/cpu.dstat &
  dstat --time --disk 1 "${TIMER}" | tee data/dstat/test/disk.dstat &
  dstat --time --page 1 "${TIMER}" | tee data/dstat/test/page.dstat &
  dstat --time --int 1 "${TIMER}" | tee data/dstat/test/int.dstat &
  dstat --time --load 1 "${TIMER}" | tee data/dstat/test/load.dstat &
  dstat --time --mem 1 "${TIMER}" | tee data/dstat/test/mem.dstat &
  dstat --time --net 1 "${TIMER}" | tee data/dstat/test/net.dstat &
  dstat --time --proc 1 "${TIMER}" | tee data/dstat/test/proc.dstat &
  dstat --time --io 1 "${TIMER}" | tee data/dstat/test/io.dstat &
  dstat --time --swap 1 "${TIMER}" | tee data/dstat/test/swap.dstat &
  dstat --time --sys 1 "${TIMER}" | tee data/dstat/test/sys.dstat &
  dstat --time --aio 1 "${TIMER}" | tee data/dstat/test/aio.dstat &
  dstat --time --fs 1 "${TIMER}" | tee data/dstat/test/fs.dstat &
  dstat --time --ipc 1 "${TIMER}" | tee data/dstat/test/ipc.dstat &
  dstat --time --lock 1 "${TIMER}" | tee data/dstat/test/lock.dstat &
  dstat --time --raw 1 "${TIMER}" | tee data/dstat/test/raw.dstat &
  dstat --time --socket 1 "${TIMER}" | tee data/dstat/test/socket.dstat &
  dstat --time --tcp 1 "${TIMER}" | tee data/dstat/test/tpc.dstat &
  dstat --time --udp 1 "${TIMER}" | tee data/dstat/test/udp.dstat &
  dstat --time --unix 1 "${TIMER}" | tee data/dstat/test/unix.dstat &
  dstat --time --vm 1 "${TIMER}" | tee data/dstat/test/vm.dstat &
  dstat --time --vm-adv 1 "${TIMER}" | tee data/dstat/test/vm-adv.dstat &
  dstat --time --zones 1 "${TIMER}" | tee data/dstat/test/zones.dstat &
  dstat --time \
    --cpu \
    --disk \
    --page \
    --int \
    --load \
    --mem \
    --net \
    --proc \
    --io \
    --swap \
    --sys \
    --aio \
    --fs \
    --ipc \
    --lock \
    --raw \
    --socket \
    --tcp \
    --udp \
    --unix \
    --vm \
    --vm-adv \
    --zones 1 "${TIMER}" | tee data/dstat/test/all.dstat
  sleep 10
}

plot_dstat() {
  ./pdstat data/dstat/test/cpu.dstat &
  ./pdstat data/dstat/test/disk.dstat &
  ./pdstat data/dstat/test/page.dstat &
  ./pdstat data/dstat/test/int.dstat &
  ./pdstat data/dstat/test/load.dstat &
  ./pdstat data/dstat/test/mem.dstat &
  ./pdstat data/dstat/test/net.dstat &
  ./pdstat data/dstat/test/proc.dstat &
  ./pdstat data/dstat/test/io.dstat &
  ./pdstat data/dstat/test/swap.dstat &
  ./pdstat data/dstat/test/sys.dstat &
  ./pdstat data/dstat/test/aio.dstat &
  ./pdstat data/dstat/test/fs.dstat &
  ./pdstat data/dstat/test/ipc.dstat &
  ./pdstat data/dstat/test/lock.dstat &
  ./pdstat data/dstat/test/raw.dstat &
  ./pdstat data/dstat/test/socket.dstat &
  ./pdstat data/dstat/test/tpc.dstat &
  ./pdstat data/dstat/test/udp.dstat &
  ./pdstat data/dstat/test/unix.dstat &
  ./pdstat data/dstat/test/vm.dstat &
  ./pdstat data/dstat/test/vm-adv.dstat &
  ./pdstat data/dstat/test/zones.dstat &
  ./pdstat data/dstat/test/all.dstat
  sleep 10
}

open_plots() {
  fd . -e png | rg test | xargs -n1 xdg-open
}

main() {
  generate_dstat
  plot_dstat
  open_plots
}

main
