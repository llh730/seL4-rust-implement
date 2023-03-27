pub struct seL4_MessageInfo_t {
    pub words: [usize; 1],
}

#[inline]
pub fn seL4_MessageInfo_ptr_get_length(ptr: *const seL4_MessageInfo_t) -> usize {
    unsafe {
        let ret = (*ptr).words[0] & 0x7fusize;
        ret
    }
}

#[inline]
pub fn seL4_MessageInfo_ptr_set_length(ptr: *mut seL4_MessageInfo_t, v64: usize) {
    unsafe {
        (*ptr).words[0] &= !0x7fusize;
        (*ptr).words[0] |= v64 & 0x7f;
    }
}

#[inline]
pub fn seL4_MessageInfo_ptr_get_extraCaps(ptr: *const seL4_MessageInfo_t) -> usize {
    unsafe {
        let ret = ((*ptr).words[0] & 0x180usize) >> 7;
        ret
    }
}

#[inline]
pub fn seL4_MessageInfo_ptr_set_extraCaps(ptr: *mut seL4_MessageInfo_t, v64: usize) {
    unsafe {
        (*ptr).words[0] &= !0x180usize;
        (*ptr).words[0] |= (v64 << 7) & 0x180;
    }
}

#[inline]
pub fn seL4_MessageInfo_ptr_get_capsUnwrapped(ptr: *const seL4_MessageInfo_t) -> usize {
    unsafe {
        let ret = ((*ptr).words[0] & 0xe00usize) >> 9;
        ret
    }
}

#[inline]
pub fn seL4_MessageInfo_ptr_set_capsUnwrapped(ptr: *mut seL4_MessageInfo_t, v64: usize) {
    unsafe {
        (*ptr).words[0] &= !0xe00usize;
        (*ptr).words[0] |= (v64 << 9) & 0xe00;
    }
}

#[inline]
pub fn seL4_MessageInfo_ptr_get_label(ptr: *const seL4_MessageInfo_t) -> usize {
    unsafe {
        let ret = ((*ptr).words[0] & 0xfffffffffffff000usize) >> 12;
        ret
    }
}

#[inline]
pub fn seL4_MessageInfo_ptr_set_label(ptr: *mut seL4_MessageInfo_t, v64: usize) {
    unsafe {
        (*ptr).words[0] &= !0xfffffffffffff000usize;
        (*ptr).words[0] |= (v64 << 12) & 0xfffffffffffff000;
    }
}

#[inline]
pub fn seL4_MessageInfo_new(
    label: usize,
    capsUnwrapped: usize,
    extraCaps: usize,
    length: usize,
) -> seL4_MessageInfo_t {
    let seL4_MessageInfo = seL4_MessageInfo_t {
        words: [0
            | (label & 0xfffffffffffffusize) << 12
            | (capsUnwrapped & 0x7usize) << 9
            | (extraCaps & 0x3usize) << 7
            | (length & 0x7fusize) << 0],
    };

    seL4_MessageInfo
}
