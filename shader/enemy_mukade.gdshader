shader_type canvas_item;

void vertex() {
	// Called for every vertex the material is visible on.
}
	
uniform float time : hint_range(0.0, 10.0);
uniform float wave_amplitude : hint_range(0.0, 5.0);
uniform float move_speed : hint_range(0.0, 5.0);
uniform float scroll_speed : hint_range(0.0, 5.0);
uniform float straight_move_time : hint_range(0.0, 5.0);  // 直進する時間（秒）
uniform float straight_move_speed : hint_range(0.0, 5.0);  // 直進時の移動速度

uniform float blink_speed : hint_range(0.0, 10.0);

void fragment() {
    // メッシュの頂点位置に相当する座標（2DなのでVARYINGの代わりにUVを使う）
    vec2 uv = FRAGCOORD.xy / SCREEN_PIXEL_SIZE;  // テクスチャのUV座標に基づいてスケールする

    vec4 tex_color = texture(TEXTURE, UV);
  	float blink_factor = abs(sin(time * blink_speed));  // 点滅用の因子
    tex_color.g = blink_factor;  // 赤色成分を点滅させる   

    // テクスチャをサンプリング
    COLOR = tex_color;
}	
	// Called for every pixel the material is visible on.


//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
