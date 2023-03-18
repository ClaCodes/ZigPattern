const mem = @import("std").mem;
const parser = @import("parser.zig");
const unqualified_name = @import("circle.zig").unqualified_name;

const squareName = unqualified_name(@typeName(Square));

pub const Square = struct{
    side:u64,
    pub fn fromCSV(csv: []const u8) SquareError!Square {
        var items = mem.split(u8, csv, ",");
        const t = items.next() orelse return SquareError.ParseError;
        const r = items.next() orelse return SquareError.ParseError;
        if (items.next() != null) return SquareError.ParseError;
        const ar = parser.atoi(r) catch return SquareError.ParseError;
        if (mem.eql(u8, t, squareName)) {
            return Square {
                .side=ar
            };
        }
        return SquareError.ParseError;
    }
};

const SquareError = error {
    ParseError,
};
