#define TIME (_Time.y * UNITY_PI)
#define TAU (2 * UNITY_PI)

// note that this is only the summed portion of the gerstner wave equation. It must be finalized by adding the original point
// position's x and z components. This gets tricky when dealing with object space vs world space, so we defer it to the programmer
void GerstnerPosition(float3 p, float a, float lambda, float phi, float3 dir, float Q, float N, inout float3 newPoint) {
	dir.xz = normalize(dir.xz);
	float w = TAU / lambda;
	Q /= (w * a * N);
	phi *= (w / UNITY_PI);

	newPoint.xz += Q * a * dir.xz * cos(dot(w * dir.xz, p.xz) + phi * TIME);
	newPoint.y += a * sin(dot(w * dir.xz, p.xz) + phi * TIME);
}

// note that this is only the summed portion of the gerstner wave equation. It must be finaled by negating the xz component, and oneminus'ing the y component.
void GerstnerNormal(float3 newPoint, float a, float lambda, float phi, float3 dir, float Q, float N, inout float3 newPointNormal) {
	dir.xz = normalize(dir.xz);
	float w = TAU / lambda;
	Q /= (w * a * N);
	phi *= (w / UNITY_PI);

	newPointNormal.xz += dir.xz * w * a * cos(w * dot(dir.xz, newPoint.xz) + phi * TIME);
	newPointNormal.y += Q * w * a * sin(w * dot(dir.xz, newPoint.xz) + phi * TIME);
}