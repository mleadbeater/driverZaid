CFLAGS=-I/usr/local/include -I../libs/cJSON
LDFLAGS=-L/usr/local/lib -lzmq
JSON=../libs/cJSON/cJSON.c

all:	daserver daclient

daclient:	daclient.c
	gcc $(CFLAGS) -o daclient $(LDFLAGS) daclient.c $(JSON)

daserver:	daserver.c
	gcc $(CFLAGS) -o daserver $(LDFLAGS) daserver.c $(JSON) 

clean:
	rm daclient daserver
