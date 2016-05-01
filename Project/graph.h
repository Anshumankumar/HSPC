#ifndef GRAPH_H
#define GRAPH_H

#include <math.h>
#include <vector>
#include <stdlib.h>
#include <time.h>
#include <algorithm>
#include <iostream>

void print(std::vector<int> a);
void graphGenerator(int n, int maxCon, std::vector<int> &a,
                std::vector<int> &xadj, std::vector<int> &adj);

#endif
