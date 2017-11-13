#include <stdio.h>
#include <stdlib.h> /* malloc */
#include <netinet/in.h> /* htons */
#include <sys/socket.h>
#include <unistd.h> /* close */
#include <netinet/ether.h> /* ETH_P_ALL */

#include "packet.h"

#if 0
#include <netinet/ip.h> /* ip header */
#include <netinet/ip_icmp.h> /* icmp header */
#include <netinet/tcp.h> /* tcp header */
#include <netinet/udp.h> /* udp header */
#endif

#define BUF_SIZE 65536


int main(int argc, char* argv[])
{
    int retval = 0;
    int sock = socket(AF_PACKET, SOCK_RAW, htons(ETH_P_ALL));
    if (sock < 0) {
        printf("error opening RAW socket\n");
        retval = -1;
        goto sock_failure;
    }

    unsigned char* buf = (unsigned char*) malloc(BUF_SIZE);
    if (NULL == buf) {
        printf("error: unable to alloc memory\n");
        retval = -1;
        goto malloc_failure;
    }

    struct sockaddr saddr;
    int saddr_size, recv_len;
    while (1) {
        saddr_size = sizeof(saddr);
        recv_len = recvfrom(sock, buf, BUF_SIZE, 0, &saddr, (socklen_t*) &saddr_size);
        if (recv_len < 0) {
            printf("error: recvfrom failed\n");
            retval = -1;
            goto recv_failure;
        }

        parse_pkt(buf, recv_len);
    }

 recv_failure:
    free(buf);

 malloc_failure:
    close(sock);

 sock_failure:
    return retval;
}

