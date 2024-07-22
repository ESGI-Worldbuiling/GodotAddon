#[compute]
#version 450

layout(local_size_x = 16, local_size_y = 16, local_size_z = 1) in;

layout (set = 0, binding = 0, rgba32f) restrict uniform readonly image2D inputImage;
layout (set = 0, binding = 1, rgba32f) restrict uniform writeonly image2D outputImage;

layout (set = 1, binding = 0) restrict buffer MouseInfoBuffer {
    float data[];
} mouse_info_buffer;

const vec4 aliveColor = vec4(1.0);
const vec4 deadColor = vec4(0.0,0.0,0.0,1.0);

const float radius = 2.0f;

const mat3 conwayKernel = mat3(
                                1.0,1.0,1.0,
                                1.0,0.0,1.0,
                                1.0,1.0,1.0
                            );

bool isCellAlive(int x, int y) {
    vec4 pixel = imageLoad(inputImage, ivec2(x,y));
    return pixel.r > 0.5;
}

int getCellNeightbours(int x, int y, int width, int height) {
    int count = 0;
    for (int i = -1; i <= 1; i++) {
        for (int j = -1; j <= 1; j++) {
            if (i == 0 && j == 0) continue; // Skip the current cell

            int nx = x + i;
            int ny = y + j;

            if (nx >= 0 && nx < width && ny >= 0 && ny < height) {
                vec4 pixel = imageLoad(inputImage, ivec2(nx, ny));
                if (isCellAlive(nx, ny)) {
                    count += int(conwayKernel[i+1][j+1]) * int(pixel.r);
                }
            }
        }
    }
    return count;
}

void main() {
    ivec2 imageSize = imageSize(inputImage);
    if (mouse_info_buffer.data[0] > 0.0 && mouse_info_buffer.data[1] > 0.0) {
        vec4 color = vec4(1.0);
        ivec2 center  = ivec2(mouse_info_buffer.data[0], mouse_info_buffer.data[1]);

        for (int x = -int(radius); x <= int(radius); ++x) {
        for (int y = -int(radius); y <= int(radius); ++y) {
            if (x*x + y*y <= radius*radius) {
                ivec2 texel = center + ivec2(x, y);
                imageStore(outputImage, texel, color);
            }
        }
    }
        return;
    }
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    if (pos.x >= imageSize.x || pos.y >= imageSize.y) return;
    int liveNeighbours = getCellNeightbours(pos.x, pos.y, imageSize.x, imageSize.y);
    bool isAlive = isCellAlive(pos.x, pos.y);
    bool nextState = isAlive;
    if (isAlive && (liveNeighbours < 2 || liveNeighbours > 3)) {
        nextState = false;
    } else if (!isAlive && liveNeighbours == 3) {
        nextState = true;
    }
    vec4 newColor = nextState ? aliveColor : deadColor;
    imageStore(outputImage, pos, newColor);
}