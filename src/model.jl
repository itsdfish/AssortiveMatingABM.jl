@agent struct Agent(NoSpaceAgent)
    value::Float64
    λ::Float64
end

function initialize(;
    n_agents,
    μ,
    σ,
    λ
)
    space = nothing
    model = StandardABM(
        Agent,
        space;
        properties = Dict(
            :match_values => Vector{Vector{Float64}}(),
        ),
        agent_step!,
        scheduler = Schedulers.Randomly()
    )
    for _ ∈ 1:n_agents
        add_agent!(
            model;
            λ,
            value = rand(Normal(μ, σ))
        )
    end
    return model
end

function agent_step!(agent1, model)
    agent2 = random_agent(model, a -> a.id ≠ agent1.id)
    if does_match(agent1, agent2) || (nagents(model) == 2)
        push!(model.match_values, [agent1.value, agent2.value])
        remove_agent!(agent1.id, model)
        remove_agent!(agent2.id, model)
    end
    return nothing
end

"""
    does_match(agent1, agent2)

Returns true if the agents match and returns false otherwise. 

# Arguments 

- `agent1`: agent 1 of a potential pair  
- `agent2`: agent 2 of a potential pair 
"""
function does_match(agent1, agent2)
    return accept(agent1, agent2) && accept(agent2, agent1)
end

"""
    accept(agent1, agent2)

Agent 1 compares its value to the value of agent 2. Agent 1 accepts agent 2 with a probability 
defined by a probit model.

# Arguments 

- `agent1`: agent 1 of a potential pair  
- `agent2`: agent 2 of a potential pair 
"""
function accept(agent1, agent2)
    p = cdf(Normal(0, agent1.λ), agent2.value - agent1.value)
    return rand() ≤ p
end

stop(model, _) = nagents(model) == 0
