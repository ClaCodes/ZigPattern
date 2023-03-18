const std = @import("std");

pub fn unqualified_name(name : []const u8) []const u8{
    var index = name.len-1;
    while(name[index]!='.'){
        index-=1;
    }
    return name[index+1..];
}

const circleName = unqualified_name(@typeName(Circle));

pub const Circle = struct{
    radius:i64,
    pub fn fromCSV(csv: []const u8) CircleError!Circle {
        if (std.mem.eql(u8, csv, circleName)) {
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
