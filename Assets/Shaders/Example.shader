// Upgrade NOTE: replaced '_Object2World' with 'unity_ObjectToWorld'

Shader "Gerstner/Example" {
	Properties {
		[Header(General Settings)]
		_Color ("Color", Color) = (1,1,1,1)
		_Glossiness ("Smoothness", Range(0,1)) = 0.5

		[Header(Global Wave Settings)]
		_OffsetStrength ("Offset Strength", Range(0, 1)) = 1.0
		_NormalStrength ("Normal Strength", Range(0, 1)) = 1.0

		[Header(Wave 1)]
		_Wave1Contribution("Contribution", Range(0, 1)) = 1.0
		_Wave1Amplitude("Amplitude", float) = 1.0
		_Wave1Wavelength("Wavelength", float) = 1.0
		_Wave1Speed("Speed", float) = 1.0
		_Wave1Steepness("Steepness", Range(0, 1)) = 0.0
		_Wave1Direction("Direction", Vector) = (0, 1, 0, 0)

		[Header(Wave 2)]
		_Wave2Contribution("Contribution", Range(0, 1)) = 1.0
		_Wave2Amplitude("Amplitude", float) = 1.0
		_Wave2Wavelength("Wavelength", float) = 1.0
		_Wave2Speed("Speed", float) = 1.0
		_Wave2Steepness("Steepness", Range(0, 1)) = 0.0
		_Wave2Direction("Direction", Vector) = (0, 1, 0, 0)

		[Header(Wave 3)]
		_Wave3Contribution("Contribution", Range(0, 1)) = 1.0
		_Wave3Amplitude("Amplitude", float) = 1.0
		_Wave3Wavelength("Wavelength", float) = 1.0
		_Wave3Speed("Speed", float) = 1.0
		_Wave3Steepness("Steepness", Range(0, 1)) = 0.0
		_Wave3Direction("Direction", Vector) = (0, 1, 0, 0)

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

		fixed _OffsetStrength;
		fixed _NormalStrength;

		fixed _Wave1Contribution;
		half _Wave1Amplitude;
		half _Wave1Wavelength;
		half _Wave1Speed;
		fixed _Wave1Steepness;
		fixed2 _Wave1Direction;

		fixed _Wave2Contribution;
		half _Wave2Amplitude;
		half _Wave2Wavelength;
		half _Wave2Speed;
		fixed _Wave2Steepness;
		fixed2 _Wave2Direction;

		fixed _Wave3Contribution;
		half _Wave3Amplitude;
		half _Wave3Wavelength;
		half _Wave3Speed;
		fixed _Wave3Steepness;
		fixed2 _Wave3Direction;

		void vert (inout appdata_full v) {
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
