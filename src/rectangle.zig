const mem = @import("std").mem;
const fmt = @import("std").fmt;
const unqualified_name = @import("circle.zig").unqualified_name;

const rectangle_name = unqualified_name(@typeName(Rectangle));

pub const Rectangle = struct{
    height:u64,
    width:u64,

    pub fn fromCSV(csv: []const u8) !Rectangle {

        var items = mem.split(u8, csv, ",");

        const type_name = items.next() orelse return RectangleError.ParseError;
        const raw_height = items.next() orelse return RectangleError.ParseError;
        const raw_width = items.next() orelse return RectangleError.ParseError;
        if (items.next() != null) return RectangleError.ParseError;

        if (!mem.eql(u8, type_name, rectangle_name)) return RectangleError.ParseError;

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

