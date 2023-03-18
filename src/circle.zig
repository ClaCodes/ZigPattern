const mem = @import("std").mem;
const fmt = @import("std").fmt;

pub const Circle = struct{
    radius:u64,

    pub fn fromStringIterator(items: *mem.SplitIterator(u8)) !Circle {

        const raw_radius = items.next() orelse return CircleError.ParseError;

        const radius = fmt.parseInt(u64, raw_radius, 10) catch return CircleError.ParseError;

        return Circle{
            .radius=radius
        };
    }
};

const CircleError = error {
    ParseError,
};
