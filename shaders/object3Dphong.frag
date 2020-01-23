#version 330 core

in vec2 frag_texCoords;
in vec3 frag_fragPos;
in vec3 frag_normal;

out vec4 FragColor;

struct Light {
	vec3 position;
	vec3 ambient;
	vec3 diffuse;
	vec3 specular;
};

struct Material {
	sampler2D texture_diffuse1;
	vec3 specular;
	float shininess;
};

uniform Material material;
uniform Light light;
uniform vec3 viewPos;

void main() {
	vec3 color = texture(material.texture_diffuse1, frag_texCoords).rgb;
	vec3 norm = normalize(frag_normal);
	vec3 lightDir = normalize(light.position - frag_fragPos);
	vec3 viewDir = normalize(viewPos - frag_fragPos);

	// Ambient light
	vec3 ambient = light.ambient * color;

	// Diffuse light
	float diff = max(dot(norm, lightDir), 0.0f);
	vec3 diffuse = light.diffuse * diff * color;

	// Specular light
	vec3 reflectDir = reflect(-lightDir, norm);
	float spec = pow(max(dot(viewDir, reflectDir), 0.0f), material.shininess);
	vec3 specular = light.specular * (spec * material.specular);

	// Final output color
	FragColor = vec4(ambient + diffuse + specular, 1.0f);
}