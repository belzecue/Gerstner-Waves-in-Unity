Shader "Gerstner/Example" {
	Properties {
		[Header(General Settings)]
		_Color ("Color", Color) = (1,1,1,1)
		_Glossiness ("Smoothness", Range(0,1)) = 0.5

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
		// Physically based Standard lighting model, and enable shadows on all light types
		// addshadow forces Unity to add an extra shadow-pass which takes our vertex modifications into account
		#pragma surface surf Standard fullforwardshadows vertex:vert addshadow

		// Use shader model 3.0 target, to get nicer looking lighting
		#pragma target 3.0

		#include "GerstnerWave.cginc"

		struct Input {
			float2 uv_MainTex;
		};

		fixed4 _Color;
		half _Glossiness;

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

			float3 worldPos = mul(unity_ObjectToWorld, v.vertex).xyz;
			float3 offset = float3(0, 0, 0);
			float3 norm = float3(0, 0, 0);  // v.normal.xyz; ????

			// get the offset vector
			if (_UseWave1 == 1)
				GerstnerOffset(worldPos, _Wave1Amplitude, _Wave1Wavelength, _Wave1Speed, _Steepness, _Wave1Direction, numWaves, offset);
			if (_UseWave2 == 1)
				GerstnerOffset(worldPos, _Wave2Amplitude, _Wave2Wavelength, _Wave2Speed, _Steepness, _Wave2Direction, numWaves, offset);
			if (_UseWave3 == 1)
				GerstnerOffset(worldPos, _Wave3Amplitude, _Wave3Wavelength, _Wave3Speed, _Steepness, _Wave3Direction, numWaves, offset);

			// get the normal vector (requires the offset vector)
			if (_UseWave1 == 1)
				GerstnerNormal(worldPos, _Wave1Amplitude, _Wave1Wavelength, _Wave1Speed, _Steepness, _Wave1Direction, numWaves, offset, norm);
			if (_UseWave2 == 1)
				GerstnerNormal(worldPos, _Wave2Amplitude, _Wave2Wavelength, _Wave2Speed, _Steepness, _Wave2Direction, numWaves, offset, norm);
			if (_UseWave3 == 1)
				GerstnerNormal(worldPos, _Wave3Amplitude, _Wave3Wavelength, _Wave3Speed, _Steepness, _Wave3Direction, numWaves, offset, norm);

			//offset = mul(unity_WorldToObject, offset);

			v.vertex.xyz = lerp(v.vertex.xyz, offset, _OffsetStrength);
			v.normal.xyz = normalize(lerp(v.normal, norm, _NormalStrength));
      	}

		void surf (Input IN, inout SurfaceOutputStandard o) {
			o.Albedo = _Color.rgb;
			o.Alpha = _Color.a;
			o.Metallic = 0.0;
			o.Smoothness = _Glossiness;
		}
		ENDCG
	}
	FallBack "Diffuse"
}
