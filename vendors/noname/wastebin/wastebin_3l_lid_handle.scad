use <../../../common/circle_sector.scad>;

function lid_outer_d() = 168.4;
function lid_inner_d() = 161.8;
function lid_edge_curviture_d() = 3.5;
function lid_curviture_clips_wall_thickness() = 1.5;
function lid_curviture_clips_extrude_angle() = 10;
function lid_curviture_clips_overhang() = lid_outer_d() - lid_inner_d() + 3;

function lid_round_edge_wall_thickness() = 2;
function lid_round_d() = 16;

module lid_curviture_clips() {
    offset_x = lid_inner_d() / 2 - lid_curviture_clips_wall_thickness();
    offset_y = lid_edge_curviture_d() / 2 + lid_curviture_clips_wall_thickness();

    outer_r = lid_outer_d() / 2;
    lid_edge_curviture_r = lid_edge_curviture_d() / 2;

    clip_outer_d = lid_edge_curviture_d() + lid_curviture_clips_wall_thickness() * 2;
    clip_inner_d = lid_edge_curviture_d();

    clip_outer_r = clip_outer_d / 2;

    translate([- outer_r - lid_curviture_clips_overhang() / 2, 0, 0])
    rotate([0, 0, - lid_curviture_clips_extrude_angle() / 2])
    rotate_extrude(angle = lid_curviture_clips_extrude_angle())
    union() {
        translate([offset_x, offset_y])
            difference() {
            circle(d = clip_outer_d);
            circle(d = clip_inner_d);
            translate([0, - lid_edge_curviture_r]) square([10, lid_curviture_clips_wall_thickness() * 1.5]);

                difference() {
                    translate([- clip_outer_r, 0]) circle(clip_outer_d);
                    translate([- clip_outer_r - lid_curviture_clips_wall_thickness() * 0.9, 0])circle(clip_outer_d);
                }
            }
        translate([offset_x, 0]) square([lid_curviture_clips_overhang(), lid_curviture_clips_wall_thickness()]);
    }
}

module lid_round_edge() {
    linear_extrude(height = lid_round_edge_wall_thickness())
    difference() {
        circle_sector(d = lid_round_d(), a = [-100, 100]);
        translate([ - lid_outer_d() / 2, 0]) circle(d = lid_outer_d());
    }
}

module lid_handle() {
    union() {
        lid_curviture_clips();
        translate([-1 , 0, 0]) lid_round_edge();
    }
}

lid_handle();
