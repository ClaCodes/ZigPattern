const mem = @import("std").mem;
const parser = @import("parser.zig");
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

        const height = parser.atoi(raw_height) catch return RectangleError.ParseError;
        const width = parser.atoi(raw_width) catch return RectangleError.ParseError;

        return Rectangle {
            .height=height,
            .width=width,
        };
    }
};

const RectangleError = error {
    ParseError,
};

