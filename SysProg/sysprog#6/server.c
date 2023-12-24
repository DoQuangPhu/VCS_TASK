#include <netinet/in.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/socket.h>
#include <unistd.h>
#include <pthread.h>
#define SA struct sockaddr



int connectionFD[100];
pthread_t thread_id[100];
int conncount = 0;


struct client{
    int clientfd;
    int * users_fd;
    struct sockaddr_in cli;
};
void *clienthandler(void *vargp)
{
    struct client * c = (struct client *)(vargp);
    char data[1024];

    while(1)
    {
        memset(data,0,sizeof(data));
        int nrecv = recv(c->clientfd,data,sizeof(data),0);
        if(nrecv>0)
        {
            for(int i = 0;i<100;i++)
            {
                if(c->users_fd[i] && c->users_fd[i] != c->clientfd)
                {
                    send(c->users_fd[i],data,nrecv,0);
                }
            }
        }
        else{
            for(int i =0 ;i<100;i++)
            {
                if(c->clientfd == c->users_fd[i])
                {
                    c->users_fd[i] = 0;
                    break;
                }
            }
            close(c->clientfd);
            char clientaddress[INET_ADDRSTRLEN];
            inet_ntop(AF_INET, &(c->cli.sin_addr), clientaddress, INET_ADDRSTRLEN);
            printf("%s %d disconnected!!!\n",clientaddress,ntohs(c->cli.sin_port));
            break;
        }
    }
    return NULL;
}
 

int main(int argc, char const* argv[])
{
    if(argc < 3 )
    {
        puts("useage <ip> <port>");
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

    if((bind(sockfd,(SA*)&servaddr,sizeof(servaddr))) != 0 )
    {
        puts("failed to bind !!!!");
        exit(0);
    }

    if(listen(sockfd,100) != 0 )
    {
        puts("listen failed");
        exit(0);
    }
    char clientaddress[INET_ADDRSTRLEN];
    struct client  c;
    while(1)
    {
        memset(&c,0,sizeof(c));
        memset(&clientaddress,0,sizeof(clientaddress));
        len = sizeof(cli);
        connfd = accept(sockfd,(SA*)&cli,&len);
        connectionFD[conncount] =  connfd;
        c.clientfd = connfd;
        c.users_fd = connectionFD;
        struct client * client = malloc(sizeof(struct client));
        if(client == 0)
        {
            puts("failed to malloc");
            exit(0);
        }
        inet_ntop(AF_INET, &(cli.sin_addr), clientaddress, INET_ADDRSTRLEN);
        printf("Connection from %s %d \n",clientaddress,ntohs(cli.sin_port));
        memcpy(&client->cli,&cli,sizeof(cli));
        client->clientfd = connfd;
        client->users_fd = connectionFD;
        pthread_create(&thread_id[conncount],NULL,clienthandler,(void*)client);
        conncount++;
    }

}