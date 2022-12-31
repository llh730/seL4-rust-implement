
#[macro_export]
macro_rules! BIT{
    ($n:expr)=>{1<<($n)};
}


#[macro_export]
macro_rules! MASK{
    ($n:expr)=>{BIT!($n)-1};
}

#[macro_export]
macro_rules! IS_ALIGNED {
    ($n:expr,$b:expr) => {
        !((n) & MASK(b))
    };
}

