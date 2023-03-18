const std = @import("std");

const Circle = struct{
    radius:i64,
    pub fn fromChar(a: u8) ShapeError!Circle {
        if (a=='C') {
            return Circle{
                .radius=99
            };
        }
        return ShapeError.ParseError;
    }
};

const Square = struct{
    side:i64,
    pub fn fromChar(a: u8) ShapeError!Square {
        if (a=='S') {
            return Square {
                .side=99
            };
        }
        return ShapeError.ParseError;
    }
};

const Rectangle = struct{
    pub fn fromChar(_: u8) ShapeError!Rectangle {
        return ShapeError.ParseError;
    }
};

const ShapeError = error {
    ParseError,
};

const Shape = union(enum) {
    circle: Circle,
    square: Square,
    rectangle: Rectangle,
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

test "Shape valid expect parse ok" {
    _ = try fromChar('S');
    _ = try fromChar('C');
}
test "Shape invalid expect parse fail" {
    const result = fromChar('8');
    try std.testing.expectError(error.ParseError, result);
}

