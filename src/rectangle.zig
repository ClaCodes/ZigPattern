const mem = @import("std").mem;
const unqualified_name = @import("circle.zig").unqualified_name;

const rectangleName = unqualified_name(@typeName(Rectangle));

pub const Rectangle = struct{
    pub fn fromCSV(csv: []const u8) RectangleError!Rectangle {
        var items = mem.split(u8, csv, ",");
        if (mem.eql(u8, items.first(), rectangleName)) {
            return Rectangle {
            };
        }
        return RectangleError.ParseError;
    }
};

const RectangleError = error {
    ParseError,
};

