# Note that Glucose is based on MiniSAT; this explains why there are
# so many references to MiniSAT.
GLUCOSEDIR=../glucose
OCAMLLIB=$(shell opam config var lib)/ocaml
all: lib solver

lib: glucose.cma glucose.cmi

# WARNING: zlib is needed (-lz)
solver: solver.cmo glucose.cma
	ocamlc -o solver glucose.cma solver.cmo -cclib "-lz"

glucose.cma: lib_standard.a glucoseWrap.o glucose.cmo
	ocamlc -a -custom $^ -o glucose.cma -cclib "-lstdc++"

lib_standard.a:
	@echo "Making Glucose library (called $@) in $(GLUCOSEDIR)/parallel"
	cd $(GLUCOSEDIR)/parallel && make libs
	mv $(GLUCOSEDIR)/parallel/$@ $@

glucoseWrap.o: glucoseWrap.cc
	g++ -c -I $(OCAMLLIB) -I $(GLUCOSEDIR) glucoseWrap.cc

glucose.cmo: glucose.ml glucose.cmi
	ocamlc -c glucose.ml

glucose.cmi: glucose.mli
	ocamlc -c glucose.mli

solver.cmo: solver.ml glucose.cmi
	ocamlc -c solver.ml

clean:
	rm -f *.o *.cmo *.cma *.cmi *~ solver lib*.a
