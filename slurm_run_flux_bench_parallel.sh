#!/bin/bash
#SBATCH --job-name=flux_bench_parallel
#SBATCH --output=/home/matej.racinsky/projects/something/flux_benchmarks/logs/log_%x_%a.txt
#SBATCH --cpus-per-task=2
#SBATCH --mem=10G
#SBATCH --partition=med
#SBATCH --array=0-13
##SBATCH --array=5-10
##SBATCH --array=7-10

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

cd /home/matej.racinsky/projects/something/flux_benchmarks && ${projects[$SLURM_ARRAY_TASK_ID,0]} --project="${projects[$SLURM_ARRAY_TASK_ID,1]}" "${projects[$SLURM_ARRAY_TASK_ID,1]}"/main.jl
