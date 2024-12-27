function kindle_width() = 120;
function kindle_height() = 170;
function kindle_thickness_with_case() = 14;
function kindle_bottom_center_cutout_width() = 50;

function stand_wall_thickness() = 5;
function stand_wall_thickness() = 5;

function stand_foot_depth() = 50;
function stand_foot_arch_a() = 160;
function stand_foot_arch_r() = 10;
function stand_height() = 100;

module arch(r = stand_foot_arch_r(), t = stand_wall_thickness(), h = kindle_width(), a = stand_foot_arch_a()) {
       rotate_extrude(angle = a)
            translate([r, 0, 0])
                square([t, h]);
}

module stand_foot_arch_half() {
    half_section_width = (kindle_width() - kindle_bottom_center_cutout_width()) / 2;
    offset_x = stand_foot_depth();
    offset_y = stand_foot_arch_r() + stand_wall_thickness();

    round_end_offset_x = offset_x + stand_foot_arch_r() + stand_wall_thickness() / 2;
    union() {
        translate([offset_x, offset_y, 0]) rotate([0, 0, - stand_foot_arch_a()]) arch(h = half_section_width);
        translate([round_end_offset_x, offset_y, 0])
            cylinder(d = stand_wall_thickness(), h = half_section_width);
    }
}

module stand_foot_arch() {
    half_section_width = (kindle_width() - kindle_bottom_center_cutout_width()) / 2;

    right_side_offset_z = kindle_width() - half_section_width;

    stand_foot_arch_half();
    translate([0, 0, right_side_offset_z]) stand_foot_arch_half();
}

module stand_foot() {
    union() {
        cube([stand_foot_depth(), stand_wall_thickness(), kindle_width()]);
        stand_foot_arch();
    }
}

module stand_vertical_support() {
    union() {
        cube([stand_wall_thickness(), stand_height(), kindle_width()]);
        round_top();
    }
}
module round_top() {
    translate([stand_wall_thickness() / 2, stand_height(), 0])
        cylinder(d = stand_wall_thickness(), h = kindle_width());

}

module kindle_simple_stand() {
    union() {
        stand_vertical_support();
        stand_foot();
    }
}

kindle_simple_stand();
