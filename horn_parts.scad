function slice_translate(slice) = slice[0];
function slice_rotate(slice) = slice[1];
function slice_radius(slice) = slice[2];

module sphere_from_array(slice, scale_factor) {
	translate(slice_translate(slice) * scale_factor)
	rotate(slice_rotate(slice))
	sphere(r = slice_radius(slice) * scale_factor);
}

module disk_from_array(slice, scale_factor) {
	translate(slice_translate(slice) * scale_factor)
	rotate(slice_rotate(slice))
	cylinder(r = slice_radius(slice) * scale_factor,
		h = epsilon * scale_factor);
}
