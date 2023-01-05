extern char _bss[];
extern char _bss_end[];

/*
 * Clear the BSS segment
 */
extern void print_for_c(void);
void clear_bss(void)
{
    print_for_c();
    char *start = _bss;
    char *end = _bss_end;
    while (start < end) {
        *start = 0;
        start++;
    }
}