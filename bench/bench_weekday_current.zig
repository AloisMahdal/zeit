const std = @import("std");

export fn weekdayFromDays(days: i32) u8 {
    return @intCast(@mod(days + 4, 7));
}

pub fn main() void {
    const input_count = 65_536;
    var inputs: [input_count]i32 = undefined;
    var state: u32 = 0x12345678;
    for (&inputs) |*days| {
        state = state *% 1_664_525 +% 1_013_904_223;
        const random: i32 = @bitCast(state);
        days.* = if (random > std.math.maxInt(i32) - 4) random - 4 else random;
    }

    var result: u64 = 0;
    const iterations = 1_000_000_000;

    for (0..iterations) |i| {
        const days = inputs[i & (input_count - 1)];
        result +%= weekdayFromDays(days);
    }

    std.debug.print("result: {}\n", .{result});
}
