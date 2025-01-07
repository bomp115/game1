shader_type canvas_item;

uniform float intensity: hint_range(0.0, 1.0, 0.05) = 0.0;
uniform float scroll_speed;
//const mat4 THRESHOLD_MATRIX = mat4(
		//vec4(1.0 / 17.0,  9.0 / 17.0,  3.0 / 17.0, 11.0 / 17.0),
		//vec4(13.0 / 17.0,  5.0 / 17.0, 15.0 / 17.0,  7.0 / 17.0),
		//vec4(4.0 / 17.0, 12.0 / 17.0,  2.0 / 17.0, 10.0 / 17.0),
		//vec4(16.0 / 17.0,  8.0 / 17.0, 14.0 / 17.0,  6.0 / 17.0)
		//);

//const mat4 THRESHOLD_MATRIX = mat4(
		//vec4(1.0 / 17.0,  9.0 / 17.0,  3.0 / 17.0, 11.0 / 17.0),
		//vec4(13.0 / 17.0,  5.0 / 17.0, 15.0 / 17.0,  7.0 / 17.0),
		//vec4(4.0 / 17.0, 12.0 / 17.0,  2.0 / 17.0, 10.0 / 17.0),
		//vec4(16.0 / 17.0,  8.0 / 17.0, 14.0 / 17.0,  6.0 / 17.0));		

const mat4 THRESHOLD_MATRIX = mat4(
		vec4(11.0 / 117.0,  19.0 / 20.0,  13.0 / 60.0, 11.0 / 17.0),
		vec4(113.0 / 117.0,  15.0 / 17.0, 15.0 / 17.0,  17.0 / 17.0),
		vec4(14.0 / 117.0, 112.0 / 117.0,  12.0 / 17.0, 10.0 / 17.0),
		vec4(116.0 / 117.0,  118.0 / 117.0, 14.0 / 17.0,  16.0 / 17.0)
		);		

void vertex() {
	// Called for every vertex the material is visible on.
	  // Animate Sprite2D moving in big circle around its location
  //VERTEX += vec2(cos(TIME)*100.0, sin(TIME)*100.0);
}

void fragment() {
	
	vec2 uv = UV / TEXTURE_PIXEL_SIZE;
	//float player_dist = (clamp(1.0 - distance(SCREEN_UV / SCREEN_PIXEL_SIZE, player_position / SCREEN_PIXEL_SIZE) * SCREEN_PIXEL_SIZE.x / radius, 0.0, 1.0)) * player_influence * step(0.01, intensity);
	//COLOR.a *= step(0.0, THRESHOLD_MATRIX[int(uv.x) % 4][int(uv.y) % 4] - intensity - player_dist);
	COLOR.a *= step(0.0, THRESHOLD_MATRIX[int(UV.x) % 4][int(uv.y) % 4] - intensity);
	// Called for every pixel the material is visible on.
	
	//float dift_x = 0.075 * sin((10.0 * UV.y) + (2.0 * TIME));
    //COLOR = texture(TEXTURE, vec2(UV.x + dift_x, UV.y));
	
	//vec2 uv_x = UV;
	//uv_x.x += TIME * scroll_speed;
	//uv_x.y += TIME * scroll_speed;
	//vec4 col = texture(TEXTURE,uv_x);
	//COLOR = col;
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}


