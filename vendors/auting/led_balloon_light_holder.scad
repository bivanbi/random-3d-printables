// Mini LED balloon light holder, e.g to stand it on a desk or in an angle. As it is round, it would not
// stand on its own.
// https://www.amazon.de/-/en/gp/product/B0CMZFZDGG

use <../../common/circle_sector.scad>;

function horizontal_d() = 13.7; // mm
function vertical_d() = 12; // it is not a perfect circle, but a bit squished, just like Earth
function wall_thickness() = 1.0; // mm

function switch_slot_w() = 8.5; // mm
function switch_slot_d() = 1.0; // mm

module led_balloon_ellypse(d) {
    ellypse_factor = vertical_d() / horizontal_d();

    scale([1, ellypse_factor]) {
        difference() {
            circle_sector(d = d, a = [-90, 15]);
        }
    }
}

module led_balloon_light_holder() {
    horizonal_r = horizontal_d() / 2;
    vertical_r = vertical_d() / 2;

    ellypse_inner_d = horizontal_d();
    ellypse_outer_d = horizontal_d() + wall_thickness() * 2;

    offset_y = vertical_r + wall_thickness();

    difference() {
        rotate_extrude() {
            difference() {
                hull() {
                    translate([0, offset_y]) led_balloon_ellypse(ellypse_inner_d);
                    translate([7.0, 8]) square(0.1);
                    translate([8, 6]) square(0.1);
                    translate([horizonal_r / 2 + 1, 0]) square(0.1);
                    square(0.1);
                }
                translate([0, offset_y]) led_balloon_ellypse(ellypse_inner_d);
            }
        }
        translate([0, 0, 1]) cube([switch_slot_w(), switch_slot_d(), 4], center = true); // bottom slot for switch

        for (i = [0 : 45 : 135]) {
            rotate([0, 0, i]) translate([0, 0, vertical_r + 0.5]) cube([horizontal_d() + 5, 1, 5], center = true); // top slot for switch
        }
    }
}

$fn = 100; // TODO remove me before commiting
//led_balloon_ellypse(d = horizontal_d());
led_balloon_light_holder();