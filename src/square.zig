const mem = @import("std").mem;
const parser = @import("parser.zig");
const unqualified_name = @import("circle.zig").unqualified_name;

const square_name = unqualified_name(@typeName(Square));

pub const Square = struct{
    side:u64,

    pub fn fromCSV(csv: []const u8) !Square {

        var items = mem.split(u8, csv, ",");

        const type_name = items.next() orelse return SquareError.ParseError;
        const raw_side = items.next() orelse return SquareError.ParseError;
        if (items.next() != null) return SquareError.ParseError;

        if (!mem.eql(u8, type_name, square_name)) return SquareError.ParseError;

        const side = parser.atoi(raw_side) catch return SquareError.ParseError;

        return Square {
            .side=side
        };
    }
};

const SquareError = error {
    ParseError,
};
