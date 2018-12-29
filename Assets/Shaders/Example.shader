// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "Custom/Example" {
	Properties {
		[Header(General Settings)]
		_Color ("Color", Color) = (0.5, 0.5, 0.5, 1)
		_Glossiness ("Smoothness", Range(0, 1)) = 0.0
		_Metallic ("Metallic", Range(0, 1)) = 0.0

		_Tmp ("Tmp", Vector) = (0, 0, 0, 0)

		[Header(Global Wave Settings)]
		_OffsetStrength ("Offset Strength", Range(0, 1)) = 1.0
		_NormalStrength ("Normal Strength", Range(0, 1)) = 1.0
		_Steepness("Steepness", Range(0, 1)) = 0.0

		[Header(Enable(d) Waves)]
		[Toggle]
		_UseWave1("Wave 1", int) = 1
		[Toggle]
		_UseWave2("Wave 2", int) = 1
		[Toggle]
		_UseWave3("Wave 3", int) = 1

		[Header(Wave 1)]
		_Wave1Amplitude("Amplitude", float) = 1.0
		_Wave1Wavelength("Wavelength", float) = 1.0
		_Wave1Speed("Speed", float) = 1.0
		_Wave1Direction("Direction", Vector) = (1, 0, 0, 0)

		[Header(Wave 2)]
		_Wave2Amplitude("Amplitude", float) = 1.0
		_Wave2Wavelength("Wavelength", float) = 1.0
		_Wave2Speed("Speed", float) = 1.0
		_Wave2Direction("Direction", Vector) = (1, 0, 1, 0)

		[Header(Wave 3)]
		_Wave3Amplitude("Amplitude", float) = 1.0
		_Wave3Wavelength("Wavelength", float) = 1.0
		_Wave3Speed("Speed", float) = 1.0 
		_Wave3Direction("Direction", Vector) = (0, 0, 1, 0)
	}
	SubShader {
		Tags { "RenderType"="Opaque" }
		LOD 200

		CGPROGRAM
		
		// "addshadow" forces Unity to recalculate shadows, taking the displaced vertices into account
		#pragma surface surf Standard fullforwardshadows addshadow

		// "vertex vert" tells Unity to load the "vert" function as the vertex shader
		#pragma vertex vert

		#pragma target 3.0

		#include "../Shaders/Gerstner.cginc"

		#define SCALE float3(length(float3(unity_ObjectToWorld[0].x, unity_ObjectToWorld[1].x, unity_ObjectToWorld[2].x)), length(float3(unity_ObjectToWorld[0].y, unity_ObjectToWorld[1].y, unity_ObjectToWorld[2].y)), length(float3(unity_ObjectToWorld[0].z, unity_ObjectToWorld[1].z, unity_ObjectToWorld[2].z)))

		struct Input {
			float2 uv_MainTex;
			float3 worldPos;
		};

		float4 _Color;
		float _Glossiness;
		float _Metallic;

		float4 _Tmp;

		float _OffsetStrength;
		float _NormalStrength;
		float _Steepness;

		int _UseWave1, _UseWave2, _UseWave3;

		float _Wave1Amplitude;
		float _Wave1Wavelength;
		float _Wave1Speed;
		float3 _Wave1Direction;

		float _Wave2Amplitude;
		float _Wave2Wavelength;
		float _Wave2Speed;
		float3 _Wave2Direction;

		float _Wave3Amplitude;
		float _Wave3Wavelength;
		float _Wave3Speed;
		float3 _Wave3Direction;

		void vert (inout appdata_full v) {
			float numWaves = 0;

			if (_UseWave1 == 1)
				numWaves++;
			if (_UseWave2 == 1)
				numWaves++;
			if (_UseWave3 == 1)
				numWaves++;

			// the original point position must be in world space to properly tile
			float3 worldPos = mul(unity_ObjectToWorld, v.vertex).xyz;

			// the gerstner equations are defined as sums, so each vector starts at 0
			float3 newPoint = float3(0, 0, 0);
			float3 newPointNormal = float3(0, 0, 0);

			if (_UseWave1 == 1)
				GerstnerPosition(worldPos, _Wave1Amplitude, _Wave1Wavelength, _Wave1Speed, _Wave1Direction, _Steepness, numWaves, newPoint);
			if (_UseWave2 == 1)
				GerstnerPosition(worldPos, _Wave2Amplitude, _Wave2Wavelength, _Wave2Speed, _Wave2Direction, _Steepness, numWaves, newPoint);
			if (_UseWave3 == 1)
				GerstnerPosition(worldPos, _Wave3Amplitude, _Wave3Wavelength, _Wave3Speed, _Wave3Direction, _Steepness, numWaves, newPoint);

			// finalize the new point position by adding the summed offset to the original point position
			newPoint.xz += worldPos.xz;

			// note that to recalculate the normals, we need the new point position, so every position must be summed first.
			if (_UseWave1 == 1)
				GerstnerNormal(newPoint, _Wave1Amplitude, _Wave1Wavelength, _Wave1Speed, _Wave1Direction, _Steepness, numWaves, newPointNormal);
			if (_UseWave2 == 1)
				GerstnerNormal(newPoint, _Wave2Amplitude, _Wave2Wavelength, _Wave2Speed, _Wave2Direction, _Steepness, numWaves, newPointNormal);
			if (_UseWave3 == 1)
				GerstnerNormal(newPoint, _Wave3Amplitude, _Wave3Wavelength, _Wave3Speed, _Wave3Direction, _Steepness, numWaves, newPointNormal);
			
			// finalize the normals by modifying the summed components
			newPointNormal.xz *= -1.0;
			newPointNormal.y = 1.0 - newPointNormal.y;

			// the newPoint position is currently in world space. We need it in object space to apply it back to the mesh.
			// so subtract the worldPos from the offset, convert to object space, and reapply the offset to the vertex pos
			newPoint.xz -= worldPos.xz;
			newPoint = mul(unity_WorldToObject, newPoint);
			newPoint.xz += v.vertex.xz;

			// convert the normal from world space back to object space (to account for non-identity rotations)
			newPointNormal = mul(unity_WorldToObject, newPointNormal);

			// scale the XZ component of the normal by the transform scale (to account for non-identity scalings)
			newPointNormal.xz *= pow(SCALE.xz, 2.0);

			// only apply the transformation if there is at least one wave enabled
			if (numWaves > 0) {
				v.vertex.xyz = lerp(v.vertex.xyz, newPoint, _OffsetStrength);
				v.normal = normalize(lerp(v.normal, newPointNormal, _NormalStrength));
			}
		}

		void surf (Input IN, inout SurfaceOutputStandard o) {
			o.Albedo = _Color.rgb;
			o.Metallic = _Metallic;
			o.Smoothness = _Glossiness;
			o.Alpha = _Color.a;
		}
		ENDCG
	}
	FallBack "Diffuse"
}
