#[compute]
#version 450

layout(local_size_x = 16, local_size_y = 16, local_size_z = 1) in;

layout (set = 0, binding = 0, rgba32f) uniform image2D inTex;

void main() {
    vec4 color = vec4(1.0,0.0,0.0,1.0);
    ivec2 texel = ivec2(gl_GlobalInvocationID.xy);
    imageStore(inTex, texel, color);
}