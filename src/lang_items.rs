use crate::println;
use crate::sbi::shutdown;
use core::panic::PanicInfo;

#[panic_handler]
fn panic(info: &PanicInfo) -> ! {
    match info.location() {
        Some(location) => {
            println!("Panicked at {}:{} {}", location.file(), location.line(), info.message().unwrap());
        }
        None => {
            println!("Panicked: {}", info.message().unwrap());
        }
    };
    shutdown(true)
}
