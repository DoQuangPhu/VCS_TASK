#include <netinet/in.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/socket.h>
#include <unistd.h>
#include <pthread.h>
#define SA struct sockaddr

int serverfd;

void * recvroutine(void *agrp)
{
    char data[1024];
    while(1)
    {
        memset(&data,0,sizeof(data));
        int nrecv = recv(serverfd,data,sizeof(data),0);
        data[nrecv-1] = '\x00';
        puts(data);
    }
    return NULL;
}

int main(int argc,char* argv[])
{
    if(argc != 3)
    {
        puts("useage: ./client <ip> <port>");
        exit(0);
    }

    int sockfd ,connfd ,len;
    struct sockaddr_in servaddr,cli;

    sockfd = socket(AF_INET,SOCK_STREAM,0);
    if(sockfd == -1)
    {
        puts("socket create failed");
        exit(0);
    }    

    memset(&servaddr,0,sizeof(servaddr));
    servaddr.sin_family = AF_INET;
    inet_pton(AF_INET, argv[1], &(servaddr.sin_addr));
    servaddr.sin_port = htons(atoi(argv[2])); 

    // servaddr.sin_family = AF_INET;
    // servaddr.sin_addr.s_addr = inet_addr("127.0.0.1");
    // servaddr.sin_port = htons(PORT);
 
    // connect the client socket to server socket
    if (connect(sockfd, (SA*)&servaddr, sizeof(servaddr))!= 0) {
        printf("connection with the server failed...\n");
        exit(0);
    }
    serverfd = sockfd;
    pthread_t thread_id;
    pthread_create(&thread_id,NULL,recvroutine,NULL);

    //send routine
    char data[1024];
    while(1)
    {
        memset(&data,0,sizeof(data));
        int nread = read(0,data,sizeof(data));
        if(nread <= 0)
        {
            break;
        }
        send(sockfd,data,nread,0);
    }
    close(sockfd);
    puts("closeed connection");
    return 0;
}