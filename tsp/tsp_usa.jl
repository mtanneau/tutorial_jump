d2 = readdlm("./tsp/distances_usa.txt")
c2 = readdlm("./tsp/cities_usa.txt")

# Some basic unit tests
# If a Test fails, there is an error in your implementation
# Passing the tests does not mean your implementation is correct!
@testset begin
    _s1 = find_subtours(
        [
            [0.0 1.0];
            [1.0 0.0]
        ]
    )  # no sub-tour should be returned here

    _s2 = find_subtours(
        [
            [0.0 1.0 0.0 0.0];
            [1.0 0.0 0.0 0.0];
            [0.0 0.0 0.0 1.0];
            [0.0 0.0 1.0 0.0]
        ]
    )  # two sub-tours should be returned here
    
    @test length(_s1) == 0
    @test length(_s2) == 2
end;

sol2 = solve_tsp2(50, d2, GLPK.Optimizer)
RoadTrip(50, c2, sol2)
![](tsp/solution_usa.png)