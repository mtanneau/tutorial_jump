"""
    find_subtours(n, X)

Compute sub-tours from tentative tour `X`.
"""
function find_subtour(n, X)
    (n, n) == size(X) || throw(DimensionMismatch(
        "n=$n but X has size $(size(X))."
    ))

    # List of all sub-tours in `X`
    # Empty if `X` is a tour
    sub_tours = Vector{Vector{Int}}()

    # `f[i]` is the city that follows `i` in the tour
    f = zeros(Int, n)
    @inbounds for j in 1:n
        for i in 1:n
            X[i, j] == 1.0 && (f[i] = j; break;)
        end
    end
    
    flags = falses(n)
    num_seen = 0  
    while num_seen < n
        first = argmin(flags)  # first city in current tour
        flags[first] && break  # all cities have been visited
        subtour = [first]
        flags[first] = true
        num_seen += 1
        next = f[first]
        next == first && error("X[$first, $first] = $(X[first, first]).")
        while next != first
            push!(subtour, next)
            flags[next] = 1
            num_seen += 1
            next = f[next]
        end

        length(subtour) == n && return sub_tours  # X is a tour
        # @info "Found sub-tour: $subtour"
        push!(sub_tours, subtour)
    end
    
    @info "Found $(length(sub_tours)) sub-tours."
    return sub_tours

end