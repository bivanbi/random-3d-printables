use <glass_wall_towel_hanger.scad>;

function clamp_clearance() = 2;

module clamp() {
    outer_r = towel_hook_d() / 2 - thickness();
    inner_r = outer_r - clamp_clearance() - thickness();

    inner_offset_z = towel_hook_d() / 2;

    clamp_upper_offset_x = 0;
    clamp_upper_offset_y = towel_hook_d() / 2;
    clamp_upper_offset_z = towel_hook_d() + inner_r;

    round_top_offset_x = width() / 2;
    round_top_offset_y = 2 * thickness() + clamp_clearance() + 2 * inner_r;
    round_top_offset_z = towel_hook_d() / 2;

    union() {
        translate([clamp_upper_offset_x, clamp_upper_offset_y, clamp_upper_offset_z])
            towel_hook_curve(a = 90, r = towel_hook_d() / 2 - thickness());

        translate([clamp_upper_offset_x, clamp_upper_offset_y, inner_offset_z])
        rotate([-90, 0, 0]) towel_hook_curve(a = -90, r = inner_r);

        translate([round_top_offset_x, round_top_offset_y, round_top_offset_z]) rotate([180, 0, 0]) towel_hook_round_end();

    }
}

module glass_wall_towel_hanger_with_clamp(

) {
    union() {
        glass_wall_towel_hanger();
        clamp();
    }
}

$fn = 100;
rotate([0, -90, 0]) glass_wall_towel_hanger_with_clamp();
