#version 330 core
layout (location = 0) in vec4 vertex; // <vec2 position, vec2 texCoords>

out vec2 frag_texCoords;

uniform mat4 projection;

void main()
{
    frag_texCoords = vertex.zw;
    gl_Position = projection  *  vec4(vertex.xy, 0.0f, 1.0f);
}  