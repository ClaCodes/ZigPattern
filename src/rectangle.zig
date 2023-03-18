const std = @import("std");
const unqualified_name = @import("circle.zig").unqualified_name;

const rectangleName = unqualified_name(@typeName(Rectangle));

pub const Rectangle = struct{
    pub fn fromCSV(csv: []const u8) RectangleError!Rectangle {
        if (std.mem.eql(u8, csv, rectangleName)) {
            return Rectangle {
            };
        }
        return RectangleError.ParseError;
    }
};

const RectangleError = error {
    ParseError,
};

