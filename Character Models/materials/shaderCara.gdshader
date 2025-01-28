shader_type spatial;
uniform sampler2D piel_text;
uniform sampler2D expr_text;
uniform vec2 ojos = vec2(0.0,0.0);
uniform vec2 cejas = vec2(0.0,0.25);
uniform vec2 boca = vec2(0.0,0.5);

void fragment() {
	vec2 UVojos = UV2 + ojos;
	vec2 UVcejas = UV2 + cejas;
	vec2 UVboca = UV2 + boca;
	vec3 textura_piel_final = texture(piel_text, UV).rgb * (1.0 - texture(expr_text, UVojos).a) * (1.0 - texture(expr_text, UVcejas).a) * (1.0 - texture(expr_text, UVboca).a);
	vec3 textura_ojos = texture(expr_text, UVojos).rgb * texture(expr_text, UVojos).a;
	vec3 textura_cejas = texture(expr_text, UVcejas).rgb * texture(expr_text, UVcejas).a;
	vec3 textura_boca = texture(expr_text, UVboca).rgb * texture(expr_text, UVboca).a;
	vec3 textura_expre_final = textura_ojos + textura_boca + textura_cejas;
	ALBEDO = textura_piel_final + textura_expre_final;
}
