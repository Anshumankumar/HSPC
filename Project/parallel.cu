#include <iostream>
#include <stdlib.h>
#include "graph.h"

__global__ void travese(int *array, int *xadj, int *adj,
        int *current, int *Fs, int *entry)
{
    array[*current] = array[*current] +1;
}

int main(int argc, char **argv)
{
    if (argc != 3)
    {
        std::cout << "Invalid no of argument\n";
        std::cout << "Usage: graphTraversal NoOfVertex density\n";
        exit(-2);
    }
    std::vector<int>array,xadj,adj,color;
    int n = atoi(argv[1]);
    int density = atoi(argv[2]);
    std::cout << "No of Vertices: " << n << "\ndensity No of Connection: "
        << density << "\n";

    graphGenerator(n,density, array,xadj,adj);
    int * dev_array;
    int *dev_xadj;
    int *dev_adj;
    cudaMalloc((void**)&dev_array, sizeof(int)*array.size());
    cudaMalloc((void**)&dev_xadj, sizeof(int)*xadj.size());
    cudaMalloc((void**)&dev_adj, sizeof(int)*adj.size());

    cudaMemcpy( dev_array, &array[0],
            sizeof(int)*array.size(), cudaMemcpyHostToDevice );

    cudaMemcpy( dev_xadj, &xadj[0],
            sizeof(int)*xadj.size(), cudaMemcpyHostToDevice );

    cudaMemcpy( dev_adj, &adj[0],
            sizeof(int)*adj.size(), cudaMemcpyHostToDevice );


    cudaMemcpy(&array[0], dev_array,
            sizeof(int)*array.size(), cudaMemcpyHostToDevice );
    int stop =1;
    int start = 0;
    matrixMultiplication<<<stop-start,1>>>
    std::cout << dev_array[n-1] <<"\n";
#ifdef DEBUG
    print(xadj);
    print(adj);
#endif
    return 0;
}
