precision mediump float;

varying vec2 v_texcoord;
uniform sampler2D tex;
uniform float time;

float rand(vec2 co) {
    return fract(sin(dot(co.xy, vec2(12.9898, 78.233))) * 43758.5453);
}

void main() {
    vec2 uv = v_texcoord;

    // --- glitch: displaced horizontal bands ---
    float band_speed  = floor(time * 8.0);
    float band_height = 0.04 + rand(vec2(band_speed, 0.1)) * 0.12;
    float band_y      = rand(vec2(band_speed, 0.3));
    float in_band     = step(band_y, uv.y) * step(uv.y, band_y + band_height);
    float shift       = (rand(vec2(band_speed, uv.y)) - 0.5) * 0.06 * in_band;

    // secondary thin band
    float band2_speed  = floor(time * 18.0);
    float band2_y      = rand(vec2(band2_speed, 0.77));
    float in_band2     = step(band2_y, uv.y) * step(uv.y, band2_y + 0.01);
    float shift2       = (rand(vec2(band2_speed, 0.5)) - 0.5) * 0.12 * in_band2;

    uv.x += shift + shift2;
    uv.x = clamp(uv.x, 0.0, 1.0);

    // --- chromatic aberration ---
    float aberration = 0.006 + in_band * 0.018;
    vec4 r = texture2D(tex, uv + vec2( aberration, 0.0));
    vec4 g = texture2D(tex, uv);
    vec4 b = texture2D(tex, uv + vec2(-aberration, 0.0));

    vec4 color = vec4(r.r, g.g, b.b, 1.0);

    // --- scanlines ---
    float scan = sin(uv.y * 1080.0 * 3.14159) * 0.04;
    color.rgb -= scan;

    // --- darkened vignette ---
    vec2 vig = uv * (1.0 - uv.yx);
    float vignette = pow(vig.x * vig.y * 18.0, 0.35);
    color.rgb *= mix(0.55, 1.0, vignette);

    // --- occasional full-row whiteout glitch ---
    float flash_speed = floor(time * 24.0);
    float flash_y     = rand(vec2(flash_speed, 0.91));
    float flash_h     = 0.002;
    float in_flash    = step(flash_y, uv.y) * step(uv.y, flash_y + flash_h);
    color.rgb = mix(color.rgb, vec3(0.9, 0.95, 1.0), in_flash * 0.85);

    // --- blue-red tint shift ---
    color.r *= 1.08;
    color.b *= 1.12;

    gl_FragColor = color;
}
