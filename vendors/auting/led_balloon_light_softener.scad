function led_diameter() = 4.85; // mm
function led_height() = 4.10;
function wall_thickness() = 0.5;
function top_slope() = 2.0; // give the top a little slope, makes it easier to print without support

module led_ballon_light_softener() {
    led_r = led_diameter() / 2;

    rotate_extrude()
    polygon(
        points = [
            [led_r, 0],
            [led_r, led_height()],
            [0, led_height() + top_slope()],
            [0, led_height() + wall_thickness() + top_slope()],
            [led_r + wall_thickness(), led_height() + wall_thickness()],
            [led_r + wall_thickness(), 0]
        ]
    );
}

led_ballon_light_softener();