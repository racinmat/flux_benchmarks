cd(@__DIR__)
using Pkg
pkg"activate ."
using DataFrames, PrettyTables, Printf

logs_dir = joinpath(@__DIR__, "logs")
log_files = readdir(logs_dir, join=true)

function parse_times(filename)
    lines = readlines(filename)
    ms = filter(!isnothing, match.(r"^\s+(\d+)(\.\d+)?\s\w+", lines))
    times = strip.(getproperty.(ms, :match))
end

file = first(log_files)

experiment_names = ["0_11_3", "0_11_3_tricks", "0_11_6", "0_11_6_tricks", "0_12_1", "0_12_1_tricks", 
        "0_11_3_jl_16", "0_11_3_tricks_jl_16", "0_11_6_jl_16", "0_11_6_tricks_jl_16", "0_12_1_jl_16", "0_12_1_tricks_jl_16", "0_12_7_jl_16", "0_12_7_tricks_jl_16", "0_12_8_jl_16"]

filename2experiment(f) = experiment_names[1+parse(Int, f[length("log_flux_bench_parallel_")+1:end-length(".txt")])]
results = Dict(filename2experiment(basename(file))=>parse_times(file) for file in log_files)

function data2df(range, name)
    for (k, v) in results
        if !all(range .∈ Ref(keys(v)))
            @warn "missing data in range $range in file $k"
        end
    end
    part_data = Dict(k=>v[range] for (k, v) in results if !isempty(v))
    df = DataFrame(part_data)
    DataFrame([[names(df)]; collect.(eachrow(df))], [name; Symbol.(["x*y", "x*y'", "m(y)", "grad m(y)"])])
end

df = data2df(1:4, :onehot_bench)

suffixes = ["μs", "ms", "s"]
etalon = "0_11_3"

function add_ratio!(df)
    experiment_col = df |> propertynames |> first
    etalon_idx = findfirst(df[!, experiment_col] .== etalon)
    df[!, experiment_col]
    for c in eachcol(df)[2:end]
        numbers_units = split.(c)
        numbers = parse.(Float64, getindex.(numbers_units, 1))
        units = getindex.(numbers_units, 2)
        if length(unique(units)) > 1
            numbers .*= 1_000 .^ map(x->findfirst(suffixes .== x)-1, units)
        end
        c .*= map(x->@sprintf(", (%.1f%%)", x), numbers .* 100 ./ numbers[etalon_idx])
    end
    df
end

df = add_ratio!(df)

open(joinpath(@__DIR__, "results_slurm_1.md"), "w+") do io
    show(io, df, tf=PrettyTables.tf_markdown, vlines = :all, show_row_number=false, summary=false, eltypes=false)
    println(io)
end
