#define TIME _Time.y
#define TAU UNITY_PI * 2

void GerstnerWave(float3 position, float amplitude[10], float wavelength[10], float speed[10],
				  float steepness, float3 direction[10], int numWaves, out float3 offset, out float3 normal) {

	offset = float3(0, 0, 0);
	for (int i = 0; i < numWaves; i++) {
		direction[i] = normalize(direction[i]);
		float w = 2 / wavelength[i];
		float phi = speed[i] * w;
		float q = steepness / (amplitude[i] * w * numWaves);

		offset.xz += q * amplitude[i] * direction[i].xz * cos(w * dot(direction[i].xz, position.xz) + phi * TIME);
		offset.y += amplitude[i] * sin(w * dot(direction[i].xz, position.xz) + phi * TIME);
	}
	offset.xz += position.xz;

	normal = float3(0, 0, 0);
	for (i = 0; i < numWaves; i++) {
		float w = 2 / wavelength[i];
		float phi = speed[i] * w;
		float q = steepness / (amplitude[i] * w * numWaves);
		
		normal.xz += direction[i].xz * w * amplitude[i] * cos(w * dot(direction[i].xz, offset.xz) + phi * TIME);
		normal.y += q * w * amplitude[i] * sin(w * dot(direction[i].xz, offset.xz) + phi * TIME);
	}
	normal.xz *= -1;
	normal.y = 1 - normal.y;
}

void GerstnerOffset(float3 worldPos, float amplitude, float wavelength, float speed,
					float steepness, float3 direction, float numWaves, inout float3 offset) {
	direction = normalize(direction);
	float w = 2 / wavelength;
	float phi = speed * w;
	float q = steepness / (amplitude * w * numWaves);

	offset.xz += (worldPos.xz / numWaves) + q * amplitude * direction.xz * cos(w * dot(direction.xz, worldPos.xz) + phi * TIME);
	offset.y += amplitude * sin(w * dot(direction.xz, worldPos.xz) + phi * TIME);
}

void GerstnerNormal(float3 worldPos, float amplitude, float wavelength, float speed,
					float steepness, float3 direction, float numWaves, float3 offset, inout float3 normal) {
	direction = normalize(direction);
	float w = 2 / wavelength;
	float phi = speed * w;
	float q = steepness / (amplitude * w * numWaves);

	normal.xz -= (direction.xz * w * amplitude * cos(w * dot(direction.xz, offset.xz) + phi * TIME));
	normal.y += (1.0/numWaves) - (q * w * amplitude * sin(w * dot(direction.xz, offset.xz) + phi * TIME));
}

void GerstnerWave2(float3 worldPos, float amplitude, float wavelength, float speed,
					float steepness, float3 direction, float numWaves, inout float3 offset, inout float3 normal) {

	direction = normalize(direction);
	float w = 2 / wavelength;
	float phi = speed * w;
	float q = steepness / (amplitude * w * numWaves);

	offset.xz += (worldPos.xz / numWaves) + q * amplitude * direction.xz * cos(w * dot(direction.xz, worldPos.xz) + phi * TIME);
	offset.y += amplitude * sin(w * dot(direction.xz, worldPos.xz) + phi * TIME);

	normal.xz -= (direction.xz * w * amplitude * cos(w * dot(direction.xz, offset.xz) + phi * TIME));
	normal.y += (1.0/numWaves) - (q * w * amplitude * sin(w * dot(direction.xz, offset.xz) + phi * TIME));
}