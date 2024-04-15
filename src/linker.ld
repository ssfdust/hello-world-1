OUTPUT_ARCH(riscv)                  /* 指明架构结构 */
ENTRY(_start)                       /* 指明入口为_start */
BASE_ADDRESS = 0x80200000;          /* 定义变量 */

SECTIONS
{
    . = BASE_ADDRESS;               /* 指明入口为0x80200000 rustsbi跳转处 */

    skernel = .;                    /* 指明kernel开始处 */

    stext = .;                      /* 指明text入口处 */
    .text : {                       /* 定义.text结构，将我们之前定义的.text.entry置于.text入口 */
        *(.text.entry)              /* 拼接.text.entry */
        *(.text .text.*)            /* 拼接其他所有的.text段 */
    }
    . = ALIGN(4K);                  /* 内存对齐，避免内核bug */
    etext = .;                      /* 指明text段结束 */

    srodata = .;                    /* 指明rodata段开始 */
    .rodata : {                     /* 定义rodata段内容 */
        *(.srodata .srodata.*)      /* 经过验证srodata与rodata位置可以调换 */
        *(.rodata .rodata.*)        /* 拼接rodata与srodata */
    }
    . = ALIGN(4K);                  /* 内存对齐，避免内核bug */
    erodata = .;                    /* 指明rodata段结束 */

    sdata = .;                       /* 指明data段开始 */
    .data : {                        /* 定义data段内容 */
        *(.sdata .sdata.*)           /* 经过验证sdata与data位置可以调换 */
        *(.data .data.*)             /* 拼接data与sdata */
    }
    . = ALIGN(4K);                   /* 内存对齐，避免内核bug */
    edata = .;                       /* 指明data段结束 */

    .bss : {                         /* 定义bss段内容 */
        *(.bss.stack)                /* 拼接bss.stack */
        sbss = .;                    /* 指明bss段开始 */
        *(.sbss .sbss.*)             /* 经过验证sbss与bss位置可以调换 */
        *(.bss .bss.*)               /* 拼接bss与sbss */
    }
    . = ALIGN(4K);                   /* 内存对齐，避免内核bug */
    ebss = .;                        /* 指明bss段结束 */
    ekernel = .;                     /* 指明kernel结束 */

    /DISCARD/ : {
        *(.eh_frame)
    }
}
