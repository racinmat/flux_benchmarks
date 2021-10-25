using BenchmarkTools, Random
# default is 5
BenchmarkTools.DEFAULT_PARAMETERS.seconds = 10
# default is 1
BenchmarkTools.DEFAULT_PARAMETERS.evals = 3

Random.seed!(42)
x = rand(Float32, 100, 100)
y = Flux.onehotbatch(1:100, 1:100)

m = Dense(100, 100)
y
@btime x*y
@btime x*y'

@btime m(y)
@btime gradient(() -> sum(m(y)), Flux.params(m))
