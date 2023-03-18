pub const Circle = struct{
    radius:i64,
    pub fn fromCSV(a: []const u8) CircleError!Circle {
        if (a[0]==@typeName(Circle)[0]) {
            return Circle{
                .radius=99
            };
        }
        return CircleError.ParseError;
    }
};

const CircleError = error {
    ParseError,
};
