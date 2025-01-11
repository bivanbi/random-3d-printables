function minimum_wall_thickness() = 1; // mm
function clearance() = 1;

function total_width(d, t) = d + 2 * t;
function total_length(l, t) = l + 2 * t;

module horizontal_coin_holder(
  d, // coin diameter
  l, // compartment inner length
  t = minimum_wall_thickness(), // minimum_wall_thickness
) {
    d = d + clearance();
    r = d / 2;
    outer_width = total_width(d = d, t = t);
    outer_length = total_length(l = l, t = t);
    outer_d = d + 2 * minimum_wall_thickness();

    cylinder_offset_x = t;
    cylinder_offset_y = t + r;
    cylinder_offset_z = t + r;

    difference() {
        cube([outer_length, outer_d, outer_d / 2]);
        translate([cylinder_offset_x, cylinder_offset_y, cylinder_offset_z]) rotate([0, 90, 0]) cylinder(d = d, h = l);
    }
}

module multi_horizontal_coin_holder(
  d, // coin diameter
  l, // compartment inner length
  t = minimum_wall_thickness(), // minimum_wall_thickness
  c = 2, // compartment count
) {
    union()
    for(i = [0:c - 1]) {
        offset_y = total_width(d = d, t = t) * i;
        translate([0, offset_y, 0]) horizontal_coin_holder(d = d, l = l, t = t);
    }
}

multi_horizontal_coin_holder(d = 25, l = 60, c = 3);
