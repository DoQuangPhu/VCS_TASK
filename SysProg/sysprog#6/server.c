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
#define PORT 4444 
#define SA struct sockaddr 

void * func(void* connfd) 
{ 
    int fd = *((int*)connfd);
    free(connfd);
	char buff[MAX]; 
	int n; 
	for (;;) { 
		bzero(buff, MAX); 

		n = read(fd, buff, sizeof(buff)); 
        if(n == -1 || n == 0)
        {
            puts("client disconnected!!!!!!");
            close(fd);
            pthread_exit(NULL);
            return NULL;
        }
        if (!strncmp("exit", buff, 4) == 0) { 
			printf("Server stopped...\n"); 
			return NULL; 
		} 
		write(fd, buff, sizeof(buff)); 	
	} 
    return NULL;
} 

int main() 
{ 
	int sockfd, connfd, len; 
	struct sockaddr_in servaddr, cli; 

	sockfd = socket(AF_INET, SOCK_STREAM, 0); 
	if (sockfd == -1) { 
		printf("socket creation failed...\n"); 
		exit(0); 
	} 
	else
    {
        printf("Socket successfully created..\n"); 
    }
	bzero(&servaddr, sizeof(servaddr)); 
	servaddr.sin_family = AF_INET; 
	servaddr.sin_addr.s_addr = htonl(INADDR_ANY); 
	servaddr.sin_port = htons(PORT); 

	if ((bind(sockfd, (SA*)&servaddr, sizeof(servaddr))) != 0) { 
		printf("socket bind failed...\n"); 
		exit(0); 
	} 
	else
    {
	    printf("Socket successfully binded..\n"); 
    }

	if ((listen(sockfd, 50)) != 0) { 
		printf("Listen failed...\n"); 
		exit(0); 
	} 
	else
    {
		printf("Server listening..\n"); 
    }
	len = sizeof(cli); 
    while(1)
    {
        pthread_t id;
        connfd = accept(sockfd, (SA*)&cli, &len);
        if (connfd < 0) {
            printf("server accept failed...\n");
            exit(0);
        } else {
            printf("server accepted the client...\n");
        }
        
        printf("client IP: %s client port: %d\n", inet_ntoa(cli.sin_addr), ntohs(cli.sin_port));

        void *tmp_fd = malloc(sizeof(int));
        *((int*)tmp_fd) = connfd  ;
        pthread_create(&id,NULL,func,tmp_fd); 

    } 
}
