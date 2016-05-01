all: graphTraversal graphTraversalD

graph.o: graph.cu
	nvcc graph.cu -c

graphTraversal: parallel.cu graph.o
	nvcc parallel.cu graph.o -o graphTraversal

graphTraversalD: parallel.cu graph.o
	nvcc parallel.cu graph.o -o graphTraversalD -DDEBUG=1

clean:
	rm graphTraversal graphTraversalD graph.o

report/Project.pdf: report
	(cd report; python2 plotter.py; pdflatex HW3.tex)


