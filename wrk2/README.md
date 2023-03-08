# pwrk2

Gnuplot script for plotting latency graphs from [wrk2](https://github.com/giltene/wrk2) `--latency` data.

## Dependencies

  - [bc](https://linux.die.net/man/1/bc)
  - [gawk](https://www.gnu.org/software/gawk/)
  - [getopt](https://man7.org/linux/man-pages/man3/getopt.3.html)
  - [gnuplot](http://www.gnuplot.info/)
  - [rg](https://github.com/BurntSushi/ripgrep)
  - [sd](https://github.com/chmln/sd)
  - [sed](https://www.gnu.org/software/sed/manual/sed.html)

## Usage

```txt
Gnuplot script for plotting latency graphs from wrk2 `--latency` data

Usage:
  pwrk2 [OPTIONS] <FILE>...

Arguments:
  <FILE>...
          A list of space-separated FILES in wrk2 `--latency` format

Options:
      --title <TITLE>
          Plot title [default: Latency Distribution]

      --color-fg <COLOR>
          Set foreground color [default: #222222]

      --color-bg <COLOR>
          Set background color [default: #f9f9f9]

      --font <FONT>
          Plot font [default: Merriweather]

      --font-scale <FONT-SCALE>
          Plot font scale [default: 1]

      --height <HEIGHT>
          Plot height [default: 700]

      --width <WIDTH>
          Plot width [default: 1700]

      --line-width <LINE-WIDTH>
          Plot latency line width [default: 1.5]

      --key-from <REGEX>
          Regex to find in the name of <FILE>, used to set key labels

      --key-to <REPLACE>
          Regex to replace the name of <FILE>, used to set key labels

      --key-margin <MARGIN>
          Bottom plot margin for key labels [default: 6]

      --open <BOOL>
          Whether or not should open the plot after generation [default: true] [possible values: true, false]

  -o, --output <OUTPUT>
          Output plot file [default: pwrk2.png]

  -h, --help
          Print help information (use `-h` for a summary)

Get some data:
  wrk2 -t1 -c1 -d30s -R1 --latency "http://jsonplaceholder.typicode.com/todos/1" | tee 1.wrk
  wrk2 -t8 -c10 -d30s -R10 --latency "http://jsonplaceholder.typicode.com/todos/1" | tee 10.wrk
  wrk2 -t8 -c25 -d30s -R25 --latency "http://jsonplaceholder.typicode.com/todos/1" | tee 25.wrk

Plot from data:
  fd . -e wrk | pwrk2
  pwrk2 *.wrk

Rename plot labels:
  fd . -e wrk | pwrk2 --key-from '(\d{1,10})' --key-to '${1} R/s' --output data/plot/pwrk2.png

Change plot styles:
  fd . -e wrk | pwrk2 \
    --color-bg "#000000" \
    --color-fg "#ffffff" \
    --font 'Roboto' \
    --font-scale 1.5 \
    --line-width 3 \
    --width 1500 \
    --height 1200 \
    --key-margin 7
```

## Result

<p align="center">
  <img src="https://raw.githubusercontent.com/rodmoioliveira/Gnuplotting-Stuff/main/wrk2/data/plot/pwrk2.png">
</p>

