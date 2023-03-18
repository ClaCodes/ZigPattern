const std = @import("std");

const Shapes = union(enum) {
    Circle: @import("circle.zig").Circle,
    Square: @import("square.zig").Square,
    Rectangle: @import("rectangle.zig").Rectangle,
};

fn fromCSV(csv: []const u8) !Shapes {
    var items = std.mem.split(u8, csv, ",");

    inline for (std.meta.fields(Shapes)) |shape_kind| {
        if(std.mem.eql(u8, items.first(), shape_kind.name)){
            const result = shape_kind.field_type.fromStringIterator(&items);

            if (items.next() != null) return ShapeError.ParseError;

            if (result) |constructed| {
                return @unionInit(Shapes, shape_kind.name, constructed);
            } else |_| {
                return ShapeError.ParseError;
            }
        } else {
            items.reset();
        }
    }
    return ShapeError.ParseError;
}

const ShapeError = error {
    ParseError,
};

test "Shapes valid expect parse ok" {
    const c = try fromCSV("Circle,21");
    try std.testing.expectEqual(c.Circle.radius, 21);

    const r = try fromCSV("Rectangle,100,200");
    try std.testing.expectEqual(r.Rectangle.height, 100);
    try std.testing.expectEqual(r.Rectangle.width, 200);

    const s = try fromCSV("Square,0");
    try std.testing.expectEqual(s.Square.side, 0);
}

test "Shapes invalid expect parse fail" {
    try std.testing.expectError(error.ParseError, fromCSV("8"));
    try std.testing.expectError(error.ParseError, fromCSV(""));
    try std.testing.expectError(error.ParseError, fromCSV("aplskdfjwp"));
    try std.testing.expectError(error.ParseError, fromCSV("Circle"));
    try std.testing.expectError(error.ParseError, fromCSV("Circle,21,"));
    try std.testing.expectError(error.ParseError, fromCSV("Circle,af"));
    try std.testing.expectError(error.ParseError, fromCSV("Circle,21a2"));
    try std.testing.expectError(error.ParseError, fromCSV("Square"));
    try std.testing.expectError(error.ParseError, fromCSV("Square,af"));
    try std.testing.expectError(error.ParseError, fromCSV("Square,21,"));
    try std.testing.expectError(error.ParseError, fromCSV("Square,21a2"));
    try std.testing.expectError(error.ParseError, fromCSV("Rectangle"));
    try std.testing.expectError(error.ParseError, fromCSV("Rectangle,af"));
    try std.testing.expectError(error.ParseError, fromCSV("Rectangle,21,"));
    try std.testing.expectError(error.ParseError, fromCSV("Rectangle,21a2"));
    try std.testing.expectError(error.ParseError, fromCSV("Rectangle,23,af"));
    try std.testing.expectError(error.ParseError, fromCSV("Rectangle,23,21,"));
    try std.testing.expectError(error.ParseError, fromCSV("Rectangle,23,21a2"));
}

