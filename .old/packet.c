#include <net/ethernet.h> /* eth header */
#include <netinet/ip.h> /* ip header */

#include "icmp.h"

void parse_pkt(unsigned char *buf, int size)
{
    struct iphdr *iph = (struct iphdr*)(buf + sizeof(struct ethhdr));
    switch (iph->protocol) {
    case 1: /* ICMP protocol */
        icmp(buf + sizeof(struct iphdr) + sizeof(struct ethhdr), size);
        break;

    default:
        break;
    }
}

