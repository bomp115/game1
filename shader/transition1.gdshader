shader_type canvas_item;

void vertex() {
	// Called for every vertex the material is visible on.
}

//uniform float transition_progress : hint_range(0, 1) = 0.0;
//uniform vec3 fade_color = vec3(1.0, 9.0, 8.0);
//uniform float pixel_size = 4.0;
//
//void fragment() {
    //vec2 uv = FRAGCOORD.xy / SCREEN_PIXEL_SIZE;
    //float dither_value = mod(floor(uv.x / pixel_size) + floor(uv.y / pixel_size), 2.0);
    //vec4 current_color = texture(TEXTURE, UV);
    //
    //// Apply the transition based on the progress
    //if (transition_progress < dither_value) {
        //COLOR = vec4(current_color.rgb, 1.0);
    //} else {
        //COLOR = vec4(fade_color, transition_progress);
    //}
//}

uniform float transition_progress:hint_range(1.0, 350.0, 0.1);

void fragment() {
    float scanline = step(1.0, mod(FRAGCOORD.x, transition_progress)); 
    COLOR.rgb *= vec3(scanline);
}
