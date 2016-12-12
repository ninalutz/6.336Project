# original author Shi Kai Chong {cshikai@mit.edu} 

Open code_to_run.m to see the general logic of the code. All other files are just functions defined separately. They are called in the general file code_to_run.m .

Data files are read from CSVs.

The network is fully described by Matrix R and M, and generated using getMatrices.m


########
R contains, in each column, data on each road. 

|FreeFlowTraveL Time|
|Capacity|
|start node|
|end node|


##################
M contains, in each column, data on the edges connected to to each node. M(ij) = 1 if edge i is going into node j , M(ij) = -1 if edge i is going out of node j. Naturally, the dimensions of M is (# of edges) X ( #of nodes).

Index of edge is reflective of its order of appearance in R.
##################

Feel free to contact me at cshikai@mit.edu} for questions!