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
    _ = try fromCSV("Square");
    _ = try fromCSV("Circle");
    _ = try fromCSV("Rectangle");
    _ = try fromCSV("Circle,2,3,");
    _ = try fromCSV("Rectangle,df;jlw   2");
    _ = try fromCSV("Square,");
}

test "Shape invalid expect parse fail" {
    try std.testing.expectError(error.ParseError, fromCSV("8"));
    try std.testing.expectError(error.ParseError, fromCSV(""));
    try std.testing.expectError(error.ParseError, fromCSV("aplskdfjwp"));
}

