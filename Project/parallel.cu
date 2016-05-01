#include <iostream>
#include <stdlib.h>
#include "graph.h"

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

#ifdef DEBUG
    print(xadj);
    print(adj);
#endif
    return 0;
}
