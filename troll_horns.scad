include <MCAD/units.scad>;
include <MCAD/polyholes.scad>;

include <horn_parts.scad>;
include <horn_defs.scad>;

troll = karkat;
hole_diameter = 1.7;
hole_depth = 14;
scale_factor = 1.00;
preview = false;

$fn = 40;

module horn_from_array(array, hole_diameter, hole_depth, scale_factor) {
	difference() {
		union() {
			// Thin disks for most of the slices
			for (i = [0: len(array) - 3]) {
				hull() {
					disk_from_array(array[i], scale_factor);
					disk_from_array(array[i+1], scale_factor);
				}
			}

			// A sphere for the top
			hull() {
				disk_from_array(array[len(array)-3], scale_factor);
				disk_from_array(array[len(array)-2], scale_factor);
				sphere_from_array(array[len(array)-1], scale_factor);
			}
		}

		translate([0, 0, -epsilon])
		polyhole(d = hole_diameter, h = hole_depth + epsilon);
	}
}

if (preview) {
	translate([-30, 0, 0])
	rotate([0, -45, 0])
	horn_from_array(troll, hole_diameter, hole_depth, scale_factor);

	translate([30, 0, 0])
	mirror([1, 0, 0])
	rotate([0, -45, 0])
	horn_from_array(troll, hole_diameter, hole_depth, scale_factor);
} else if (compare) {
	translate([-20, 0, 0])
	horn_from_array(troll, hole_diameter, hole_depth, scale_factor);

	translate([20, 0, 0])
	horn_from_array(compare, hole_diameter, hole_depth, scale_factor);
} else {
	horn_from_array(troll, hole_diameter, hole_depth, scale_factor);
}
