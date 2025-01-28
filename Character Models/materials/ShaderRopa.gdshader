shader_type spatial;
uniform sampler2D textura_piel;
uniform sampler2D textura_ropa;

void fragment() {
	vec3 textura_final;
	vec3 textura_ropa_final = texture(textura_ropa, UV2).rgb * texture(textura_ropa, UV2).a;
	vec3 textura_piel_final = texture(textura_piel, UV).rgb * (1.0 - texture(textura_ropa, UV2).a);
	ALBEDO = textura_piel_final + textura_ropa_final;
}
