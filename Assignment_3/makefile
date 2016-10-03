CC=gcc
CFLAGS= -Wall -g -std=c99

ODIR=obj

bms: *.c
	gcc -o $@ $^ $(CFLAGS)

.PHONY: clean

clean:
	rm -f bms
	