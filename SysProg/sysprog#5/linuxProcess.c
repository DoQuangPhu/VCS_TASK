#include <unistd.h> 
#include <linux/unistd.h> 
#include<string.h>
#include<stdio.h>
#include<stdlib.h>
#include<fcntl.h>
#include <stdbool.h>
#include <ctype.h>
#define BUF_SIZE 1024
#define NAME_MAX 1024


#define SYS_getdents 0x4e
struct dirent {
    long d_ino;                 /* inode number */
    off_t d_off;                /* offset to next dirent */
    unsigned short d_reclen;    /* length of this dirent */
    char d_name [NAME_MAX+1];   /* filename (null-terminated) */
};





bool isNumber(const char *s) {
    // Check for an empty string or a string with just a sign character
    if (*s == '\0' || (*s == '-' || *s == '+') && *(s + 1) == '\0') {
        return false;
    }

    // Loop through each character in the string
    while (*s != '\0') {
        if (!isdigit(*s)) {
            return false; // If any character is not a digit, return false
        }
        s++; // Move to the next character
    }

    return true; // All characters are digits, hence it's a number
}
void worker(int fd)
{
    char buf[1024];
    int nread;
    struct dirent  *d;
    char name[100];
    char proc[] = "/proc/";
    char cmd[] = "/cmdline\x00";
    char stat[] = "stat\x00";
    int process_id[12];
    char cmdline[100];
    int PARENT_ID[12];
    char statbuf[100];

    int tmp_fd ;
    int tmp_fd2 ;
    char * token;
    puts("ID\tPARENT ID\tCommand line");
    for (;;) 
    {
        nread = syscall(SYS_getdents, fd, buf, BUF_SIZE);
        if (nread == -1)
        {
            puts("getdent");
            exit(0);
        }
        if (nread == 0)
            break;
        for (size_t bpos = 0; bpos < nread;) 
        {
            memset(name,0,sizeof(name));
            memset(PARENT_ID,0,sizeof(PARENT_ID));
            memset(cmdline,0,sizeof(cmdline));
            memcpy(name,proc,sizeof(proc));
            d = (struct dirent *) (buf + bpos);
            if(isNumber(d->d_name))
            {
                if(strcmp(d->d_name,".") && strcmp(d->d_name,".."))
                {   
                    strcat(name,(char*)d->d_name);
                    strcat(name,cmd);
                    tmp_fd = open(name , O_RDONLY);
                    if(tmp_fd >= 0)
                    {
                        read(tmp_fd,cmdline,sizeof(cmdline));
                        memset(name,0,sizeof(name));
                        memcpy(name,proc,sizeof(proc));
                        strcat(name,stat);
                        tmp_fd2 = open(name,O_RDONLY);
                        read(tmp_fd2,statbuf,sizeof(PARENT_ID));
                        token = strtok(statbuf, " "); 
                        int count = 1;
                        while (token != NULL) {
                            if (count == 3) {
                                strcpy(PARENT_ID, token); 
                            } 
                            else if(count == 2)
                            {
                                strcpy(process_id,token);
                            }
                            token = strtok(NULL, " ");
                            count++;
                        }
                        close(tmp_fd);
                        close(tmp_fd2);
                        printf("%s\t%s\t\t%s\n",d->d_name,PARENT_ID,cmdline);
                    }
                }
            }
            bpos += d->d_reclen;
        }
   }
}

int main()
{
    int fd = open("/proc",O_RDONLY | O_DIRECTORY);
    if(fd <= -1)
    {
        puts("failed to open /proc");
        exit(0);
    }

    worker(fd);



    return 0;
}