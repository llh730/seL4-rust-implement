//test cspace functions

use core::cell::RefCell;

use alloc::rc::Rc;

use crate::kernel::object::{cap::*,structures::*};
use crate::{kernel::object::structures::{mdb_node_t, cap_t, cte_t}, println};

pub fn test_cspace(){
    let cap1=Rc::new(RefCell::new(cap_t{words:[1,2]}));
    let newCap=Rc::new(RefCell::new(cap_t{words:[3,4]}));
    let node1=Rc::new(RefCell::new(mdb_node_t::default()));
    let srcSlot=Rc::new(RefCell::new(cte_t{cap:cap1.clone(),cteMDBNode:node1}));
    let destSlot=Rc::new(RefCell::new(cte_t::default()));
    // println!("srcSlot before first insert:{:?}", srcSlot); 
    cteInsert(newCap.clone(),srcSlot.clone(),destSlot.clone());
    println!("srcSlot after first insert:{:?}", srcSlot);
    println!("destSlot after first insert:{:?}", destSlot);

    //cteInsert test 1
    // println!("----------------------------------------------------------------");
    // let newCap2=Rc::new(RefCell::new(cap_t{words:[5,6]}));
    // let destSlot2=Rc::new(RefCell::new(cte_t::default()));
    // cteInsert(newCap2.clone(),destSlot.clone(),destSlot2.clone());
    // println!("srcSlot after second insert:{:?}", srcSlot);
    // println!("destSlot after second insert:{:?}", destSlot);
    // println!("destSlot2 after second insert:{:?}", destSlot2);
    // println!("srcSlot get Next :{} and destSlot2 get prev:{}",mdb_node_get_mdbNext(srcSlot.borrow().cteMDBNode.clone()),mdb_node_get_mdbPrev(destSlot2.borrow().cteMDBNode.clone()));
    
    //cteInsert test 2
    // println!("----------------------------------------------------------------");
    // let newCap2=Rc::new(RefCell::new(cap_t{words:[5,6]}));
    // let destSlot2=Rc::new(RefCell::new(cte_t::default()));
    // cteInsert(newCap2.clone(),srcSlot.clone(),destSlot2.clone());
    // println!("srcSlot after second insert:{:?}", srcSlot);
    // println!("destSlot after second insert:{:?}", destSlot);
    // println!("destSlot2 after second insert:{:?}", destSlot2);
    // println!("srcSlot get Next :{} and destSlot get prev:{}",mdb_node_get_mdbNext(srcSlot.borrow().cteMDBNode.clone()),mdb_node_get_mdbPrev(destSlot.borrow().cteMDBNode.clone()));

    //cteMove test 
    // println!("----------------------------------------------------------------");
    // let newCap2=Rc::new(RefCell::new(cap_t{words:[5,6]}));
    // let destSlot2=Rc::new(RefCell::new(cte_t::default()));
    // cteMove(newCap2.clone(),srcSlot.clone(),destSlot2.clone());
    // println!("srcSlot after move:{:?}", srcSlot);
    // println!("destSlot2 after move:{:?}", destSlot2);

    //cteSwapForDelete test 
    // println!("----------------------------------------------------------------");
    // let cap2=Rc::new(RefCell::new(cap_t{words:[5,6]}));
    // let newCap2=Rc::new(RefCell::new(cap_t{words:[7,8]}));
    // let node2=Rc::new(RefCell::new(mdb_node_t::default()));
    // let srcSlot2=Rc::new(RefCell::new(cte_t{cap:cap2.clone(),cteMDBNode:node2}));
    // let destSlot2=Rc::new(RefCell::new(cte_t::default()));
    // cteInsert(newCap2.clone(),srcSlot2.clone(),destSlot2.clone());
    // println!("srcSlot2 after first insert:{:?}", srcSlot2);
    // println!("destSlot2 after first insert:{:?}", destSlot2);
    // capSwapForDelete(srcSlot.clone(), srcSlot2.clone());
    // println!("srcSlot after swap:{:?}", srcSlot);
    // println!("destSlot after swap:{:?}", destSlot);
    // println!("srcSlot2 after swap:{:?}", srcSlot2);
    // println!("destSlot2 after swap:{:?}", destSlot2);
    
    //cteDelete test
    // println!("----------------------------------------------------------------");
    // let cap2=cap_cnode_cap_new(1,1,1,2);
    // let node2=Rc::new(RefCell::new(mdb_node_t::default()));
    // let srcSlot2=Rc::new(RefCell::new(cte_t{cap:cap2.clone(),cteMDBNode:node2}));
    // let destSlot2=Rc::new(RefCell::new(cte_t::default()));
    // let newCap2=cap_cnode_cap_new(2,2,2,2);
    // // println!("srcSlot before first insert:{:?}", srcSlot);
    // cteInsert(newCap2.clone(),srcSlot2.clone(),destSlot2.clone());
    // // emptySlot(destSlot2.clone(),cap_null_cap_new());
    // cteDelete(destSlot2.clone(),true);
    // // assert!(cteDelete(destSlot2.clone(),true)==exception_t::EXCEPTION_NONE);
    // // println!("{}",cteDelete(destSlot.clone(),true) as usize);
    // println!("destSlot2 after delete:{:?}", destSlot2);
}