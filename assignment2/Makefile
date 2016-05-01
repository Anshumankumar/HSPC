all: main oMpMain mpi_main

main: main.cpp matrix.cpp
	g++ -std=c++11 -o  main  main.cpp matrix.cpp -g -pg -static-libgcc

oMpMain: main.cpp matrix.cpp
	g++ -std=c++11  -fopenmp -o oMpMain main.cpp matrix.cpp -g -pg -static-libgcc

mpi_main: mpi_main.cpp matrix.cpp
	mpic++ -std=c++11 -o mpi_main mpi_main.cpp matrix.cpp -g -pg -static-libgcc


clean:
	rm mpi_main oMpMain main

report/HW2.pdf: report
	(cd report; python2 plotter.py; pdflatex HW2.tex)
