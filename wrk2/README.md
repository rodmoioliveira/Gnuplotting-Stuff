# wrk

1. First, create the directories for `wrk`, `csv` data and `plot` files:

```sh
mkdir -p data/{wrk,csv,plot}
```

2. Then, collect some latencies with [wrk2](https://github.com/giltene/wrk2):

```sh
wrk2 -t1   -c1 -d30s -R1   --latency "http://jsonplaceholder.typicode.com/todos/1" | tee data/wrk/1.wrk
wrk2 -t8  -c10 -d30s -R10  --latency "http://jsonplaceholder.typicode.com/todos/1" | tee data/wrk/10.wrk
wrk2 -t8  -c25 -d30s -R25  --latency "http://jsonplaceholder.typicode.com/todos/1" | tee data/wrk/25.wrk
wrk2 -t8  -c50 -d30s -R50  --latency "http://jsonplaceholder.typicode.com/todos/1" | tee data/wrk/50.wrk
wrk2 -t8 -c100 -d30s -R100 --latency "http://jsonplaceholder.typicode.com/todos/1" | tee data/wrk/100.wrk
wrk2 -t8 -c200 -d30s -R200 --latency "http://jsonplaceholder.typicode.com/todos/1" | tee data/wrk/200.wrk
wrk2 -t8 -c300 -d30s -R300 --latency "http://jsonplaceholder.typicode.com/todos/1" | tee data/wrk/300.wrk
wrk2 -t8 -c400 -d30s -R400 --latency "http://jsonplaceholder.typicode.com/todos/1" | tee data/wrk/400.wrk
wrk2 -t8 -c400 -d30s -R500 --latency "http://jsonplaceholder.typicode.com/todos/1" | tee data/wrk/500.wrk
```

3. Now you must convert the `wrk` files to `csv`:

```sh
for file in $(fd . data -e wrk); do rg '^ {2,10}\d' --no-filename --no-line-number $file | rg request -v | rg threads -v |  awk '{print $4","$1}' | sed '1i percentile,'$(echo $file  | sd 'data/wrk/' '')'' > "$(echo $file | sd 'wrk' "csv")"; done
```

## Latency

Plot the data with:

```sh
./gnuplot_wrk.sh
```

Result:

<p align="center">
  <img src="https://raw.githubusercontent.com/rodmoioliveira/Gnuplotting-Stuff/main/wrk2/data/plot/wrk.png">
</p>
