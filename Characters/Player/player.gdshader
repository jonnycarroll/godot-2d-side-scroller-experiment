shader_type canvas_item;

uniform vec3 color: source_color = vec3(1);
uniform float alpha: hint_range(0.0, 1.0, 0.1) = 0;

void fragment() {
	vec4 tex = texture(TEXTURE, UV);
	float current_a = tex.a;
	vec4 target_color = mix(tex, vec4(color, current_a), alpha);
	COLOR = target_color;
}
