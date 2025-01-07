module circle_sector(r = 0, d = 0, a = [0, 180]) {
    r = max(r, d / 2);
    sector_r = r / cos(180 / $fn);
    step = -360 / $fn;

    points = concat([[0, 0]],
        [for(a = [a[0] : step : a[1] - 360])
            [sector_r * cos(a), sector_r * sin(a)]
        ],
        [[sector_r * cos(a[1]), sector_r * sin(a[1])]]
    );

    difference() {
        circle(r);
        polygon(points);
    }
}

module half_circle(r = 0, d = 0) {
    r = max(r, d / 2);

    intersection() {
        circle(r = r);
        translate([r, 0]) square(r * 2, center = true);
    }
}

circle_sector();
