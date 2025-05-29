// gcc -nostdlib -static -o hello hello.c

//void _start() {
void my() {
    const char msg[] = "hello\n";
    long syscall_number = 1;  // syscall write
    long fd = 1;              // stdout
    long len = sizeof(msg) - 1;

    __asm__ volatile (
        "movq %0, %%rax\n"   // syscall number
        "movq %1, %%rdi\n"   // file descriptor
        "movq %2, %%rsi\n"   // message pointer
        "movq %3, %%rdx\n"   // message length
        "syscall\n"
        :
        : "r"(syscall_number), "r"(fd), "r"(msg), "r"(len)
        : "%rax", "%rdi", "%rsi", "%rdx"
    );

    // exit syscall (number 60)
    __asm__ volatile (
        "movq $60, %%rax\n"
        "xor %%rdi, %%rdi\n"
        "syscall\n"
        :
        :
        : "%rax", "%rdi"
    );
}
