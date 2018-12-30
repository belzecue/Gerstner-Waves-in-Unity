Shader "Custom/Example" {
	Properties {
		[Header(General Settings)]
		_Color ("Color", Color) = (0.5, 0.5, 0.5, 1)
		_Glossiness ("Smoothness", Range(0, 1)) = 0.0
		_Metallic ("Metallic", Range(0, 1)) = 0.0

		[Header(Global Wave Settings)]
		_OffsetStrength ("Offset Strength", Range(0, 1)) = 1.0
		_NormalStrength ("Normal Strength", Range(0, 1)) = 1.0
		_Steepness("Steepness", Range(0, 1)) = 0.0

		[Header(Enabled Wave(s))]
		[Toggle]
		_Wave1Enabled ("Wave 1", int) = 1
		[Toggle]
		_Wave2Enabled ("Wave 2", int) = 1
		[Toggle]
		_Wave3Enabled ("Wave 3", int) = 1

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
		
		// "addshadow" forces Unity to recalculate shadows, taking the displaced vertices into account.
		#pragma surface surf Standard fullforwardshadows addshadow

		#pragma vertex vert
		#pragma target 3.0

		#include "../Shaders/Gerstner.cginc"

		struct Input {
			float2 uv_MainTex;
			float3 worldPos;
		};

		float4 _Color;
		float _Glossiness;
		float _Metallic;

		float _OffsetStrength;
		float _NormalStrength;
		float _Steepness;

		int _Wave1Enabled;
		float _Wave1Amplitude;
		float _Wave1Wavelength;
		float _Wave1Speed;
		float3 _Wave1Direction;

		int _Wave2Enabled;
		float _Wave2Amplitude;
		float _Wave2Wavelength;
		float _Wave2Speed;
		float3 _Wave2Direction;

		int _Wave3Enabled;
		float _Wave3Amplitude;
		float _Wave3Wavelength;
		float _Wave3Speed;
		float3 _Wave3Direction;

		void vert (inout appdata_full v) {
			GerstnerGlobal g;
			
			g.offsetStrength = _OffsetStrength;
			g.normalStrength = _NormalStrength;
			g.steepness = _Steepness;
			g.numWaves = 3.0;

			// 10 is hardcoded into the Gerstner.cginc function and should be
			// more than enough to observe ocean-like waves with the correct
			// parameters.
			GerstnerWave waves[10];

			// fill only the first 3 slots, as we only have 3 waves.
			waves[0].enabled = _Wave1Enabled;
			waves[0].amplitude = _Wave1Amplitude;
			waves[0].wavelength = _Wave1Wavelength;
			waves[0].speed = _Wave1Speed;
			waves[0].dir = _Wave1Direction;

			waves[1].enabled = _Wave2Enabled;
			waves[1].amplitude = _Wave2Amplitude;
			waves[1].wavelength = _Wave2Wavelength;
			waves[1].speed = _Wave2Speed;
			waves[1].dir = _Wave2Direction;

			waves[2].enabled = _Wave3Enabled;
			waves[2].amplitude = _Wave3Amplitude;
			waves[2].wavelength = _Wave3Wavelength;
			waves[2].speed = _Wave3Speed;
			waves[2].dir = _Wave3Direction;

			Gerstner(v.vertex, v.normal, g, waves);
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
