CC=gcc
CFLAGS= -Wall -g -std=c99

ODIR=obj

program: *.c
	gcc -o $@ $^ $(CFLAGS)

.PHONY: clean

clean:
	rm -f program
	