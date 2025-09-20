#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main(int argc, char *argv[]) {
    if (argc == 1) {
        printf("Nexus Package Manager\n");
        printf("Type 'nexus help' for a list of commands.\n");
        return 0;
    }

    char *command = argv[1];
    char *httpserver = "http://somepackagewebsite.com";

    if (strcmp(command, "install") == 0) {
        if (argc > 2) {
            char *packageName = argv[2];
            printf("Preparing to install '%s'...\n", packageName);

            char download_command[1024]; // Fixed buffer size; we'll discuss security improvements
#ifdef _WIN32
            snprintf(download_command, sizeof(download_command), "wget %s/%s", httpserver, packageName);
#elif defined(__linux__) || defined(__FreeBSD__)
            snprintf(download_command, sizeof(download_command), "./busybox wget %s/%s", httpserver, packageName);
#else
            fprintf(stderr, "Error: Unsupported OS. Only Windows, Linux, and FreeBSD are supported.\n");
            return 1;
#endif
            system(download_command);
        } else {
            printf("Error: You must specify a package to install.\n");
            printf("Example: nexus install my-package\n");
        }
    } else if (strcmp(command, "help") == 0 || strcmp(command, "-h") == 0) {
        printf("Available Commands:\n");
        printf("  install <package>   Installs a package.\n");
        printf("  remove <package>    Removes a package.\n");
        printf("  help                Shows this message.\n");
    } else {
        printf("Error: Unknown command '%s'\n", command);
        printf("Type 'nexus help' for a list of commands.\n");
    }

    return 0;
}
