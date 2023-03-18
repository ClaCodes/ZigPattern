pub const Square = struct{
    side:i64,
    pub fn fromCSV(a: []const u8) SquareError!Square {
        if (a[0]==@typeName(Square)[0]) {
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
