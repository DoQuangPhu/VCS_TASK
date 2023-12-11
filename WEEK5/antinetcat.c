#include<stdio.h>
#include<stdlib.h>
#include<fcntl.h>
#include <dirent.h>
#include<string.h>

int main()
{
    DIR* procfd = opendir("/proc");
    int fd;
    // if(procfd == -1){puts("failed to open proc!");}
    struct dirent* dent;
    char path[100];
    char cmdline[100];
    while((dent = readdir(procfd)) != NULL)
    {
        memset(cmdline,0,sizeof(cmdline));
        memset(path,0,sizeof(path));
        strcpy(path,"/proc/");
        strcat(path,dent->d_name);
        strcat(path,"/cmdline");
        puts(path);
        if((fd = open(path,O_RDONLY)) != -1)
        {
            read(fd,cmdline,100);
            puts(cmdline);
        }
    }
    return 0;
}