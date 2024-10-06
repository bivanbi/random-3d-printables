function width() = 13.34; // mm
function bottom_length_1() = 19.0;
function bottom_length_2() = 20.0;


function top_length_1() = 16.5;
function top_length_2() = 17.5;

function thickness_1() = 2.0;
function thickness_2() = 3.0;
function thickness_3() = 4.0;

function shaft_diameter() = 2.0;
function shaft_arm_width_1() = 1.5;
function shaft_arm_width_2() = 2.5;
function shaft_arm_cutaway_depth() = 8.5;

function center_snap_piece_width() = 4.5;


module basic_2d_shape() {
    square_size = 0.1;
    polygon(
        points = [
            [0, 0],
            [0, bottom_length_2()],
            [width(), bottom_length_1()],
            [width(), 0],
            [width() - shaft_arm_width_2(), 0],
            [width() - shaft_arm_width_2(), shaft_arm_cutaway_depth()],
            [width() / 2 + center_snap_piece_width() / 2, shaft_arm_cutaway_depth()],
            [width() / 2 + center_snap_piece_width() / 2, 0],
            [width() / 2 - center_snap_piece_width() / 2, 0],
            [width() / 2 - center_snap_piece_width() / 2, shaft_arm_cutaway_depth()],
            [shaft_arm_width_2(), shaft_arm_cutaway_depth()],
            [shaft_arm_width_2(), 0],
        ]
    );
}

basic_2d_shape();
