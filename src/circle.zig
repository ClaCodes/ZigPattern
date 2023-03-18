pub const Circle = struct{
    radius:i64,
    pub fn fromChar(a: u8) CircleError!Circle {
        if (a==@typeName(Circle)[0]) {
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
