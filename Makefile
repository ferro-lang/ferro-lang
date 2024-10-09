all: clear ferroc-build run

clear:
	- @clear

ferroc-build: 
	- @dune build

run:
	- @dune exec ./src/relp.exe
