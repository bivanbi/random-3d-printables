function body_width() = 13.34; // mm, without the shafts on the shaft arm

function body_bottom_length_1() = 19.0; // the end tip is a slightly angled wedge shape
function body_bottom_length_2() = 20.0;
function body_top_length_1() = 16.5;
function body_top_length_2() = 17.5;

function tip_height() = 3.0;
function tip_length_1() = 10.0;
function tip_length_2() = 11.0;

function shaft_diameter() = 2.0;

function shaft_arm_height() = 4.0; // this is the most thick part
function shaft_arm_bottom_width() = 1.5;
function shaft_arm_top_width() = 2.5; // shaft arm has an L shape
function shaft_arm_bottom_length_1() = 9.0;
function shaft_arm_bottom_length_2() = 10.0;

function spring_arm_height() = 2.0;
function spring_arm_width() = 4.5;
function spring_arm_cutaway_depth() = 8.5;
function spring_arm_depth_top_1() = 10.0;
function spring_arm_reduced_height_depth_bottom_2() = 10.0; // the end tip is thicker than the spring arm
function spring_arm_reduced_height_depth_top_2() = 11.0; // but thinner than the shaft arm

module basic_2d_shape() {
    square_size = 0.1;
    polygon(
        points = [
            [0, 0],
            [0, body_bottom_length_2()],
            [body_width(), body_bottom_length_1()],
            [body_width(), 0],
            [body_width() - shaft_arm_top_width(), 0],
            [body_width() - shaft_arm_top_width(), spring_arm_cutaway_depth()],
            [body_width() / 2 + spring_arm_width() / 2, spring_arm_cutaway_depth()],
            [body_width() / 2 + spring_arm_width() / 2, 0],
            [body_width() / 2 - spring_arm_width() / 2, 0],
            [body_width() / 2 - spring_arm_width() / 2, spring_arm_cutaway_depth()],
            [shaft_arm_top_width(), spring_arm_cutaway_depth()],
            [shaft_arm_top_width(), 0],
        ]
    );
}

basic_2d_shape();
