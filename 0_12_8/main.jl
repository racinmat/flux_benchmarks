cd(@__DIR__)
using Pkg
pkg"instantiate"
using Flux

pkg"precompile"

@info "running" @__DIR__

include(joinpath(@__DIR__, "..", "benchs.jl"))
