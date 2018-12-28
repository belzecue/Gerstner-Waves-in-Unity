#define TIME _Time.y
#define TAU (2 * UNITY_PI)

void GerstnerOffset(float3 worldPos, float amplitude, float wavelength, float speed,
					float steepness, float3 direction, float numWaves, inout float3 offset) {
	direction = normalize(direction);
	float w = TAU / wavelength;
	float phi = speed * w;
	float q = steepness / (amplitude * w * numWaves);

	offset.x += /*(worldPos.x / numWaves)*/ + q*amplitude * direction.x * cos(dot(w * direction.xz, worldPos.xz) + phi*TIME);
	offset.y += amplitude * sin(dot(w * direction.xz, worldPos.xz) + phi*TIME);
	offset.z += /*(worldPos.z / numWaves)*/ + q*amplitude * direction.z * cos(dot(w * direction.xz, worldPos.xz) + phi*TIME);
}

void GerstnerNormal(float3 worldPos, float amplitude, float wavelength, float speed,
					float steepness, float3 direction, float numWaves, float3 offset, inout float3 normal) {
	direction = normalize(direction);
	float w = TAU / wavelength;
	float phi = speed * w;
	float q = steepness / (amplitude * w * numWaves);

	normal.x /*-=*/ += (direction.x * w*amplitude * cos(w * dot(direction.xz, offset.xz) + phi*TIME));
	normal.y /*+= ((1.0/numWaves) - */ += ((q * w*amplitude * sin(w * dot(direction.xz, offset.xz) + phi*TIME)));
	normal.z /*-=*/ += (direction.z * w*amplitude * cos(w * dot(direction.xz, offset.xz) + phi*TIME));
}