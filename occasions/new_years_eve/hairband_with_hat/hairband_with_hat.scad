next_year = "2026";
next_year_font_size = "2026";

message = "Happy New Year!";
message_font_size = 7.5;

//message = "Guten Rutsch!";
//message_font_size = 8;

module year(
    y, // next year
    f, // font
    s // font size
) {
    color("white")
    translate([47, 110, 0])
    rotate([0, 0, -26])
    linear_extrude(3) text(y, size = s, font = f, halign = "center", valign = "center");
}

module message(
    m, // message
    f, // font
    s // font size
) {
    color("white")
    translate([24, 71, 0])
    rotate([0, 0, -26])

    linear_extrude(3) text(m, size = s, font = f, halign = "center", valign = "center");
}

$fn=50;

union() {
    import("Hairband_basic_hat_small_1_1.stl");
    year(y = next_year, s = 20);
    message(m = message, s = message_font_size);
}
