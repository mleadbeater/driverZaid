//  Hello World server

#include <zmq.h>
#include <stdio.h>
#include <unistd.h>
#include <string.h>
#include <assert.h>
#include <errno.h>
#include <cJSON.h>
#include <stdlib.h>

/* indicator keys */

const char *keys[] = { "RoadQuality", "BikeLanes", "AccidentHotSpot",
            "Info", "PublicTransport", "KnownRadar", "AnimalCross",
			"Caution", "CarPark", "Crossing", "RoadBlock" };

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
		cJSON *response = 0;
		cJSON *indicators = 0;
		buffer[n] = 0;
		printf ("Received %s\n", buffer);
		response = cJSON_CreateObject();
		cJSON_AddStringToObject(response, "limit", "50");
		indicators = cJSON_CreateArray();
		if (random() % 2) {
			cJSON_AddItemToArray(indicators, cJSON_CreateString(keys[2]));
			cJSON_AddItemToArray(indicators, cJSON_CreateString(keys[5]));	
		}
		else {
			cJSON_AddItemToArray(indicators, cJSON_CreateString(keys[9]));	
		}
		cJSON_AddItemToArray(indicators, cJSON_CreateString(keys[1]));	
		cJSON_AddItemToObject(response, "indicators", indicators);
		char *res = cJSON_Print(response);
		cJSON_Delete(response);
		zmq_send (responder, res, strlen(res), 0);
		free(res);
	}
	else {
		fprintf(stderr, "zmq_recv: %s\n", zmq_strerror(errno));
	}
    }
    return 0;
}
