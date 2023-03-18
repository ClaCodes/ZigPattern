const mem = @import("std").mem;
const fmt = @import("std").fmt;

pub const Square = struct{
    side:u64,

    pub fn fromStringIterator(items: *mem.SplitIterator(u8)) !Square {

        const raw_side = items.next() orelse return SquareError.ParseError;

        const side = fmt.parseInt(u64, raw_side, 10) catch return SquareError.ParseError;

        return Square {
            .side=side
        };
    }
};

const SquareError = error {
    ParseError,
};
