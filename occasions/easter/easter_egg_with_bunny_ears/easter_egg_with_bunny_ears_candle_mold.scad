function ear_bump_radius() = 2;
function ear_width() = 15;
function ear_thickness() = 5;
function ear_height() = 50;

function egg_height_without_flat_bottom() = 100;
function egg_width() = 70;
function egg_flat_bottom() = 5;
function egg_height() = egg_height_without_flat_bottom() - egg_flat_bottom();

function ear_displacement_x() = 12;
function ear_displacement_y() = ear_thickness();
function ear_displacement_z() = -14;

function wick_diameter() = 2;

function funnel_r1() = 20;
function funnel_r2() = 5;
function funnel_height() = 10;
function funnel_wick_holder_angle() = 60;

function mold_minimum_wall_thickness() = 5;
function mold_width() = egg_width() + mold_minimum_wall_thickness() * 4 + alignment_cone_r2() * 2;
function mold_depth() = mold_width() / 2;
function mold_height() = egg_height() + ear_height() + funnel_height();
function mold_offset_z() = mold_height() / 2 - funnel_height() + 1;

function alignment_cone_r1() = 3;
function alignment_cone_r2() = 4;
function alignment_cone_height() = 4;

function alignment_cone_column_offset_x() = mold_width() / 2 - mold_minimum_wall_thickness() - alignment_cone_r2();
function alignment_cone_row_1_offset_z() = 0;
function alignment_cone_row_2_offset_z() = egg_height() -10;
function alignment_cone_row_3_offset_z() = mold_height() - funnel_height() - mold_minimum_wall_thickness() - alignment_cone_r2();

function alignment_cone_clearance() = 0.7;
function back_alignment_cone_offset_y() = alignment_cone_clearance() - alignment_cone_height(); // loose fit
function front_alignment_cone_offset_y() = - alignment_cone_height(); // loose fit

module ear_left_half() {
    width = ear_width() / 2 - ear_bump_radius();
    scale_z = ear_height() / ear_width();

    scale([1, 1, scale_z])
        rotate([90, 0, 0])
            rotate_extrude(angle = 180, start = 90)
                translate([0, 0])
                    union() {
                        square([width, ear_thickness()]);
                        translate([width, ear_thickness()]) circle(r = ear_bump_radius());
                    }
}

module ear() {
    translate([0, 0, ear_height() / 2])
        union() {
            ear_left_half();
            mirror([1, 0, 0]) ear_left_half();
        }
}

module half_sphere() {
    rotate([-90, 0, 0])
        rotate_extrude(angle = 180)
            difference() {
                circle(d = egg_width());
                translate([egg_width() / 2, 0]) square([egg_width(), egg_width()], center = true);
            }
}

module flattened_sphere() {
    radius = egg_width() / 2;

    bottom_offset_z = -egg_width() / 2 + egg_flat_bottom() / 2;
    difference() {
        sphere(d = egg_width());
        translate([0, 0, bottom_offset_z]) cube([egg_width(), egg_width(), egg_flat_bottom()], center = true);
    }
}

module egg() {
    radius = egg_width() / 2;
    scale_z = (egg_height_without_flat_bottom() - radius) / radius;

    egg_offset_z = radius - egg_flat_bottom();

    translate([0, 0, egg_offset_z])
        union() {
            flattened_sphere();
            scale([1, 1, scale_z]) half_sphere();
        }
}

module funnel() {
    wick_radius = wick_diameter() / 2 - 0.1;

    wick_holder_angle = 360 - funnel_wick_holder_angle();
    wick_holder_start = 90 + funnel_wick_holder_angle() / 2;

    translate([0, 0, -funnel_height()])
        union() {
            translate([0, 0, - funnel_height() / 2])cylinder(h = funnel_height() * 2, d = wick_diameter());
            rotate_extrude(angle = wick_holder_angle, start = wick_holder_start)
                polygon(points = [
                        [wick_radius, 0],
                        [wick_radius, funnel_height()],
                        [funnel_r2(), funnel_height()],
                        [funnel_r1(), 0]
                    ]);
        }
}

module egg_with_ears() {
    ear_offset_z = egg_height() + ear_displacement_z();

    funnel_offset_z = -funnel_height();
    union() {
        egg();
        translate([ear_displacement_x(), ear_displacement_y(), ear_offset_z]) rotate([0, 20, 0]) ear();
        translate([-ear_displacement_x(), ear_displacement_y(), ear_offset_z]) rotate([0, -20, 0]) ear();
        cylinder(h = egg_height() * 2, d = wick_diameter());
        funnel();
    }
}

module alignment_cone() {
        rotate([-90, 0, 0])
            cylinder(h = alignment_cone_height(), r1 = alignment_cone_r1(), r2 = alignment_cone_r2());
}

module alignment_cone_column() {
    translate([0, 0, alignment_cone_row_1_offset_z()])
        alignment_cone();
    translate([0, 0, alignment_cone_row_2_offset_z()])
        alignment_cone();
    translate([0, 0, alignment_cone_row_3_offset_z()])
        alignment_cone();
}

module alignment_cone_set() {
    translate([alignment_cone_column_offset_x(), 0, alignment_cone_row_1_offset_z()])
        alignment_cone_column();

    translate([-alignment_cone_column_offset_x(), 0, alignment_cone_row_1_offset_z()])
        alignment_cone_column();
}

module mold_back() {
    mold_offset_y = mold_depth() / 2;
    union() {
        difference() {
            translate([0, mold_offset_y, mold_offset_z()]) cube([mold_width(), mold_depth(), mold_height()], center =
            true);
            egg_with_ears();
        }
        translate([0, back_alignment_cone_offset_y(), 0]) alignment_cone_set();
    }
}

module mold_front() {
    mold_offset_y = -mold_depth() / 2;

    rotate([0, 0, 180])
        difference() {
            translate([0, mold_offset_y, mold_offset_z()]) cube([mold_width(), mold_depth(), mold_height()], center =
            true);
            egg_with_ears();
            translate([0, front_alignment_cone_offset_y(), 0]) alignment_cone_set();
        }
}

$fn = 50;

mold_front();
translate([mold_width() + 10, 0, 0]) mold_back();
translate([- mold_width() - 10, 0, 0]) egg_with_ears();

//translate([0, 0, -100]) alignment_cone_set();