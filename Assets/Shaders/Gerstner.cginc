#define TIME (_Time.y * UNITY_PI)
#define TAU (2 * UNITY_PI)

struct GerstnerGlobal {
	float offsetStrength;
	float normalStrength;
	float steepness;
	int numWaves;
};

struct GerstnerWave {
	int enabled;
	float amplitude;
	float wavelength;
	float speed;
	float3 dir;
};

// calculate the summed portion of the gerstner position equation.
void GerstnerPositionSum(float3 p, float a, float lambda, float phi, float3 dir, float Q, float N, inout float3 newPoint) {
	dir.xz = normalize(dir.xz);
	float w = TAU / lambda;
	Q /= (w * a * N);
	phi *= (w / UNITY_PI);

	newPoint.xz += Q * a * dir.xz * cos(dot(w * dir.xz, p.xz) + phi * TIME);
	newPoint.y += a * sin(dot(w * dir.xz, p.xz) + phi * TIME);
}

// calculate the summed portion of the gerstner normal equation.
void GerstnerNormalSum(float3 newPoint, float a, float lambda, float phi, float3 dir, float Q, float N, inout float3 newPointNormal) {
	dir.xz = normalize(dir.xz);
	float w = TAU / lambda;
	Q /= (w * a * N);
	phi *= (w / UNITY_PI);

	newPointNormal.xz += dir.xz * w * a * cos(w * dot(dir.xz, newPoint.xz) + phi * TIME);
	newPointNormal.y += Q * w * a * sin(w * dot(dir.xz, newPoint.xz) + phi * TIME);
}

// calculate and apply the gerstner equations to the input vertex and normal.
void Gerstner(inout float4 vertex, inout float3 normal,
			  GerstnerGlobal g, GerstnerWave waves[10]) {

	// all gerstner calculations are done in world space to preserve tiling.
	float3 originalPoint = mul(unity_ObjectToWorld, vertex).xyz;

	// gerstner equations are defined as sums, so initially these start at 0.
	float3 positionOffset = float3(0, 0, 0);
	float3 normalOffset = float3(0, 0, 0);

	// calculate the number of waves we will be applying;
	float numWavesEnabled = 0;
	for (int i = 0; i < g.numWaves; i++) {
		if (waves[i].enabled == 1) {
			numWavesEnabled++;
		}
	}

	for (int j = 0; j < g.numWaves; j++) {
		if (waves[j].enabled == 1) {
			GerstnerPositionSum(originalPoint, waves[j].amplitude, waves[j].wavelength, waves[j].speed, waves[j].dir, g.steepness, numWavesEnabled, positionOffset);
		}
	}

	// gerstner equations only call for adding xz from the original point, but we add y as well to
	// account for water planes not on the (x, 0, z) plane.
	float3 newPoint = originalPoint + positionOffset;

	for (int k = 0; k < g.numWaves; k++) {
		if (waves[k].enabled == 1) {
			GerstnerNormalSum(newPoint, waves[k].amplitude, waves[k].wavelength, waves[k].speed, waves[k].dir, g.steepness, numWavesEnabled, normalOffset);
		}
	}

	// calculate final normal based on sum.
	float3 newPointNormal = float3(-normalOffset.x, 1.0 - normalOffset.y, -normalOffset.z);

	// we must convert these world space vectors back to object space vectors to account for non-identity mesh transformations.
	newPoint = mul(unity_WorldToObject, newPoint - originalPoint) + vertex;
	newPointNormal = mul(unity_WorldToObject, newPointNormal);

	// we must also scale the normals based on the meshes transform scale
	float3 meshScale = float3(length(float3(unity_ObjectToWorld[0].x, unity_ObjectToWorld[1].x, unity_ObjectToWorld[2].x)),
							  length(float3(unity_ObjectToWorld[0].y, unity_ObjectToWorld[1].y, unity_ObjectToWorld[2].y)),
					 		  length(float3(unity_ObjectToWorld[0].z, unity_ObjectToWorld[1].z, unity_ObjectToWorld[2].z)));
	newPointNormal.xz *= pow(meshScale.xz, 2.0);

	// finally, apply the transformed vertex and normal.
	vertex.xyz = lerp(vertex.xyz, newPoint, g.offsetStrength);
	normal = lerp(normal, newPointNormal, g.normalStrength);
}
