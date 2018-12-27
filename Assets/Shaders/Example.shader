Shader "Gerstner/Example" {
	Properties {
		[Header(General Settings)]
		_Color ("Color", Color) = (1,1,1,1)
		_Glossiness ("Smoothness", Range(0,1)) = 0.5

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

		float _OffsetStrength;
		float _NormalStrength;
		float _Steepness;

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
			GerstnerGlobalProperties g;
			
			g.worldPosition = mul(unity_ObjectToWorld, v.vertex).xyz;
			g.steepness = _Steepness;
			g.numWaves = 3.0;
			g.offsetStrength = _OffsetStrength;
			g.offset = float3(0, 0, 0);
			g.normalStrength = _NormalStrength;
			g.normal = v.normal.xyz;

			GerstnerWaveProperties w1, w2, w3;

			w1.amplitude = _Wave1Amplitude;
			w1.wavelength = _Wave1Wavelength;
			w1.speed = _Wave1Speed;
			w1.direction = _Wave1Direction;

			w2.amplitude = _Wave2Amplitude;
			w2.wavelength = _Wave2Wavelength;
			w2.speed = _Wave2Speed;
			w2.direction = _Wave2Direction;

			w3.amplitude = _Wave3Amplitude;
			w3.wavelength = _Wave3Wavelength;
			w3.speed = _Wave3Speed;
			w3.direction = _Wave3Direction;

			GerstnerOffset(g, w1);
			GerstnerOffset(g, w2);
			GerstnerOffset(g, w3);
			GerstnerNormal(g, w1);
			GerstnerNormal(g, w2);
			GerstnerNormal(g, w3);

			v.vertex.xyz = lerp(v.vertex.xyz, g.offset, g.offsetStrength);
			v.normal.xyz = normalize(lerp(v.normal.xyz, g.normal, g.normalStrength));

			/*
			float3 worldPos = mul(unity_ObjectToWorld, v.vertex).xyz;
			float3 offset = float3(0, 0, 0);
			float3 norm = v.normal.xyz;

			GerstnerOffset(worldPos, _Wave1Amplitude, _Wave1Wavelength, _Wave1Speed, _Steepness, _Wave1Direction, 3.0, offset);
			GerstnerOffset(worldPos, _Wave2Amplitude, _Wave2Wavelength, _Wave2Speed, _Steepness, _Wave2Direction, 3.0, offset);
			GerstnerOffset(worldPos, _Wave3Amplitude, _Wave3Wavelength, _Wave3Speed, _Steepness, _Wave3Direction, 3.0, offset);

			GerstnerNormal(worldPos, _Wave1Amplitude, _Wave1Wavelength, _Wave1Speed, _Steepness, _Wave1Direction, 3.0, offset, norm);
			GerstnerNormal(worldPos, _Wave2Amplitude, _Wave2Wavelength, _Wave2Speed, _Steepness, _Wave2Direction, 3.0, offset, norm);
			GerstnerNormal(worldPos, _Wave3Amplitude, _Wave3Wavelength, _Wave3Speed, _Steepness, _Wave3Direction, 3.0, offset, norm);

			v.vertex.xyz = lerp(v.vertex.xyz, offset, _OffsetStrength);
			v.normal.xyz = normalize(lerp(v.normal, norm, _NormalStrength));
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
