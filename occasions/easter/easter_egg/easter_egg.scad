module half_sphere(
    d
) {
    rotate([-90, 0, 0])
        rotate_extrude(angle = 180)
            difference() {
                circle(d = d);
                translate([d / 2, 0]) square([d, d], center = true);
            }
}

module egg(
    h,
    w,
) {
    radius = w / 2;

    scale_z = (h - radius) / radius;
    egg_offset_z = radius;

    translate([0, 0, egg_offset_z])
        union() {
            rotate([180, 0, 0])half_sphere(d = w);
            scale([1, 1, scale_z]) half_sphere(d = w);
        }
}

egg(h = 80, w = 60);
