void GerstnerWave(float2 worldPos, half amplitude, half wavelength, half speed, fixed steepness, half numWaves, half2 direction, out half3 vertexOffset, out half3 vertexNormal) {
	// VARIABLES
	direction = normalize(direction);
	float wavenumber = (2 * UNITY_PI) / wavelength;
	float phasetime = speed * _Time.y * wavenumber;  // multiply by wavenumber to "normalize" the speed so its constant, not relative to wavelength
	float q = steepness / (wavenumber * amplitude * numWaves);
	float WA = wavenumber * amplitude;
	float amplitudeMultiplier = 1;  // 1 if a is considered as peak to midline, or 0.5 if a is consdered as peak to peak

	// OFFSET
	float tmp = (dot(worldPos, direction) * wavenumber) + phasetime;
	vertexOffset.xz = direction * q * amplitude * cos(tmp);
	vertexOffset.y = amplitude * amplitudeMultiplier * sin(tmp);

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

/*
void GerstnerWaveNew(
	half ampltiude, half wavelength, half speed, fixed steepness
	inout float3 position, inout binormal, inout tangent) {

}
*/