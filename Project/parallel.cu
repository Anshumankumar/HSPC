#include <iostream>
#include <stdlib.h>
#include "graph.h"

__global__ void traverse(int *array, int *xadj, int *adj,
        int *current, int *fs, int *entry)
{
    int index = fs[(*current)+blockIdx.x];
    if (index != 0)
    {
        if (array[index] ==  -1)
        {
            for (int i=xadj[index-1]; i < xadj[index]; i++)
                fs[atomicAdd(entry,1)] = adj[i];
            array[index] = 0;
        }
    }
}

int main(int argc, char **argv)
{
    if (argc != 3)
    {
        std::cout << "Invalid no of argument\n";
        std::cout << "Usage: graphTraversal NoOfVertex density\n";
        exit(-2);
    }
    std::vector<int>array,xadj,adj,fs;
    int n = atoi(argv[1]);
    int density = atoi(argv[2]);
    std::cout << "No of Vertices: " << n << "\ndensity No of Connection: "
        << density << "\n";

    graphGenerator(n,density, array,xadj,adj);

    print(array);
    int * dev_array;
    int *dev_xadj;
    int *dev_adj;
    int *dev_entry;
    int *dev_fs;
    int *dev_current;
    cudaMalloc((void**)&dev_array, sizeof(int)*array.size());
    cudaMalloc((void**)&dev_xadj, sizeof(int)*xadj.size());
    cudaMalloc((void**)&dev_adj, sizeof(int)*adj.size());
    cudaMalloc((void**)&dev_fs, sizeof(int)*adj.size()*4);
    cudaMalloc((void**)&dev_entry, sizeof(int));
    cudaMalloc((void**)&dev_current, sizeof(int));
    cudaMemcpy( dev_array, &array[0],
            sizeof(int)*array.size(), cudaMemcpyHostToDevice );

    cudaMemcpy( dev_xadj, &xadj[0],
            sizeof(int)*xadj.size(), cudaMemcpyHostToDevice );

    cudaMemcpy( dev_adj, &adj[0],
            sizeof(int)*adj.size(), cudaMemcpyHostToDevice );


    fs.resize(4*adj.size());
    fs[0] = n-1;
    cudaMemcpy( dev_fs, &fs[0],
            sizeof(int)*fs.size(), cudaMemcpyHostToDevice );

    int stop =1;
    int start = 0;

    while(start != stop)
    {
        cudaMemcpy( dev_current, &start,
                sizeof(int), cudaMemcpyHostToDevice );
        cudaMemcpy( dev_entry, &stop,
                sizeof(int), cudaMemcpyHostToDevice );
        traverse<<<stop-start,1>>>(dev_array, dev_xadj, dev_adj,
                dev_current, dev_fs, dev_entry);
        start = stop;
        cudaMemcpy( &stop, dev_entry,
                sizeof(int), cudaMemcpyDeviceToHost );

    }
    std::cout << "SUCCESSFUL TILL HERE \n";
    cudaMemcpy(&array[0], dev_array,
            sizeof(int)*array.size(), cudaMemcpyDeviceToHost );
    cudaMemcpy(&fs[0], dev_fs,
            sizeof(int)*fs.size(), cudaMemcpyDeviceToHost );




#ifdef DEBUG
    print(fs);
    print(array);
    print(xadj);
    print(adj);
#endif
    return 0;
}
