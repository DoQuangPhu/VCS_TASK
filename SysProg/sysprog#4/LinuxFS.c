#define _GNU_SOURCE
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <dirent.h>

void searchFiles(const char *path, const char *filename) {
    DIR *dir;
    struct dirent *entry;

    if ((dir = opendir(path)) == NULL) {
        perror("opendir");
        exit(EXIT_FAILURE);
    }

    while ((entry = readdir(dir)) != NULL) {
        if (entry->d_type == DT_REG && strcmp(entry->d_name, filename) == 0) {
            printf("File found: %s/%s\n", path, entry->d_name);
        } else if (entry->d_type == DT_DIR &&
                   strcmp(entry->d_name, ".") != 0 &&
                   strcmp(entry->d_name, "..") != 0) {
            char newpath[1024];
            snprintf(newpath, sizeof(newpath), "%s/%s", path, entry->d_name);
            searchFiles(newpath, filename);
        }
    }

    closedir(dir);
}

int main(int argc, char** argv)  {
    
    searchFiles(argv[1], argv[2]);

    return 0;
}
