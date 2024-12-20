new_year_date = "2025";

module year() {
    color("white")
    translate([47, 110, 0])
    rotate([0, 0, -26])
    linear_extrude(3) text(new_year_date, size = 20, font = "Arial:style=Bold", halign = "center", valign = "center");
}

module guten_rutsch() {
    color("white")
    translate([24, 71, 0])
    rotate([0, 0, -26])

    linear_extrude(3) text("Guten Rutsch!", size = 8, font = "Arial:style=Bold", halign = "center", valign = "center");
}

$fn=200;

union() {
    import("Hairband_basic_hat_small_1_1.stl");
    year();   
    guten_rutsch();
}
