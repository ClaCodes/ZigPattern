const mem = @import("std").mem;
const parser = @import("parser.zig");

pub fn unqualified_name(name : []const u8) []const u8{
    // todo is there a library function for this?
    var index = name.len-1;
    while(name[index]!='.'){
        index-=1;
    }
    return name[index+1..];
}

const circleName = unqualified_name(@typeName(Circle));

pub const Circle = struct{
    radius:u64,
    pub fn fromCSV(csv: []const u8) CircleError!Circle {
        var items = mem.split(u8, csv, ",");
        const t = items.next() orelse return CircleError.ParseError;
        const r = items.next() orelse return CircleError.ParseError;
        const ar = parser.atoi(r) catch return CircleError.ParseError;
        if (mem.eql(u8, t, circleName)) {
            return Circle{
                .radius=ar
            };
        }
        return CircleError.ParseError;
    }
};

const CircleError = error {
    ParseError,
};
