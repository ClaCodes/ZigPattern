pub const Rectangle = struct{
    pub fn fromChar(_: u8) RectangleError!Rectangle {
        return RectangleError.ParseError;
    }
};

const RectangleError = error {
    ParseError,
};

