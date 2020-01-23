#version 330 core

layout (location = 0) in vec3 position;
layout (location = 1) in vec3 normal;
layout (location = 2) in vec2 texCoords;
layout (location = 3) in ivec4 bones;
layout (location = 4) in vec4 bonesWeight;

out vec2 frag_texCoords;
out vec3 frag_fragPos;
out vec3 frag_normal;

uniform mat4 gMVP;
uniform mat4 model;
uniform mat3 modelNormal;
uniform mat4 bonesOffset[20];

void main() {
	vec4 posL = vec4(position, 1.0f);
	mat4 boneTransform = mat4(1.0f);
	if(bonesWeight[0] > 0.0f) {
		boneTransform = bonesOffset[bones[0]] * bonesWeight[0];
		boneTransform += bonesOffset[bones[1]] * bonesWeight[1];
		boneTransform += bonesOffset[bones[2]] * bonesWeight[2];
		boneTransform += bonesOffset[bones[3]] * bonesWeight[3];

		posL = boneTransform * vec4(position, 1.0f);
	}
	
	gl_Position = gMVP * posL;
	frag_texCoords = texCoords;
	frag_normal = mat3(transpose(inverse(model * boneTransform))) * normal;
	frag_fragPos = vec3(model * posL);
}