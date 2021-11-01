using Pkg
pkg"activate ."
using DataFrames, TOML

projects = ["0_11_3", "0_11_3_tricks", "0_11_6", "0_11_6_tricks", "0_12_1", "0_12_1_tricks", "0_12_7", "0_12_7_tricks", "0_12_8"]
libs = ["Zygote", "Flux", "project"]

res = Dict()

for p in projects
    @info p
    versions = Dict{Symbol,Any}(Symbol(k)=>v[1]["version"] for (k, v) in TOML.parsefile(joinpath(p, "Manifest.toml")) if k ∈ libs)
    res[Symbol(p)] = versions
    res[Symbol(p)][:project] = p
end

df = DataFrame((; res...))

open(joinpath(@__DIR__, "results_slurm_1.md"), "a+") do io
    println(io)
    println(io)
    show(io, df, tf=PrettyTables.tf_markdown, vlines = :all, show_row_number=false, summary=false, eltypes=false)
    println(io)
    println(io)
end

