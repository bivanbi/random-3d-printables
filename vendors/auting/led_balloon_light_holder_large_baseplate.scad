use <led_balloon_light_holder.scad>;

function baseplate_d() = 25; // mm

module led_balloon_light_holder_large_baseplate(d = baseplate_d()) {
    ellypse_outer_d = horizontal_d() + wall_thickness() * 2;
    ellypse_inner_d = horizontal_d();

    offset_x = switch_slot_w() / 2;
    square_x = baseplate_d() / 2 - offset_x;

    union(){
        led_balloon_light_holder();
        rotate_extrude() {
            translate([offset_x, 0]) square([square_x, 1]);
        }
    }
}

led_balloon_light_holder_large_baseplate();
