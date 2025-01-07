shader_type canvas_item;

uniform float scroll_speed:hint_range(0.0, 1.0, 0.1);

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	
vec2 uv = UV;
uv.y -= TIME * scroll_speed;
vec4 col = texture(TEXTURE,uv);
COLOR = col;	
	// Called for every pixel the material is visible on.
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
