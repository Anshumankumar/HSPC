#include "graph.h"


void print(std::vector<int> a)
{
    for(int i=0; i<a.size(); i++)
    {
        std::cout <<a[i] << " ";
    }
    std::cout << "\n";
}

void graphGenerator(int n, int maxCon, std::vector<int> &a,
        std::vector<int> &xadj, std::vector<int> &adj)
{
    srand(time(NULL));
    int noOfEdges = 0;
    for (int i=0;i<n;i++)
    {
        if((i%100)==0) std::cout << i <<"\n";
        a.push_back(rand()%1000);
        int cEdge = std::min(i+1, maxCon);
        cEdge = 1 + rand()%cEdge;
        if (cEdge>=i) cEdge = i;

        std::vector<int> currentList;
        for (int j=0; j< cEdge;)
        {
            int num = rand()%(i+1);
            if (num >=i) continue;
            std::vector<int>::iterator it;
            it = find(currentList.begin(),currentList.end(),num);
            if (it == currentList.end())
            {
                currentList.push_back(num);
                j++;
            }
        }

        noOfEdges += cEdge;
        cEdge = rand()%maxCon;
        for (int j=0; j< cEdge;)
        {
            int num = rand()%n;
            std::vector<int>::iterator it;
            it = find(currentList.begin(),currentList.end(),num);
            if (it == currentList.end())
            {
                currentList.push_back(num);
                j++;
            }
        }

        for(int i=0;i<currentList.size();i++)
        {
            adj.push_back(currentList[i]);
        }

        noOfEdges += cEdge;
        xadj.push_back(noOfEdges);
    }
}

