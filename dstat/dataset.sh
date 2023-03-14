#!/bin/bash

declare TRACE
[[ "${TRACE}" == 1 ]] && set -o xtrace
set -o errexit
set -o pipefail
set -o noclobber

# Dstat options:
# dstat --time --cpu    1 10 | tee data/dstat/test/cpu.dstat
# dstat --time --disk   1 10 | tee data/dstat/test/disk.dstat
# dstat --time --page   1 10 | tee data/dstat/test/page.dstat
# dstat --time --int    1 10 | tee data/dstat/test/int.dstat
# dstat --time --load   1 10 | tee data/dstat/test/load.dstat
# dstat --time --mem    1 10 | tee data/dstat/test/mem.dstat
# dstat --time --net    1 10 | tee data/dstat/test/net.dstat
# dstat --time --proc   1 10 | tee data/dstat/test/proc.dstat
# dstat --time --io     1 10 | tee data/dstat/test/io.dstat
# dstat --time --swap   1 10 | tee data/dstat/test/swap.dstat
# dstat --time --sys    1 10 | tee data/dstat/test/sys.dstat
# dstat --time --aio    1 10 | tee data/dstat/test/aio.dstat
# dstat --time --fs     1 10 | tee data/dstat/test/fs.dstat
# dstat --time --ipc    1 10 | tee data/dstat/test/ipc.dstat
# dstat --time --lock   1 10 | tee data/dstat/test/lock.dstat
# dstat --time --raw    1 10 | tee data/dstat/test/raw.dstat
# dstat --time --socket 1 10 | tee data/dstat/test/socket.dstat
# dstat --time --tcp    1 10 | tee data/dstat/test/tpc.dstat
# dstat --time --udp    1 10 | tee data/dstat/test/udp.dstat
# dstat --time --unix   1 10 | tee data/dstat/test/unix.dstat
# dstat --time --vm     1 10 | tee data/dstat/test/vm.dstat
# dstat --time --vm-adv 1 10 | tee data/dstat/test/vm-adv.dstat
# dstat --time --zones  1 10 | tee data/dstat/test/zones.dstat

./pdstat data/dstat/test/cpu.dstat
./pdstat data/dstat/test/disk.dstat
./pdstat data/dstat/test/page.dstat
./pdstat data/dstat/test/int.dstat
./pdstat data/dstat/test/load.dstat
./pdstat data/dstat/test/mem.dstat
./pdstat data/dstat/test/net.dstat
./pdstat data/dstat/test/proc.dstat
./pdstat data/dstat/test/io.dstat
./pdstat data/dstat/test/swap.dstat
./pdstat data/dstat/test/sys.dstat
./pdstat data/dstat/test/aio.dstat
./pdstat data/dstat/test/fs.dstat
./pdstat data/dstat/test/ipc.dstat
./pdstat data/dstat/test/lock.dstat
./pdstat data/dstat/test/raw.dstat
./pdstat data/dstat/test/socket.dstat
./pdstat data/dstat/test/tpc.dstat
./pdstat data/dstat/test/udp.dstat
./pdstat data/dstat/test/unix.dstat
./pdstat data/dstat/test/vm.dstat
./pdstat data/dstat/test/vm-adv.dstat
./pdstat data/dstat/test/zones.dstat

# dstat --time --epoch | tee data/dstat/test/epoch.dstat
# dstat    # -C 0,3,total       #      include cpu0, cpu3 and total
# dstat    # -D total,hda       #      include hda and total
# dstat    # -I 5,eth2          #      include int5 and interrupt used by eth2
# dstat    # -N eth1,total      #      include eth1 and total
# dstat    # -S swap1,total     #      include swap1 and total

# --list                   list all available plugins
# --<plugin-name>          enable external plugin by name (see --list)

# -a, --all                equals -cdngy (default)
# -f, --full               automatically expand -C, -D, -I, -N and -S lists
# -v, --vmstat             equals -pmgdsc -D total

# --bits                   force bits for values expressed in bytes
# --float                  force float values on screen
# --integer                force integer values on screen

# --bw, --black-on-white   change colors for white background terminal
# --color                  force colors
# --nocolor                disable colors
# --noheaders              disable repetitive headers
# --noupdate               disable intermediate updates
# --output file            write CSV output to file
# --profile                show profiling statistics when exiting dstat
