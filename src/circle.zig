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

const circle_name = unqualified_name(@typeName(Circle));

pub const Circle = struct{
    radius:u64,

    pub fn fromCSV(csv: []const u8) !Circle {

        var items = mem.split(u8, csv, ",");

        const type_name = items.next() orelse return CircleError.ParseError;
        const raw_radius = items.next() orelse return CircleError.ParseError;
        if (items.next() != null) return CircleError.ParseError;

        if (!mem.eql(u8, type_name, circle_name)) return CircleError.ParseError;

        const radius = parser.atoi(raw_radius) catch return CircleError.ParseError;

        return Circle{
            .radius=radius
        };
    }
};

const CircleError = error {
    ParseError,
};
