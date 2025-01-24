shader_type spatial;
uniform sampler2D second_texture;
uniform vec2 face_animation = vec2(0.0, 0.0);
void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	vec2 correctUV = UV2+face_animation;
	ALPHA = texture(second_texture, correctUV).a;
	ALBEDO = texture(second_texture, correctUV).rgb;
}

//void light() {
	// Called for every pixel for every light affecting the material.
	// Uncomment to replace the default light processing function with this one.
//}
