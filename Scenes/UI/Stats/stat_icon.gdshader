shader_type canvas_item;

uniform float stat_value = 0.0;
const float MID_STAT_VALUE = 5.0;
uniform vec4 base_color : source_color = vec4(1.0, 1.0, 1.0, 1.0);
uniform vec4 shine_color : source_color = vec4( 1.0, 1.0, 1.0, 1.0 );

void fragment() {
	COLOR = texture(TEXTURE, UV);
	COLOR.rgb = base_color.rgb;
	if (stat_value > MID_STAT_VALUE) {
		if (UV.y > 1.0 - ((stat_value-MID_STAT_VALUE)/MID_STAT_VALUE)) {
			COLOR = vec4(shine_color.rgb, COLOR.a);
		}
	} else if (UV.y < 1.0 - (stat_value/(MID_STAT_VALUE))) {
		COLOR.a = 0.0;
	}
}