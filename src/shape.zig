const std = @import("std");

const Shape = union(enum) {
    circle: @import("circle.zig").Circle,
    square: @import("square.zig").Square,
    rectangle: @import("rectangle.zig").Rectangle,
};

fn fromCSV(line: []const u8) !Shape {
    inline for (std.meta.fields(Shape)) |field| {
        const result = field.field_type.fromCSV(line);
        if (result) |constructed| {
            return @unionInit(Shape, field.name, constructed);
        } else |_| {}
    }
    return ShapeError.ParseError;
}

const ShapeError = error {
    ParseError,
};

test "Shape valid expect parse ok" {
    const c = try fromCSV("Circle,21");
    try std.testing.expectEqual(c.circle.radius, 21);

    const r = try fromCSV("Rectangle,100,200");
    try std.testing.expectEqual(r.rectangle.height, 100);
    try std.testing.expectEqual(r.rectangle.width, 200);

    const s = try fromCSV("Square,0");
    try std.testing.expectEqual(s.square.side, 0);
}

test "Shape invalid expect parse fail" {
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

