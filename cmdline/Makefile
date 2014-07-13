CFLAGS=-I/usr/local/include -I../libs/cJSON
LDFLAGS=-L/usr/local/lib -lzmq
JSON=../libs/cJSON/cJSON.c

all:	daserver daclient

daclient:	daclient.c
	gcc $(CFLAGS) -o daclient daclient.c $(JSON) $(LDFLAGS)

daserver:	daserver.c
	gcc $(CFLAGS) -o daserver daserver.c $(JSON) $(LDFLAGS)

clean:
	rm daclient daserver
