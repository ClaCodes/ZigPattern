pub const Circle = struct{
    radius:i64,
    pub fn fromChar(a: u8) CircleError!Circle {
        if (a=='C') {
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
