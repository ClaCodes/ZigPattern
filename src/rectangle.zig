const mem = @import("std").mem;
const fmt = @import("std").fmt;

pub const Rectangle = struct{
    height:u64,
    width:u64,

    pub fn fromStringIterator(items: *mem.SplitIterator(u8)) !Rectangle {

        const raw_height = items.next() orelse return RectangleError.ParseError;
        const raw_width = items.next() orelse return RectangleError.ParseError;

        const height = fmt.parseInt(u64, raw_height, 10) catch return RectangleError.ParseError;
        const width = fmt.parseInt(u64, raw_width, 10) catch return RectangleError.ParseError;

        return Rectangle {
            .height=height,
            .width=width,
        };
    }
};

const RectangleError = error {
    ParseError,
};

