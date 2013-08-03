include <MCAD/units.scad>;
include <MCAD/teardrop.scad>;

// Make epsilon bigger than normal so this model looks decent while zoomed out
epsilon = 0.1 * mm;

module headband(d, w, h, a, hd, hs, he, ht, wd, ww) {
	union() {
		difference() {
			cylinder(r = d/2 + w, h = h, $fn = 30);

			translate([0, 0, -epsilon])
			cylinder(r = d/2, h = h + 2*epsilon, $fn = 30);

			translate([-d/2 - w, -d/2 - w, -epsilon])
			cube([d/2 + w - (d/2 + w) * sin(a), d + 2*w, h + 2*epsilon]);

			render(convexity = 5)
			for(theta = [hs:ht:he]) {
				translate([d/2 * cos(theta), d/2 * sin(theta), h/2])
				rotate([0, 0, theta]) {
					intersection() {
						teardrop(radius = hd/2, length = d, angle = 90);

						cube([d, hd, hd], center=true);
					}

					intersection() {
						teardrop(radius = wd/2, length = ww * 2, angle = 90);

						cube([ww * 2, wd, wd], center=true);
					}
				}
			}

			render(convexity = 5)
			for(theta = [-hs:ht:-he]) {
				translate([d/2 * cos(theta), d/2 * sin(theta), h/2])
				rotate([0, 0, theta]) {
					intersection() {
						teardrop(radius = hd/2, length = d, angle = 90);

						cube([d, hd, hd], center=true);
					}

					intersection() {
						teardrop(radius = wd/2, length = ww * 2, angle = 90);

						cube([ww * 2, wd, wd], center=true);
					}
				}
			}
		}

		translate([-(d/2) * sin(a), (d/2) * cos(a), 0])
		rotate([0, 0, a])
		translate([-4*w, 0, 0])
		cube([5*w, w, h]);

		translate([-(d/2) * sin(a), -(d/2) * cos(a), 0])
		rotate([0, 0, -a])
		translate([-4*w, -w, 0])
		cube([5*w, w, h]);
	}
}

headband(d = 140, w = 5, h = 10, a = 27, hd = 0.100 * inch, hs = 42, he = 66, ht = 12, wd = 8, ww = 2);
