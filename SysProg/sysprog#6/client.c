#include <stdio.h> 
#include <netdb.h> 
#include <stdlib.h> 
#include <string.h> 
#include <sys/socket.h> 
#include <sys/types.h> 
#include <unistd.h> // read(), write(), close()
#include <pthread.h> 
#include <arpa/inet.h>
#define MAX 80 
#define PORT 8080 
#define SA struct sockaddr 


int main(int argc,char *argv[])
{
    int sockfd ;
    struct sockaddr_in servaddr ;
    int i,nread;
    char requestbuf[80];
    char respondbuf[80];
    if( argc <= 2 )
    {
        puts("useage ./client <ip> <port>");
        exit(0);
    }
    int port = atoi(argv[2]);

    sockfd = socket(AF_INET,SOCK_STREAM,0);

    if(sockfd == -1)
    {
        puts("socket failed");
        exit(0);
    }

    memset(&servaddr,0,sizeof(servaddr));
    servaddr.sin_family = AF_INET;
    servaddr.sin_addr.s_addr = inet_addr(argv[1]);
    servaddr.sin_port = htons(port);

    int connfd = connect(sockfd,(struct sockaddr *)&servaddr,sizeof(servaddr));
    if(connfd == -1 )
    {
        puts("failed to connect to the server!!!!!");
        exit(0);
    }
    while (1) {
        memset(requestbuf, 0, sizeof(requestbuf));
        memset(respondbuf, 0, sizeof(respondbuf));

        nread = read(0, requestbuf, sizeof(requestbuf));
        if (nread == -1 || nread == 0) {
            break;
        }

        if (strncmp(requestbuf, "exit", 4) == 0) { // Check if the input is "exit"
            close(connfd);
            return 0;
        }

        write(connfd, requestbuf, strlen(requestbuf));
        read(connfd, respondbuf, sizeof(respondbuf));

        i = 0;
        while (respondbuf[i] != '\n' && respondbuf[i] != '\0') {
            write(1, &respondbuf[i], 1);
            i++;
        }
        write(1, "\n", 1);
    }

    close(connfd);

    return 0;
}