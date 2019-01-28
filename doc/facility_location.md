# Facility location problem

Benchmark instances: http://resources.mpi-inf.mpg.de/departments/d1/projects/benchmarks/UflLib/

## Uncapacitated facility location

### Problem description

* $M=\{1, \dots, m\}$ clients, $N=\{ 1, \dots, n\}$ sites where a facility can be built.
* $f_j$: fixed cost of building a facility at site $j$
* $c_{i, j}$: cost for serving customer $i$ from facility $j$

### Compact MILP formulation

$$
    \begin{array}{cl}
        \min_{x, y} \ \ \ &
            \sum_{i, j} c_{i, j} x_{i, j} + 
            \sum_{j} f_{j} y_{j}\\
        s.t. &
            \sum_{j} x_{i, j} = 1, \ \ \ \forall i \in M\\
        &   \sum_{i} x_{i, j} \leq m y_{j}, \ \ \ \forall j \in N\\
        &   x_{i, j}, y_{j} \in \{0, 1\}, \ \ \ \forall i \in M, j \in N
    \end{array}
$$

### Extended MILP formulation

$$
    \begin{array}{cl}
        \min_{x, y} \ \ \ &
            \sum_{i, j} c_{i, j} x_{i, j} + 
            \sum_{j} f_{j} y_{j}\\
        s.t. &
            \sum_{j} x_{i, j} = 1, \ \ \ \forall i \in M\\
        &   x_{i, j} \leq y_{j}, \ \ \ \forall i \in M, j \in N\\
        &   x_{i, j}, y_{j} \in \{0, 1\}, \ \ \ \forall i \in M, j \in N
    \end{array}
$$

## Capacitated Facility location

* Each client $i$ has a demand $a_{i}$, and each facility has a capacity $q_{j}$