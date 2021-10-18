all:
	-cd frontend && make

init:
	-cd frontend && bnfc -m ../Instant.cf
clean:
	-cd frontend && make clean

distclean:
	-cd frontend && make distclean

