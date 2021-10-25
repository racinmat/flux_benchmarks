cd(@__DIR__)
using Pkg
pkg"instantiate"
using Flux

using LinearAlgebra
function Base.:*(A::AbstractMatrix, B::Flux.OneHotMatrix)
	m = size(A,1)
	Y = similar(A, m, size(B,2))
	for (j, ix) in enumerate(B.indices)
		for i in 1:m
			@inbounds Y[i,j] = A[i,ix]
		end
	end
	Y
end
function Base.:*(A::AbstractMatrix, B::Adjoint{Bool,<: Flux.OneHotArray})
	m = size(A,1)
	Y = similar(A, m, size(B,2))
	Y .= 0
	BT = B'
	for (j, ix) in enumerate(BT.indices)
		for i in 1:m
			@inbounds Y[i,ix] += A[i,j]
		end
	end
	Y
end

pkg"precompile"

@info "running" @__DIR__

include(joinpath(@__DIR__, "..", "benchs.jl"))
