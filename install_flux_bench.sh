#!/bin/bash

# run it by
# cd /home/matej.racinsky/projects/something/flux_benchmarks && ./install_flux_bench.sh

declare -A projects

projects[0,0]="$HOME/julia-1.5.4/bin/julia"
projects[0,1]="0_11_3"
projects[1,0]="$HOME/julia-1.5.4/bin/julia"
projects[1,1]="0_11_3_tricks"
projects[2,0]="$HOME/julia-1.5.4/bin/julia"
projects[2,1]="0_11_6"
projects[3,0]="$HOME/julia-1.5.4/bin/julia"
projects[3,1]="0_11_6_tricks"
projects[4,0]="$HOME/julia-1.5.4/bin/julia"
projects[4,1]="0_12_1"
projects[5,0]="$HOME/julia-1.5.4/bin/julia"
projects[5,1]="0_12_1_tricks"
projects[6,0]="$HOME/julia-1.6.2/bin/julia"
projects[6,1]="0_11_3"
projects[7,0]="$HOME/julia-1.6.2/bin/julia"
projects[7,1]="0_11_3_tricks"
projects[8,0]="$HOME/julia-1.6.2/bin/julia"
projects[8,1]="0_11_6"
projects[9,0]="$HOME/julia-1.6.2/bin/julia"
projects[9,1]="0_11_6_tricks"
projects[10,0]="$HOME/julia-1.6.2/bin/julia"
projects[10,1]="0_12_1"
projects[11,0]="$HOME/julia-1.6.2/bin/julia"
projects[11,1]="0_12_1_tricks"
projects[12,0]="$HOME/julia-1.6.2/bin/julia"
projects[12,1]="0_12_7"
projects[13,0]="$HOME/julia-1.6.2/bin/julia"
projects[13,1]="0_12_7_tricks"

for i in {0..13}; do echo $i; echo ${projects[$i,0]} ${projects[$i,1]}; cd /home/matej.racinsky/projects/something/flux_benchmarks && ${projects[$i,0]} --project=${projects[$i,1]} -e 'using Pkg; pkg"instantiate; build; precompile"'; done

# then you can run benchmark by sbatch slurm_run_flux_bench_parallel.sh
