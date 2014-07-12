CFLAGS=-I/usr/local/include
LDFLAGS=-L/usr/local/lib

all:	daserver daclient

daclient:	daclient.c
	gcc -o daclient daclient.c -lzmq

daserver:	daserver.c
	gcc -o daserver daserver.c -lzmq

clean:
	rm daclient daserver
