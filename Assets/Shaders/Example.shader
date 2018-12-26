Shader "Gerstner/Example" {
	Properties {
		[Header(General Settings)]
		_Color ("Color", Color) = (1,1,1,1)
		_Glossiness ("Smoothness", Range(0,1)) = 0.5

		_combined ("Combined", int) = 1
		_combined2 ("Combined2", int) = 1
		_steepness("Steep", Range(0, 1)) = 0


		/*
		[Header(Global Wave Settings)]
		_OffsetStrength ("Offset Strength", Range(0, 1)) = 1.0
		_NormalStrength ("Normal Strength", Range(0, 1)) = 1.0
		_Steepness("Steepness", Range(0, 1)) = 0.0

		[Header(Wave 1)]
		_Wave1Amplitude("Amplitude", float) = 1.0
		_Wave1Wavelength("Wavelength", float) = 1.0
		_Wave1Speed("Speed", float) = 1.0
		_Wave1Direction("Direction", Vector) = (0, 1, 0, 0)

		[Header(Wave 2)]
		_Wave2Amplitude("Amplitude", float) = 1.0
		_Wave2Wavelength("Wavelength", float) = 1.0
		_Wave2Speed("Speed", float) = 1.0
		_Wave2Direction("Direction", Vector) = (0, 1, 0, 0)

		[Header(Wave 3)]
		_Wave3Amplitude("Amplitude", float) = 1.0
		_Wave3Wavelength("Wavelength", float) = 1.0
		_Wave3Speed("Speed", float) = 1.0
		_Wave3Direction("Direction", Vector) = (0, 1, 0, 0)
		*/

	}
	SubShader {
		Tags { "RenderType"="Opaque" }
		LOD 200

		CGPROGRAM
		// Physically based Standard lighting model, and enable shadows on all light types
		#pragma surface surf Standard fullforwardshadows vertex:vert

		// Use shader model 3.0 target, to get nicer looking lighting
		#pragma target 3.0

		#include "GerstnerWave.cginc"

		struct Input {
			float2 uv_MainTex;
		};

		fixed4 _Color;
		half _Glossiness;

		int _combined;
		int _combined2;

		float _offsetStrength;
		float _normalStrength;
		float _amplitude[10];
		float _wavelength[10];
		float _speed[10];
		float _steepness;
		float3 _direction[10];
		float _numWaves;

		void vert (inout appdata_full v) {

			float3 worldPos = mul(unity_ObjectToWorld, v.vertex).xyz;
			float3 offset = float3(0, 0, 0);
			float3 norm = v.normal.xyz;

			for (int i = 0; i < _numWaves; i++) {
				GerstnerOffset(worldPos, _amplitude[i], _wavelength[i], _speed[i],
							   _steepness, _direction[i], _numWaves, offset);
			}

			for (i = 0; i < _numWaves; i++) {
				GerstnerNormal(worldPos, _amplitude[i], _wavelength[i], _speed[i],
							   _steepness, _direction[i], _numWaves, offset, norm);
			}

			v.vertex.xyz = offset;  // lerp(offset, v.vertex.xyz, _offsetStrength);
			v.normal.xyz = norm;  // lerp(normal, v.normal, _normalStrength);


			/*
			float3 position, float amplitude[10], float wavelength[10], float speed[10],
				  float steepness, float3 direction[10], int numWaves, out float3 offset, out float3 normal) {
			*/

      		/*
      		float3 worldPos = mul(unity_ObjectToWorld, v.vertex).xyz;
			half numWaves = _Wave1Contribution + _Wave2Contribution + _Wave3Contribution;

      		half3 vOff1, vOff2, vOff3;
      		half3 vNorm1, vNorm2, vNorm3;

      		GerstnerWave(worldPos.xz, _Wave1Amplitude, _Wave1Wavelength, _Wave1Speed, _Wave1Steepness, numWaves, _Wave1Direction, vOff1, vNorm1);
      		GerstnerWave(worldPos.xz, _Wave2Amplitude, _Wave2Wavelength, _Wave2Speed, _Wave2Steepness, numWaves, _Wave2Direction, vOff2, vNorm2);
      		GerstnerWave(worldPos.xz, _Wave3Amplitude, _Wave3Wavelength, _Wave3Speed, _Wave3Steepness, numWaves, _Wave3Direction, vOff3, vNorm3);

      		vOff1 = lerp(half3(0, 0, 0), vOff1, _Wave1Contribution);
      		vOff2 = lerp(half3(0, 0, 0), vOff2, _Wave2Contribution);
      		vOff3 = lerp(half3(0, 0, 0), vOff3, _Wave3Contribution);
      		v.vertex.xyz += lerp(half3(0, 0, 0), vOff1 + vOff2 + vOff3, _OffsetStrength);

      		vNorm1 = lerp(v.normal, vNorm1, _Wave1Contribution);
      		vNorm2 = lerp(v.normal, vNorm2, _Wave2Contribution);
      		vNorm3 = lerp(v.normal, vNorm3, _Wave3Contribution);
      		v.normal += lerp(v.normal, normalize((vNorm1 + vNorm2 + vNorm3) / half3(1, numWaves, 1)), _NormalStrength);
      		*/
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
