all: clear ferro-build run clean

clear:
	- @clear

ferro-build: 
	- @ocamlc -o ferro src/relp.ml

run:
	- @./ferro

clean:
	- @rm -f ferro src/*.cmi src/*.cmo
