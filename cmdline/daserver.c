//  Hello World server

#include <zmq.h>
#include <stdio.h>
#include <unistd.h>
#include <string.h>
#include <assert.h>
#include <errno.h>
#include <cJSON.h>

int main (void)
{
    //  Socket to talk to clients
    void *context = zmq_ctx_new ();
    void *responder = zmq_socket (context, ZMQ_REP);
    int rc = zmq_bind (responder, "tcp://*:34231");
    assert (rc == 0);

    while (1) {
        char buffer [100];
        int n = zmq_recv (responder, buffer, 100, 0);
	if (n) {
		buffer[n] = 0;
	        printf ("Received %s\n", buffer);
        	zmq_send (responder, "World", 5, 0);
	}
	else {
		fprintf(stderr, "zmq_recv: %d\n", zmq_strerror(errno));
	}
    }
    return 0;
}
