# Note that Glucose is based on MiniSAT; this explains why there are
# so many references to MiniSAT.
GLUCOSEDIR=./glucose
OCAMLLIB=$(shell ocamlc -where)
all: lib solver

lib: glucose.cma glucose.cmi

# WARNING: zlib is needed (-lz)
solver: solver.cmo glucose.cma
	ocamlc -o solver glucose.cma solver.cmo -cclib "-lz"

glucose.cma: libglucose_stubs.a glucose_stubs.o glucose.cmo
	ocamlc -a -custom $^ -o glucose.cma -cclib "-lstdc++ -lz"

libglucose_stubs.a:
	@echo "Making Glucose library (called $@) in $(GLUCOSEDIR)/parallel"
	cd $(GLUCOSEDIR)/parallel && LIB=glucose make libs
	mv $(GLUCOSEDIR)/parallel/libglucose_standard.a $@

glucose_stubs.o: glucose_stubs.cc
	g++ -c -I $(OCAMLLIB) -I $(GLUCOSEDIR) $^

glucose.cmo: glucose.ml glucose.cmi
	ocamlc -c glucose.ml

glucose.cmi: glucose.mli
	ocamlc -c glucose.mli

solver.cmo: solver.ml glucose.cmi
	ocamlc -c solver.ml

clean:
	rm -f *.o *.cmo *.cma *.cmi *~ solver lib*.a

install:
	cp lib*.a $(PREFIX)

# ocamlc -cc g++ -c glucose.c -I glucose/ -> glucose_stubs.o
# ocamlc -c glucose.mli -> glucose.cmi, needed for glucose.cma
# ocamlc -c glucose.ml -o glucose.cmo
# ocamlc -custom -a glucose.ml glucose_stubs.o libglucose_stubs.a -cclib "-lstdc++ -lz" -o glucose.cma
