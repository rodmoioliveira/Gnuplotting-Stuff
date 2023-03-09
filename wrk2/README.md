# pwrk2

Gnuplot script for plotting latency graphs from [wrk2](https://github.com/giltene/wrk2) `--latency` data.

## Dependencies

  - [bc](https://linux.die.net/man/1/bc)
  - [gawk](https://www.gnu.org/software/gawk/)
  - [getopt](https://man7.org/linux/man-pages/man3/getopt.3.html)
  - [gnuplot](http://www.gnuplot.info/)
  - [rg](https://github.com/BurntSushi/ripgrep)
  - [sd](https://github.com/chmln/sd)

## Usage

```txt
Gnuplot script for plotting latency graphs from wrk2 `--latency` data

Usage:
  pwrk2 [OPTIONS] <FILE>...

Arguments:
  <FILE>...
          A list of space-separated FILES in wrk2 `--latency` format

Options:
      --color-bg <COLOR>
          Set background color [default: #ffffff]

      --color-fg <COLOR>
          Set foreground color [default: #000000]

  -f, --font <FONT>
          Plot font [default: Merriweather]

  -g, --height <HEIGHT>
          Plot height [default: 700]

  -l, --line <LINE-WIDTH>
          Plot latency line width [default: 1.5]

  -k, --kmargin <KMARGIN>
          Bottom plot margin for key labels [default: 6]

  -o, --output <OUTPUT>
          Output plot file [default: pwrk2.png]

  -p, --preview <BOOL>
          Whether or not should open the plot after generation [default: true] [possible values: true, false]

  -s, --scale <FONT-SCALE>
          Plot font scale [default: 1]

  -t, --title <TITLE>
          Plot title [default: Latency Distribution]

  -v, --verbose <BOOL>
          Whether or not to be verbose [default: false] [possible values: true, false]

  -w, --width <WIDTH>
          Plot width [default: 1700]

      --key-from <REGEX>
          Regex to find in the name of <FILE>, used to set key labels

      --key-to <REPLACE>
          Regex to replace the name of <FILE>, used to set key labels

  -h, --help
          Print help information (use `--help` for more detail)

Examples:

  Get some data
    wrk2 -t1 -c1 -d30s -R1 --latency "http://jsonplaceholder.typicode.com/todos/1" | tee 1.hgrm
    wrk2 -t8 -c10 -d30s -R10 --latency "http://jsonplaceholder.typicode.com/todos/1" | tee 10.hgrm
    wrk2 -t8 -c25 -d30s -R25 --latency "http://jsonplaceholder.typicode.com/todos/1" | tee 25.hgrm

  Plot from data
    fd . -e hgrm | pwrk2
    pwrk2 *.hgrm

  Rename plot labels
    fd . -e hgrm | pwrk2 --key-from '(\d{1,10})' --key-to '${1} R/s' --output data/plot/pwrk2.png

  Change plot styles
    fd . -e hgrm | pwrk2 \
      --color-bg "#000000" \
      --color-fg "#ffffff" \
      --font 'Roboto' \
      --scale 1.5 \
      --line 3 \
      --width 1500 \
      --height 1200 \
      --kmargin 7

Author:
  Rodolfo Mói de Oliveira (https://github.com/rodmoioliveira)

Bug Report:
  If you wish to file a bug report, please go to
  https://github.com/rodmoioliveira/Gnuplotting-Stuff/issues
```

## Result

<p align="center">
  <img src="https://raw.githubusercontent.com/rodmoioliveira/Gnuplotting-Stuff/main/wrk2/data/plot/pwrk2.png">
</p>

