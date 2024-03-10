shader_type canvas_item;

uniform sampler2D bars_texture : repeat_enable;
uniform sampler2D gradient;
uniform float scale;
uniform float scroll;

void fragment() {
	// Called for every pixel the material is visible on.
	float gradient_point = texture(bars_texture, scale * UV + vec2(0, scroll) * TIME).r;
	vec4 gradient_color = texture(gradient, vec2(gradient_point));
	COLOR = gradient_color;
}