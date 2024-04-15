#![allow(unused)]
/// use sbi call to putchar in console (qemu uart handler)
use core::arch::asm;
use sbi_rt::{system_reset, NoReason, Shutdown, SystemFailure};

const SBI_SET_TIMER: usize = 0;
const SBI_CONSOLE_PUTCHAR: usize = 1;
const SBI_CONSOLE_GETCHAR: usize = 2;
const SBI_CLEAR_IPI: usize = 3;
const SBI_SEND_IPI: usize = 4;
const SBI_REMOTE_FENCE_I: usize = 5;
const SBI_REMOTE_SFENCE_VMA: usize = 6;
const SBI_REMOTE_SFENCE_VMA_ASID: usize = 7;
const SBI_SHUTDOWN: usize = 8;

#[inline(always)]
fn sbi_call(which: usize, arg0: usize, arg1: usize, arg2: usize) -> usize {
    let mut ret;
    unsafe {
        asm!(
            "ecall",
            inlateout("x10") arg0 => ret,
            in("x11") arg1,
            in("x12") arg2,
            in("x17") which,
        );
    }
    ret
}

pub fn console_putchar(c: usize) {
    // sbi_rt::console_write_byte(c);
    #[allow(deprecated)]
    sbi_rt::legacy::console_putchar(c);
}

/// use sbi call to getchar from console (qemu uart handler)
// pub fn console_getchar() -> usize {
//     #[allow(deprecated)]
//     sbi_rt::console_getchar()
// }

/// use sbi call to shutdown the kernel
pub fn shutdown(failure: bool) -> ! {
    sbi_call(SBI_SHUTDOWN, 0, 0, 0);
    panic!("It should shutdown!");
    // if !failure {
    //     system_reset(Shutdown, NoReason);
    // } else {
    //     system_reset(Shutdown, SystemFailure);
    // }
    // unreachable!()
}
