#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <unistd.h>

const char *msg = "Hello World!\n";

int main()
{
   write(1, msg, strlen(msg)); //write message to 1(STDOUT)

   exit(0);

}
