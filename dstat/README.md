# dstat

1. First, create the directories for `dstat`, `csv` data and `plot` files:

```sh
mkdir -p data/{dstat,csv,plot}
```

2. Then, collect some metrics with [dstat](https://command-not-found.com/dstat):

```sh
dstat -tcdglmnprsy --fs --vm | tee data/dstat/data.dstat
```

3. Now you must convert the `dstat` files to `csv`:

```sh
bat data/dstat/data.dstat | rg -v -- '--'  | sd '(^\d{2}-\d{2}) ((\d{2}:){2}\d{2})' '${1}_${2}' | sd -s '|' ' ' | sd ' {1,1000}' ' ' | sd '^ ' '' | sd ' ' ',' | sd ',$' '' | sort -u | tac | sd 'time,usr,sys,idl,wai,stl,read,writ,in,out,1m,5m,15m,used,free,buff,cach,recv,send,run,blk,new,read,writ,used,free,int,csw,files,inodes,majpf,minpf,alloc,free' 'time,cpu-usr,cpu-sys,cpu-idl,cpu-wai,cpu-stl,dsk-read,dsk-writ,pag-in,pag-out,lavg-1m,lavg-5m,lavg-15m,mem-used,mem-free,mem-buff,mem-cach,net-recv,net-send,proc-run,proc-blk,proc-new,io-read,io-writ,swap-used,swap-free,sys-int,sys-csw,fs-files,fs-inodes,vm-majpf,vm-minpf,vm-alloc,vm-free' | mlr --csv sort -f time | sd '(^\d{2})(-)(\d{2})_(\d{2}:\d{2}:\d{2})(.+)' '$1/$3-$4${5}' > data/csv/data.csv
```

## CPU

Plot the data with:

```sh
./gnuplot_dstat_cpu.sh
```

Result:

<p align="center">
  <img src="https://raw.githubusercontent.com/rodmoioliveira/Gnuplotting-Stuff/main/dstat/data/plot/cpu.png">
</p>


## IO

Plot the data with:

```sh
./gnuplot_dstat_io.sh
```

Result:

<p align="center">
  <img src="https://raw.githubusercontent.com/rodmoioliveira/Gnuplotting-Stuff/main/dstat/data/plot/io.png">
</p>


## Proc

Plot the data with:

```sh
./gnuplot_dstat_proc.sh
```

Result:

<p align="center">
  <img src="https://raw.githubusercontent.com/rodmoioliveira/Gnuplotting-Stuff/main/dstat/data/plot/proc.png">
</p>
