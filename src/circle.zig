const mem = @import("std").mem;

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
        var items = mem.split(u8, csv, ",");
        if (mem.eql(u8, items.first(), circleName)) {
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
