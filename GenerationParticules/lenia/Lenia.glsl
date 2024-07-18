#[compute]
#version 450

layout(local_size_x = 16, local_size_y = 16, local_size_z = 1) in;

layout (set = 0, binding = 0, rgba32f) uniform image2D inTex;

layout (set = 0, binding = 1) restrict buffer MouseInfoBuffer {
    float data[];
} mouse_info_buffer;

void main() {
    if (mouse_info_buffer.data[0] > 0.0 && mouse_info_buffer.data[1] > 0.0) {
        vec4 color = vec4(1.0,0.0,0.0,1.0);
        ivec2 texel = ivec2(mouse_info_buffer.data[0], mouse_info_buffer.data[1]);
        imageStore(inTex, texel, color);
    }
    
}