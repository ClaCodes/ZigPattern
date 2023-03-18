const std = @import("std");

const ParseError = error {
    ParseError
};

fn ctoi(c : u8) !u64{
    if(c>=48 and c<=57) return c-48;
    return ParseError.ParseError;
}

pub fn atoi(a : []const u8) !u64{
    // todo is there a library function for this?
    var index:u64 = 0;
    if (a.len == 0) return ParseError.ParseError;
    var i: u64 = try ctoi(a[index]);
    while(index<a.len-1){
        index+=1;
        const n = try ctoi(a[index]);
        i = i*10+n;
    }
    return i;
}

test "ctoi" {
    var j: u8 = 0;
    while(j<=254){
        if(j>='0' and j<='9') {
            try std.testing.expectEqual(ctoi(j), j-'0');
        } else {
            try std.testing.expectError(error.ParseError, ctoi(j));
        }
        j+=1;
    }
}

test "atoi" {
    try std.testing.expectEqual(atoi("0"), 0);
    try std.testing.expectEqual(atoi("000001"), 1);
    try std.testing.expectEqual(atoi("2"), 2);
    try std.testing.expectEqual(atoi("200"), 200);
    try std.testing.expectEqual(atoi("6789"), 6789);
    try std.testing.expectError(error.ParseError, atoi("q3v"));
    try std.testing.expectError(error.ParseError, atoi(""));
    try std.testing.expectError(error.ParseError, atoi("a"));
    try std.testing.expectError(error.ParseError, atoi("23a"));
}

