#define TIME _Time.y
#define TAU (2 * UNITY_PI)

struct GerstnerGlobalProperties {
	float3 worldPosition;
	float steepness;
	float numWaves;
	float offsetStrength;
	float3 offset;
	float normalStrength;
	float3 normal;
};

struct GerstnerWaveProperties {
	float amplitude;
	float wavelength;
	float speed;
	float3 direction;
};

void GerstnerOffset(inout GerstnerGlobalProperties g, inout GerstnerWaveProperties wave) {
	wave.direction = normalize(wave.direction);
	float w = TAU / wave.wavelength;
	float phi = wave.speed * w;
	float q = g.steepness / (wave.amplitude * w * g.numWaves);

	g.offset.xz += (g.worldPosition.xz / g.numWaves) + q*wave.amplitude * wave.direction.xz * cos(dot(w * wave.direction.xz, g.worldPosition.xz) + phi*TIME);
	g.offset.y += wave.amplitude * sin(dot(w * wave.direction.xz, g.worldPosition.xz) + phi*TIME);
}

void GerstnerNormal(inout GerstnerGlobalProperties g, inout GerstnerWaveProperties wave) {
	wave.direction = normalize(wave.direction);
	float w = TAU / wave.wavelength;
	float phi = wave.speed * w;
	float q = g.steepness / (wave.amplitude * w * g.numWaves);

	g.normal.xz -= (wave.direction.xz * w*wave.amplitude * cos(w * dot(wave.direction.xz, g.offset.xz) + phi*TIME));
	g.normal.y += ((1.0/g.numWaves) - (q * w*wave.amplitude * sin(w * dot(wave.direction.xz, g.offset.xz) + phi*TIME)));
}

/*
void GerstnerOffset(float3 worldPos, float amplitude, float wavelength, float speed,
					float steepness, float3 direction, float numWaves, inout float3 offset) {
	direction = normalize(direction);
	float w = TAU / wavelength;
	float phi = speed * w;
	float q = steepness / (amplitude * w * numWaves);

	offset.xz += (worldPos.xz / numWaves) + q*amplitude * direction.xz * cos(dot(w * direction.xz, worldPos.xz) + phi*TIME);
	offset.y += amplitude * sin(dot(w * direction.xz, worldPos.xz) + phi*TIME);
}

void GerstnerNormal(float3 worldPos, float amplitude, float wavelength, float speed,
					float steepness, float3 direction, float numWaves, float3 offset, inout float3 normal) {
	direction = normalize(direction);
	float w = TAU / wavelength;
	float phi = speed * w;
	float q = steepness / (amplitude * w * numWaves);

	normal.xz -= (direction.xz * w*amplitude * cos(w * dot(direction.xz, offset.xz) + phi*TIME));
	normal.y += ((1.0/numWaves) - (q * w*amplitude * sin(w * dot(direction.xz, offset.xz) + phi*TIME)));
}
*/