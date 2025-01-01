```@example example 
using Agents
using AssortiveMatingABM
using GLM
using Plots

model = initialize(;
    n_agents = 1000,
    μ = 0,
    σ = 1,
    λ = 0.50
)

run!(model, stop)

match_values = stack(model.match_values, dims = 1)
lm_fit = lm(@formula(y ~ x), (; x = match_values[:, 1], y = match_values[:, 2]))
scatter(
    match_values[:, 1],
    match_values[:, 2],
    xaxis = "agent 1 value",
    yaxis = "agent 2 value",
    leg = false,
    grid = false,
    markersize = 2.5,
    alpha = 0.50,
    lims = (-4, 4)
)
x = -4:0.01:4
plot!(x, predict(lm_fit, (; x)), color = :black, linestyle = :dash)
βs = coef(lm_fit)
title!("f(x) = $(round(βs[1], digits=2)) + x$(round(βs[2], digits=2))")
```