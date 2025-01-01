use <../../../common/circle_sector.scad>;
function body_width() = 13.34; // mm, without the shafts on the shaft arm

function body_bottom_length_1() = 19.0; // the end tip is a slightly angled wedge shape
function body_bottom_length_2() = 20.0;
function body_top_length_1() = 16.5;
function body_top_length_2() = 17.5;
function body_paralelogram_factor() = 1.0; // mm, the body has paralelogram shape, the top is offset by this amount

function tip_height() = 3.0;
function tip_bottom_length_1() = 10.0;
function tip_bottom_length_2() = 11.0;
function tip_wedge_factor() = 2.0;
function body_wedge_factor() = 1.0;

function tip_top_length_1() = tip_bottom_length_1() - tip_wedge_factor();
function tip_top_length_2() = tip_bottom_length_2() - tip_wedge_factor();

function body_offset_y() = 9.0;

module main_body_with_tip() {
    // counter-clockwise order, bottom 4 points, then top 4 points
    CubePoints = [
            // bottom
            [0, body_paralelogram_factor(), 0], // 0, bottom - left-down corner
            [body_width(), 0, 0], //1 bottom - right-down corner
            [body_width(), tip_bottom_length_1(), 0], //2 bottom - right-up corner
            [0, tip_bottom_length_2(), 0], //3 bottom - left-up corner

            // top
            [0, body_paralelogram_factor() + body_wedge_factor(), tip_height()], //4 top - left-down corner
            [body_width(), body_wedge_factor(), tip_height()], //5 top - right-down corner
            [body_width(), tip_top_length_1(), tip_height()], //6 top - right-up corner
            [0, tip_top_length_2(), tip_height()] //7 top - left-up corner
        ];

    CubeFaces = [
            [0, 1, 2, 3], // bottom
            [4, 5, 1, 0], // front
            [7, 6, 5, 4], // top
            [5, 6, 2, 1], // right
            [6, 7, 3, 2], // back
            [7, 4, 0, 3] // left
        ];

    polyhedron(CubePoints, CubeFaces);
}

function spring_arm_height() = 2.0; // this is the thinnest part

function spring_arm_center_width() = 4.5;
function spring_arm_side_width() = 2.5;

function spring_arm_cutaway_depth() = 8.5;
function spring_arm_cutaway_width() = 1.92;
function spring_arm_depth_top_1() = 10.0;
function spring_arm_length_short() = 10.0;
function spring_arm_length_long() = 11.0;
function spring_arm_end_curve_r() = spring_arm_height();

module spring_arm() {
    total_width = spring_arm_side_width() * 2 + spring_arm_cutaway_width() * 2 + spring_arm_center_width();
    echo("total_width = ", total_width);
    l_short = spring_arm_length_short() - spring_arm_end_curve_r();
    l_long = spring_arm_length_long() - spring_arm_end_curve_r();
    cutaway_l = spring_arm_cutaway_depth() - spring_arm_end_curve_r();

    center_spring_offset_x = spring_arm_side_width() + spring_arm_cutaway_width();
    side_spring_offset_x = total_width - spring_arm_side_width();

    union() {
        translate([0, spring_arm_height(), 0]) linear_extrude(spring_arm_height())
            polygon(
            points = [
                    [0, 0],
                    [0, l_long],
                    [total_width, l_long],
                    [total_width, 0],
                    [total_width - spring_arm_side_width(), 0],
                    [total_width - spring_arm_side_width(), cutaway_l],
                    [total_width / 2 + spring_arm_center_width() / 2, cutaway_l],
                    [total_width / 2 + spring_arm_center_width() / 2, 0],
                    [total_width / 2 - spring_arm_center_width() / 2, 0],
                    [total_width / 2 - spring_arm_center_width() / 2, cutaway_l],
                    [spring_arm_side_width(), cutaway_l],
                    [spring_arm_side_width(), 0],
                ]
            );

        translate([0, spring_arm_end_curve_r(), spring_arm_end_curve_r()]) rotate([-90, 0, -90]) linear_extrude(
        spring_arm_side_width()) circle_sector(r = spring_arm_end_curve_r(), a = [0, 90]);
        translate([center_spring_offset_x, spring_arm_end_curve_r(), spring_arm_end_curve_r()]) rotate([-90, 0, -90])
            linear_extrude(spring_arm_center_width()) circle_sector(r = spring_arm_end_curve_r(), a = [0, 90]);
        translate([side_spring_offset_x, spring_arm_end_curve_r(), spring_arm_end_curve_r()]) rotate([-90, 0, -90])
            linear_extrude(spring_arm_side_width()) circle_sector(r = spring_arm_end_curve_r(), a = [0, 90]);
    }
}

function shaft_diameter() = 1.88;
function shaft_length() = 2.0;
function shaft_offset_from_bottom() = 0.9;
function shaft_arm_height() = 4.0; // this is the thickest part
function shaft_arm_width() = 1.5;
function shaft_arm_length_short() = 9.0;
function shaft_arm_length_long() = 10.0;
function shaft_arm_end_top_curve_r() = 2.0;
//function shaft_arm_end_bottom_curve_r() = 1.0;
function shaft_arm_end_offset_from_spring_arm_end() = 0.5;
function shaft_arm_chop_off_height() = 1; // mm

module shaft_arm(l = shaft_arm_length_short(), shaft_side = "left") {
    translate([0, shaft_arm_end_top_curve_r() + shaft_arm_end_offset_from_spring_arm_end(), 0])
    rotate([90, 0, 90])
    union() {
        linear_extrude(shaft_arm_width()) {
            hull() {
                translate([0, shaft_arm_end_top_curve_r()]) circle(r = shaft_arm_end_top_curve_r());
                translate([l - shaft_arm_height() / 2, 0]) square(shaft_arm_height());
            }
        }
        if (shaft_side == "left") {
            difference() {
                translate([0, shaft_diameter() / 2 + shaft_offset_from_bottom(), - shaft_length()]) cylinder(d=shaft_diameter(), h=shaft_length());
                cube(shaft_diameter() * 2);
            }
        } else {
            translate([0, shaft_diameter() / 2 + shaft_offset_from_bottom(), shaft_arm_width()]) cylinder(d=shaft_diameter(), h=shaft_length());
        }
    }
}

module foot_left_without_text() {
    union() {
        shaft_arm();
        spring_arm();
        shaft_arm(l = shaft_arm_length_long(), shaft_side = "left");
        translate([body_width() - shaft_arm_width(), 0 ,0]) shaft_arm(l = shaft_arm_length_short(), shaft_side = "right");
        translate([0, body_offset_y(), 0]) main_body_with_tip();
    }
}

module foot_right_without_text() {
    mirror([1, 0, 0]) foot_left_without_text();
}

$fn = 50;
color("red") foot_left_without_text();
color("green") translate([50, 0, 0]) foot_right_without_text();
