void GerstnerWave (float2 worldPos, float amplitude, float wavelength, float speed, float steepness, int numWaves, float2 direction, out float3 vertexOffset, out float3 vertexNormal) {
	// VARS
	direction = normalize(direction);
	float wavenumber = 6.28318530718 / wavelength;
	float phasetime = speed * _Time.y;
	float q = steepness / (wavenumber * amplitude * numWaves);
	float WA = wavenumber * amplitude;

	// OFFSET
	float tmp = (dot(worldPos, direction) * wavenumber) + phasetime;
	vertexOffset.xz = direction * q * amplitude * cos(tmp);
	vertexOffset.y = 2 * amplitude * sin(tmp);

	// OFFSET DERIVATIVE
	tmp = phasetime + (wavenumber * dot(direction, worldPos + vertexOffset.xz));
	float s0 = sin(tmp);
	float c0 = cos(tmp);

	// NORMAL
	vertexNormal.xz = -1 * direction * WA * c0;
	vertexNormal.y = 1 - (q * WA * s0);
	vertexNormal = vertexNormal / float3(1, numWaves, 1);
	vertexNormal = normalize(vertexNormal);
}