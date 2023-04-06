use crate::{
    config::{APP_BASE_ADDRESS, APP_SIZE_LIMIT, KERNEL_STACK_SIZE, MAX_APP_NUM, USER_STACK_SIZE},
    kernel::{boot::p_region_t, thread::arch_tcb_t},
};
#[repr(align(4096))]
#[derive(Copy, Clone)]
pub struct KernelStack {
    pub data: [u8; KERNEL_STACK_SIZE],
}

#[repr(align(4096))]
#[derive(Copy, Clone)]
pub struct UserStack {
    data: [u8; USER_STACK_SIZE],
}

#[link_section = ".kernel_stack"]
pub static KERNEL_STACK: KernelStack = KernelStack {
    data: [0; KERNEL_STACK_SIZE],
};

#[link_section = ".user_stack"]
pub static USER_STACK: [UserStack; MAX_APP_NUM] = [UserStack {
    data: [0; USER_STACK_SIZE],
}; MAX_APP_NUM];

pub static mut THREAD: [usize; MAX_APP_NUM] = [0; MAX_APP_NUM];

impl KernelStack {
    pub fn get_sp(&self) -> usize {
        self.data.as_ptr() as usize + KERNEL_STACK_SIZE
    }
    pub fn push_context(&self, trap_cx: arch_tcb_t) -> usize {
        let trap_cx_ptr = (self.get_sp() - core::mem::size_of::<arch_tcb_t>()) as *mut arch_tcb_t;
        unsafe {
            *trap_cx_ptr = trap_cx;
        }
        trap_cx_ptr as usize
    }
}

impl UserStack {
    pub fn get_sp(&self) -> usize {
        self.data.as_ptr() as usize + USER_STACK_SIZE
    }
}

fn get_base_i(app_id: usize) -> usize {
    APP_BASE_ADDRESS + app_id * APP_SIZE_LIMIT
}

pub fn get_num_app() -> usize {
    extern "C" {
        fn _num_app();
    }
    unsafe { (_num_app as usize as *const usize).read_volatile() }
}

pub fn get_app_data(app_id: usize) -> &'static [u8] {
    extern "C" {
        fn _num_app();
    }
    let num_app_ptr = _num_app as usize as *const usize;
    let num_app = get_num_app();
    let app_start = unsafe { core::slice::from_raw_parts(num_app_ptr.add(1), num_app + 1) };
    assert!(app_id < num_app);
    unsafe {
        core::slice::from_raw_parts(
            app_start[app_id] as *const u8,
            app_start[app_id + 1] - app_start[app_id],
        )
    }
}

pub fn get_app_phys_addr(app_id: usize) -> p_region_t {
    extern "C" {
        fn _num_app();
    }
    let num_app = get_num_app();
    assert!(app_id < num_app);
    p_region_t {
        start: get_base_i(app_id) as usize,
        end: get_base_i(app_id + 1) as usize,
    }
}

pub fn load_apps() {
    extern "C" {
        fn _num_app();
    }
    let num_app_ptr = _num_app as usize as *const usize;
    let num_app = get_num_app();
    let app_start = unsafe { core::slice::from_raw_parts(num_app_ptr.add(1), num_app + 1) };
    unsafe {
        core::arch::asm!("fence.i");
    }
    for i in 0..num_app {
        let base_i = get_base_i(i);
        (base_i..base_i + APP_SIZE_LIMIT)
            .for_each(|addr| unsafe { (addr as *mut u8).write_volatile(0) });
        let src = unsafe {
            core::slice::from_raw_parts(app_start[i] as *const u8, app_start[i + 1] - app_start[i])
        };
        let dst = unsafe { core::slice::from_raw_parts_mut(base_i as *mut u8, src.len()) };
        dst.copy_from_slice(src);
    }
}
