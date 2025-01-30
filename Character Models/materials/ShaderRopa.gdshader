shader_type spatial;
uniform sampler2D textura_piel;
uniform sampler2D textura_ropa;
uniform sampler2D text_metal;
uniform vec3 tono_piel = vec3(1.0,1.0,1.0);

void fragment() {
	vec3 textura_final;
	vec3 textura_ropa_final = texture(textura_ropa, UV2).rgb * texture(textura_ropa, UV2).a;
	vec3 textura_piel_final = texture(textura_piel, UV).rgb * (1.0 - texture(textura_ropa, UV2).a) * tono_piel;
	ALBEDO = textura_piel_final + textura_ropa_final;
	METALLIC = texture(text_metal, UV2).r * texture(textura_ropa, UV2).a;
	ROUGHNESS = 1.0 - (texture(text_metal, UV2).r) * texture(textura_ropa, UV2).a * 0.8;
}
