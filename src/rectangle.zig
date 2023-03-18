pub const Rectangle = struct{
    pub fn fromChar(a: u8) RectangleError!Rectangle {
        if (a=='R') {
            return Rectangle {
            };
        }
        return RectangleError.ParseError;
    }
};

const RectangleError = error {
    ParseError,
};

