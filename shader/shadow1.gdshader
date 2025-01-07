shader_type canvas_item;

uniform float shadow_offset : hint_range(-10.0, 10.0);
uniform vec4 shadow_color = vec4(0.0, 0.0, 0.0, 0.5);

void fragment() {
    // 現在のテクスチャの色を取得
    vec4 text_color = texture(TEXTURE, FRAGCOORD.xy / SCREEN_PIXEL_SIZE);

    // 影の色を取得するために、オフセット位置でテクスチャをサンプリング
    vec4 shadow = texture(TEXTURE, (FRAGCOORD.xy + shadow_offset) / SCREEN_PIXEL_SIZE);
    
    // 影の色が存在する場合は、影の色を混ぜる
    COLOR = mix(shadow_color, text_color, text_color.a);
}