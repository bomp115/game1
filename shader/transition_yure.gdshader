shader_type canvas_item;

uniform vec2 resolution;
uniform float time;

void fragment() {
    vec2 uv = FRAGCOORD.xy / resolution;
    
    // 基本的な色合いを設定
    vec3 base_color = vec3(0.5, 0.3, 0.8); // ベースカラー
    vec3 pattern_color = vec3(0.2, 0.1, 0.3); // 模様の色

    // 波のような動きを作る
    float wave = sin(uv.y * 10.0 + time) * 0.05;
    
    // テクスチャを使った模様
    float pattern = sin(uv.x * 20.0 + time * 2.0) * 0.5 + 0.5;
    
    // 最終的な色を設定
    vec3 final_color = mix(base_color, pattern_color, pattern);
    final_color += wave; // 波の効果を追加
    
    COLOR = vec4(final_color, 1.0);
}