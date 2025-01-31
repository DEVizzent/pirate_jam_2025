shader_type canvas_item;

uniform float stat_value = 0.0;
const float MID_STAT_VALUE = 5.0;

void fragment() {
	COLOR = texture(TEXTURE, UV);
	if (COLOR.a > 0.0) {
		COLOR.a = .4;
	}
	if (COLOR.a > 0.0 && stat_value > MID_STAT_VALUE) {
		if (UV.y > 1.0 - ((stat_value-MID_STAT_VALUE)/MID_STAT_VALUE)) {
			COLOR.a = 1.0;
		}
	} else if (UV.y < 1.0 - (stat_value/(MID_STAT_VALUE))) {
		COLOR.a = 0.0;
	}
}