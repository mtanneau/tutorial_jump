# Modeling and solving MILPs using JuMP

A hands-on introduction to modeling Mixed-Integer Linear Programs using Julia and JuMP.

## Installation

You need to install:
* Julia v1.0 or later.
Download and installation instructions for Julia can be found [here](https://julialang.org/downloads/).
* the `IJulia` package to run notebooks in Julia. Installation instructions can be found [here](https://github.com/JuliaLang/IJulia.jl).

## Running the notebooks

This tutorial comprises two notebooks:
* [`FacilityLocation.ipynb`](FacilityLocation.ipynb) is an introduction to JuMP syntax.
In this notebook, we compare different formulations of the facility location problem.

* [`TSP.ipynb`](TSP.ipynb) contains a more advanced use case (the Travelling Salesman Problem).
In this notebook, we use JuMP's interface to query solution information about a MILP model, and modify the problem iteratively.

The notebooks in the `master` branch are intended are gap-filling exercices. Working solutions  can be found by checking out the `solution` branch.
