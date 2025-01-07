use <../../../common/circle_sector.scad>;

function glass_thickness() = 8; // mm
function glass_clearance() = 0.5;

function thickness() = 5;
function width() = 15;
function total_height() = 320;

function towel_hook_d() = 70;
function glass_wall_hook_overhang() = 20;

function towel_hook_height() = 20;

module glass_wall_hook() {
    overhang_x = width();
    overhang_y = thickness();
    overhang_z = glass_wall_hook_overhang();

    overhang_offset_x = 0;
    overhang_offset_y = - thickness() - glass_thickness() - glass_clearance();
    overhang_offset_z = total_height() - glass_wall_hook_overhang();

    top_x = width();
    top_y = glass_thickness() + 2 * thickness() + glass_clearance();
    top_z = thickness();

    top_offset_x = 0;
    top_offset_y = - thickness() - glass_thickness() - glass_clearance();
    top_offset_z = total_height() - thickness();

    union() {
        translate([overhang_offset_x, overhang_offset_y, overhang_offset_z]) cube([overhang_x, overhang_y, overhang_z]);
        translate([top_offset_x, top_offset_y, top_offset_z]) cube([top_x, top_y, top_z]);
    }
}

module vertical_bar() {
    x = width();
    y = thickness();
    z = total_height() - towel_hook_d() / 2;

    offset_x = 0;
    offset_y = 0;
    offset_z = towel_hook_d() / 2;

    translate([offset_x, offset_y, offset_z]) cube([x, y, z]);
}

module towel_hook_profile() {
    hull() {
        translate([thickness() / 2, thickness() / 2]) circle(r = thickness() / 2);
        translate([thickness() / 2, width() - thickness() / 2]) circle(r = thickness() / 2);
    }
}

module towel_hook_curve(
    a, // angle, e.g. 180
    r = 0, // radius, eg. towel_hook_d() / 2 - thickness()
)
{
    rotate([90, 180, 90])
    rotate_extrude(angle=a)
        translate([r, 0, 0])
            towel_hook_profile();
}

module towel_hook_round_end() {
    r = thickness() / 2;

    circle_offset_x = max(0, width() / 2 - thickness() / 2);
    circle_offset_y = thickness() / 2;

    rotate([90, 0, 00])
        rotate_extrude(angle=180)
                hull() {
                    translate([0, 0]) square([0.1, thickness()]);
                    translate([circle_offset_x, circle_offset_y]) half_circle(r = r);
                }
}

module towel_hook() {
    hook_offset_x = 0;
    hook_offset_y = towel_hook_d() / 2;
    hook_offset_z = towel_hook_d() / 2;

    hook_r = towel_hook_d() / 2 - thickness();

    round_top_offset_x = width() / 2;
    round_top_offset_y = towel_hook_d();
    round_top_offset_z = towel_hook_d() / 2;

    union() {
        translate([hook_offset_x, hook_offset_y, hook_offset_z]) towel_hook_curve(a = 180, r = hook_r);
        translate([round_top_offset_x, round_top_offset_y, round_top_offset_z]) towel_hook_round_end();
    }
}

module glass_wall_towel_hanger() {
    union() {
        glass_wall_hook();
        vertical_bar();
        towel_hook();
    }
}

$fn = 50;
rotate([0, -90, 0]) glass_wall_towel_hanger();
