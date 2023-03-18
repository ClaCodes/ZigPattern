pub const Rectangle = struct{
    pub fn fromChar(a: u8) RectangleError!Rectangle {
        if (a==@typeName(Rectangle)[0]) {
            return Rectangle {
            };
        }
        return RectangleError.ParseError;
    }
};

const RectangleError = error {
    ParseError,
};

