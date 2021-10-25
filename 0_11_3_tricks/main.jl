cd(@__DIR__)
using Pkg
pkg"instantiate"
using Flux

using LinearAlgebra
function Base.:*(A::AbstractMatrix, B::Flux.OneHotMatrix)
	m = size(A,1)
	Y = similar(A, m, size(B,2))
	for (j,ohv) in enumerate(B.data)
		ix = ohv.ix
		for i in 1:m
			@inbounds Y[i,j] = A[i,ix]
		end
	end
	Y
end
function Base.:*(A::AbstractMatrix, B::Adjoint{Bool,<: Flux.OneHotMatrix})
	m = size(A,1)
	Y = similar(A, m, size(B,2))
	Y .= 0
	BT = B'
	for (j,ohv) in enumerate(BT.data)
		ix = ohv.ix
		for i in 1:m
			@inbounds Y[i,ix] += A[i,j]
		end
	end
	Y
end

pkg"precompile"

@info "running" @__DIR__

include(joinpath(@__DIR__, "..", "benchs.jl"))
