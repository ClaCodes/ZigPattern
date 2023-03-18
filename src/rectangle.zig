pub const Rectangle = struct{
    pub fn fromCSV(a: []const u8) RectangleError!Rectangle {
        if (a[0]==@typeName(Rectangle)[0]) {
            return Rectangle {
            };
        }
        return RectangleError.ParseError;
    }
};

const RectangleError = error {
    ParseError,
};

