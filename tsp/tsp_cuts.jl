include("subtour.jl")

function add_subtour_elimination!(mip, X, s)

    S = length(s)
    @constraint(mip, sum(X[s[k], s[(k+1)]] for k in 1:S-1) + X[s[end], s[1]] <= S-1)
    @constraint(mip, sum(X[s[k+1], s[k]] for k in 1:S-1) + X[s[1], s[end]] <= S-1)

    return nothing
end


"""
    solve_tsp(n, D)


"""
function solve_tsp(n, D, optimizer; itermax = 100)

    # instantiate model
    mip = Model(with_optimizer(optimizer))

    # Basic formulation
    @variable(mip, X[1:n, 1:n], Bin)

    # Objective
    @objective(mip, Min, sum(X.*D))

    for i in 1:n
        @constraint(mip, X[i, i] == 0.0)  # city `i` cannot follow itself in the tour
    end

    # Each city has one predecessor and one successor
    for i in 1:n
        @constraint(mip, sum(X[i, j] for j in 1:n) == 1.0)
        @constraint(mip, sum(X[j, i] for j in 1:n) == 1.0)
    end

    t_start = time()
    num_iter = 0
    while (time() - t_start < 300.0) && (num_iter < itermax)
        num_iter += 1
        # solve relaxed model
        optimize!(mip)

        # get solution
        X_ = value.(X)

        # find sub-tours
        sub_tours = find_subtours(n, X_)

        if length(sub_tours) == 0
            @info "Optimal solution found"
            return X_
        else
            for subtour in sub_tours
                add_subtour_elimination!(mip, X, subtour)
            end
        end
    end
    
    @info "Time limit reached."
    return value.(X)
end