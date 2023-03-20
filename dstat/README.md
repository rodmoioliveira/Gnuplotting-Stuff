# pdstat

pdstat is a Gnuplot script for plotting graphs from dstat metric data.

## Dependencies

  - [bc](https://linux.die.net/man/1/bc)
  - [gawk](https://www.gnu.org/software/gawk/)
  - [getopt](https://man7.org/linux/man-pages/man3/getopt.3.html)
  - [gnuplot](http://www.gnuplot.info/)
  - [numfmt](https://man7.org/linux/man-pages/man1/numfmt.1.html)
  - [rg](https://github.com/BurntSushi/ripgrep)
  - [sd](https://github.com/chmln/sd)

## TODO!

- [x] Add units for each metric
- [ ] Add flags filters to exclude and include the metrics to plot
- [x] Add flags to slice data intervals
- [x] Add flags to step data intervals
- [ ] Add flags to change metrics unit Gi, Mi, Ki, Gb, Mb, Kb; (?)

## Usage

```txt
pdstat is a Gnuplot script for plotting graphs from dstat metric data.

Usage:
  pdstat [OPTIONS] <FILE>

Arguments:
  <FILE>
          A FILE with dstat metric data

Options:
      --color-bg <COLOR>
          Set background color [default: #ffffff]

      --color-fg <COLOR>
          Set foreground color [default: #000000]

  -f, --font <FONT>
          Multiplot font [default: Merriweather]

  -s, --font-scale <FONT-SCALE>
          Multiplot font scale [default: 1]

  -g, --height <HEIGHT>
          Multiplot height for each graph [default: 350]

  -l, --line-width <LINE-WIDTH>
          Multiplot metric line width [default: 1]

  -o, --output <OUTPUT>
          Output multiplot file [default: <FILE>.png]

  -p, --preview <BOOL>
          Whether or not should open the multiplot after generation [default: true] [possible values: true, false]

  -t, --title <TITLE>
          Multiplot title [default: dstat]

      --x-mod <MOD>
          Select/filter data to plot by `data point line number mod <MOD> == 0` in the x-axis [default: 1]

  -x, --x-range <START>:<END>
          Select/filter the range of data to plot in the x-axis [default: '0:100']

  -v, --verbose <BOOL>
          Whether or not to be verbose [default: false] [possible values: true, false]

  -w, --width <WIDTH>
          Multiplot width [default: 1400]

  -h, --help
          Print help information (use `--help` for more detail)

Examples:

  Get some data
    dstat --time --cpu --disk --socket 1 60 | tee file.dstat

  Plot from data
    pdstat file.dstat

  Change plot styles
    pdstat \
      --color-bg "#000000" \
      --color-fg "#ffffff" \
      --font 'Roboto' \
      --font-scale 0.9 \
      --line-width 3 \
      --width 1300 \
      --height 300 \
      file.dstat

  Slice your data
    pdstat --x-range 50:100 file.dstat

  Decrease the granularity of data points
    pdstat --x-mod 2 file.dstat

Author:
  Rodolfo Mói de Oliveira (https://github.com/rodmoioliveira)

Bug Report:
  If you wish to file a bug report, please go to
  https://github.com/rodmoioliveira/Gnuplotting-Stuff/issues
```

## Result

<p align="center">
  <img src="https://github.com/rodmoioliveira/Gnuplotting-Stuff/blob/main/dstat/data/plot/default/all.png">
</p>

