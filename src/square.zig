pub const Square = struct{
    side:i64,
    pub fn fromChar(a: u8) SquareError!Square {
        if (a=='S') {
            return Square {
                .side=99
            };
        }
        return SquareError.ParseError;
    }
};

const SquareError = error {
    ParseError,
};
