shader_type canvas_item;

uniform float percent: hint_range(0.0, 1.0, 0.1);

void fragment() {
	vec4 sprite_color = texture(TEXTURE, UV);
	vec4 flash_color = mix(sprite_color, vec4(1.0, 1.0, 1.0, sprite_color.a), percent);
	COLOR = flash_color;
}
