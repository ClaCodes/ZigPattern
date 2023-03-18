const mem = @import("std").mem;
const unqualified_name = @import("circle.zig").unqualified_name;

const squareName = unqualified_name(@typeName(Square));

pub const Square = struct{
    side:i64,
    pub fn fromCSV(csv: []const u8) SquareError!Square {
        var items = mem.split(u8, csv, ",");
        if (mem.eql(u8, items.first(), squareName)) {
            return Square {
                .side=99
            };
        }
        return SquareError.ParseError;
    }
};

const SquareError = error {
    ParseError,
};
