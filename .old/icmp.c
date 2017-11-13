#include <stdio.h>
#include <linux/icmp.h>

void icmp(unsigned char *buf, int size)
{
    struct icmphdr* icmp = (struct icmphdr*)buf;
    switch (icmp->type) {
    case 0: /* ECHO Reply */
        printf("ICMP Echo Reply!\n");
        break;

    default:
        break;
    }
}
