    .section .text.entry # Put all the text data in the .entry section
    .global _start
_start:                  # The address of _start 
    la sp, boot_stack_top           # Assign 100 to x1
    call rust_main

    .global boot_stack
boot_stack:
    .space 4096 * 16
    .global boot_stack_top
boot_stack_top:
