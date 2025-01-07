shader_type canvas_item;


uniform vec2 shadow_offset = vec2(2.0, 2.0);
uniform vec4 shadow_color  = vec4(0.0, 0.0, 0.0, 0.5);
uniform float shadow_blur = 1.0;

void fragment() {
    // Sample the original text color
    vec4 text_color = texture(TEXTURE, FRAGCOORD.xy / SCREEN_PIXEL_SIZE);
    
    // Calculate the shadow position
    vec2 shadow_pos = FRAGCOORD.xy + shadow_offset;

    // Sample the shadow color
    vec4 shadow = texture(TEXTURE, shadow_pos / SCREEN_PIXEL_SIZE);

    // Apply the shadow color and blur
    shadow = shadow_color * shadow.a * shadow_blur;
    
    // Combine the shadow and the text color
    COLOR = mix(shadow, text_color, text_color.a);
}
