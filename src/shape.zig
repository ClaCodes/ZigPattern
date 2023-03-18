const std = @import("std");

const Shape = union(enum) {
    circle: @import("circle.zig").Circle,
    square: @import("square.zig").Square,
    rectangle: @import("rectangle.zig").Rectangle,
};

fn fromChar(char: u8) !Shape {
    inline for (std.meta.fields(Shape)) |field| {
        const result = field.field_type.fromChar(char);
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
    _ = try fromChar('s');
    _ = try fromChar('c');
    _ = try fromChar('r');
}
test "Shape invalid expect parse fail" {
    const result = fromChar('8');
    try std.testing.expectError(error.ParseError, result);
}

