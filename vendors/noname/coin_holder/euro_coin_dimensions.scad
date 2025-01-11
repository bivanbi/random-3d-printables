use <../../../common/text.scad>;

function euro_2_diameter() = 25.75;
function euro_2_thickness() = 2.2;

module text_through(
    t, // coin thickness
    text,
    s = 5, // font size
){
    text_carved(t, text, d = t * 2, s = s, halign = "center", valign = "center");
}

// can use this dummy coin to visualize coins in holder models
module euro_2_coin() {
    text_h = euro_2_thickness() + 0.5;

    difference() {
        cylinder(h = euro_2_thickness(), r = euro_2_diameter() / 2);
        text_through(t = euro_2_thickness(), text = "2€", s = 5);
    }
}

euro_2_coin();
