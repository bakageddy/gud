#include <errno.h>
#include <stdio.h>
#include <string.h>
#include <sys/socket.h>
#include <sys/types.h>
#include <netinet/in.h>
#include <arpa/inet.h>

int main(void) {
	int skt = socket(AF_UNIX, SOCK_STREAM, PF_INET);
	if (skt == -1) {
		return 1;
	}

	struct sockaddr_in addr = {0};
	addr.sin_family = AF_INET;
	addr.sin_port = htons(80);
	inet_pton(AF_INET, "127.0.0.1", &addr.sin_addr);

	int res = bind(skt, (struct sockaddr*) &addr, sizeof(addr));
	if (res == -1) {
		printf("Bind Error: %s\n", strerror(errno));
		return 1;
	}
	return 0;
}
