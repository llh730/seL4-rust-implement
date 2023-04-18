
#[macro_export]
macro_rules! BIT {
    ($e:expr) => {
        {
            1usize<<$e
        }
    }
}


#[macro_export]
macro_rules! MASK {
    ($e:expr) => {
        {
             (1usize << $e) - 1usize
        }
    }
}


#[macro_export]
macro_rules! ROUND_DOWN {
    ($n:expr,$b:expr) => {
        {
            ((($n) >> ($b)) << ($b))
        }
    }
}


#[macro_export]
macro_rules! ROUND_UP {
    ($n:expr,$b:expr) => {
        {
            ((((($n) - 1usize) >> ($b)) + 1usize) << ($b))
        }
    }
}

#[macro_export]
macro_rules! IS_ALIGNED {
    ($n:expr,$b:expr) => {
        {
            $n&MASK!($b)==0
        }
    }
}