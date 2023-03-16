use alloc::vec::Vec;

use super::address::PhysPageNum;


pub struct FrameAllocator{
    pub ppn:PhysPageNum,
}

impl FrameAllocator{
    pub fn new(ppn:PhysPageNum)->Self{
        let arr=ppn.get_bytes_array();
        for i in arr{
            *i=0;
        }
        FrameAllocator{ppn}
    }
}

pub struct StackFrameAllocator{
    current:usize,
    end:usize,
    recycled:Vec<usize>,
}

impl StackFrameAllocator{
    pub fn new()->Self{
        StackFrameAllocator{
            current:0,
            end:0,
            recycled:Vec::new(),
        }
    }

    pub fn alloc(&mut self)->Option<FrameAllocator>{
        if let Some(ppn)=self.recycled.pop(){
           Some(FrameAllocator { ppn: PhysPageNum(ppn) })
        }
        else if self.current==self.end {
            None
        } else {
            let frame = FrameAllocator{ppn:PhysPageNum::from(self.current)};
            self.current+=1;
            Some(frame)
        }
    }

    pub fn dealloc(&mut self,ppn:PhysPageNum){
        self.recycled.push(ppn.0);
    }
}