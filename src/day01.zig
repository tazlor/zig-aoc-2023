const std = @import("std");
const Allocator = std.mem.Allocator;
const List = std.ArrayList;
const Map = std.AutoHashMap;
const StrMap = std.StringHashMap;
const BitSet = std.DynamicBitSet;

const util = @import("util.zig");
const gpa = util.gpa;

const data = @embedFile("data/day01.txt");

fn updateFirstIndex(num: i64, num_text: []const u8, buffer: []const u8, first: *usize, first_digit: *i64) void {
    if (num_text.len > buffer.len) {
        return;
    }
    if (std.mem.indexOfPosLinear(u8, buffer, 0, num_text)) |index| {
        if (index < first.*) {
            first.* = index;
            first_digit.* = num;
        }
    }
}

fn updateLastIndex(num: i64, num_text: []const u8, buffer: []const u8, last: *usize, last_digit: *i64) void {
    if (num_text.len > buffer.len) {
        return;
    }
    if (std.mem.lastIndexOfLinear(u8, buffer, num_text)) |index| {
        if (index > last.*) {
            last.* = index;
            last_digit.* = num;
        }
    }
}

pub fn main() !void {
    var lines = List([]const u8).init(std.heap.page_allocator);
    defer lines.deinit();
    var readIter = std.mem.tokenize(u8, data, "\n");
    var sum: i64 = 0;
    while (readIter.next()) |line| {
        var first: usize = line.len;
        var first_digit: i64 = 0;
        var last: usize = 0;
        var last_digit: i64 = 0;
        if (std.mem.indexOfAny(u8, line, "0123456789")) |first_num| {
            first = first_num;
            first_digit = try parseInt(i64, line[first .. first + 1], 10);
        }
        if (std.mem.lastIndexOfAny(u8, line, "0123456789")) |last_num| {
            last = last_num;
            last_digit = try parseInt(i64, line[last .. last + 1], 10);
        }
        updateFirstIndex(1, "one", line, &first, &first_digit);
        updateFirstIndex(2, "two", line, &first, &first_digit);
        updateFirstIndex(3, "three", line, &first, &first_digit);
        updateFirstIndex(4, "four", line, &first, &first_digit);
        updateFirstIndex(5, "five", line, &first, &first_digit);
        updateFirstIndex(6, "six", line, &first, &first_digit);
        updateFirstIndex(7, "seven", line, &first, &first_digit);
        updateFirstIndex(8, "eight", line, &first, &first_digit);
        updateFirstIndex(9, "nine", line, &first, &first_digit);
        updateFirstIndex(0, "zero", line, &first, &first_digit);
        updateLastIndex(1, "one", line, &last, &last_digit);
        updateLastIndex(2, "two", line, &last, &last_digit);
        updateLastIndex(3, "three", line, &last, &last_digit);
        updateLastIndex(4, "four", line, &last, &last_digit);
        updateLastIndex(5, "five", line, &last, &last_digit);
        updateLastIndex(6, "six", line, &last, &last_digit);
        updateLastIndex(7, "seven", line, &last, &last_digit);
        updateLastIndex(8, "eight", line, &last, &last_digit);
        updateLastIndex(9, "nine", line, &last, &last_digit);
        updateLastIndex(0, "zero", line, &last, &last_digit);
        sum += first_digit * 10;
        sum += last_digit;
        print("{}{}\n", .{ first_digit, last_digit });
    }
    print("{}\n", .{sum});
}

// Useful stdlib functions
const tokenizeAny = std.mem.tokenizeAny;
const tokenizeSeq = std.mem.tokenizeSequence;
const tokenizeSca = std.mem.tokenizeScalar;
const splitAny = std.mem.splitAny;
const splitSeq = std.mem.splitSequence;
const splitSca = std.mem.splitScalar;
const indexOf = std.mem.indexOfScalar;
const indexOfAny = std.mem.indexOfAny;
const indexOfStr = std.mem.indexOfPosLinear;
const lastIndexOf = std.mem.lastIndexOfScalar;
const lastIndexOfAny = std.mem.lastIndexOfAny;
const lastIndexOfStr = std.mem.lastIndexOfLinear;
const trim = std.mem.trim;
const sliceMin = std.mem.min;
const sliceMax = std.mem.max;

const parseInt = std.fmt.parseInt;
const parseFloat = std.fmt.parseFloat;

const print = std.debug.print;
const assert = std.debug.assert;

const sort = std.sort.block;
const asc = std.sort.asc;
const desc = std.sort.desc;

// Generated from template/template.zig.
// Run `zig build generate` to update.
// Only unmodified days will be updated.
