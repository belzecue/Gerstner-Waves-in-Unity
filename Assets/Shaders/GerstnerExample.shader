// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "GerstnerExample"
{
	Properties
	{
		_Strength("Strength", Range( 0 , 1)) = 1
		[Gerstner()]_wave1("wave1", Vector) = (0,0,0,0)
		_dir1("dir1", Vector) = (0,0,0,0)
		_wave2("wave2", Vector) = (0,0,0,0)
		_dir2("dir2", Vector) = (0,0,0,0)
		_wave3("wave3", Vector) = (0,0,0,0)
		_dir3("dir3", Vector) = (0,0,0,0)
		[Toggle(_MODULATESTRENGTHBYDEPTH_ON)] _ModulateStrengthByDepth("ModulateStrengthByDepth", Float) = 0
		_DepthModulationStrength("DepthModulationStrength", Range( 0 , 1)) = 1
		_DepthOffset("Depth Offset", Float) = 0
		_DepthMultiplier("Depth Multiplier", Float) = 1
		_MainDepth("MainDepth", Float) = 0
		_Color1("Color1", Color) = (0,0,0,0)
		_Color2("Color2", Color) = (0,0,0,0)
		_SmallDepth("SmallDepth", Float) = 0
		_SmallOffset("SmallOffset", Float) = 0
		_SmallColor("SmallColor", Color) = (0,0,0,0)
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Transparent"  "Queue" = "Transparent+0" "IgnoreProjector" = "True" }
		Cull Back
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#include "UnityCG.cginc"
		#pragma target 3.0
		#pragma shader_feature _MODULATESTRENGTHBYDEPTH_ON
		#pragma surface surf Standard alpha:fade keepalpha addshadow fullforwardshadows vertex:vertexDataFunc 
		struct Input
		{
			float3 worldPos;
			float4 screenPosition101;
			float4 screenPosition95;
		};

		uniform float2 _dir1;
		uniform float4 _wave1;
		uniform float2 _dir2;
		uniform float4 _wave2;
		uniform float2 _dir3;
		uniform float4 _wave3;
		uniform float _Strength;
		uniform float _DepthOffset;
		uniform float _DepthMultiplier;
		uniform float _DepthModulationStrength;
		uniform sampler2D _CameraDepthTexture;
		uniform float _SmallDepth;
		uniform float _SmallOffset;
		uniform float4 _SmallColor;
		uniform float4 _Color1;
		uniform float4 _Color2;
		uniform float _MainDepth;

		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			float3 ase_worldPos = mul( unity_ObjectToWorld, v.vertex );
			float2 appendResult180_g1 = (float2(ase_worldPos.x , ase_worldPos.z));
			float2 pos35_g1 = appendResult180_g1;
			float2 normalizeResult4_g1 = normalize( _dir1 );
			float2 dir36_g1 = normalizeResult4_g1;
			float dotResult39_g1 = dot( pos35_g1 , dir36_g1 );
			float wavenumber37_g1 = ( 6.28318548202515 / _wave1.y );
			float mulTime16_g1 = _Time.y * _wave1.z;
			float phasetime38_g1 = mulTime16_g1;
			float temp_output_44_0_g1 = ( ( dotResult39_g1 * wavenumber37_g1 ) + phasetime38_g1 );
			float amplitude53_g1 = _wave1.x;
			int numWaves14 = 3;
			float temp_output_130_0_g1 = (float)numWaves14;
			float Q54_g1 = ( _wave1.w / ( wavenumber37_g1 * amplitude53_g1 * temp_output_130_0_g1 ) );
			float2 temp_output_56_0_g1 = ( cos( temp_output_44_0_g1 ) * amplitude53_g1 * Q54_g1 * dir36_g1 );
			float3 appendResult65_g1 = (float3(temp_output_56_0_g1 , ( sin( temp_output_44_0_g1 ) * amplitude53_g1 * 2 )));
			float2 appendResult180_g2 = (float2(ase_worldPos.x , ase_worldPos.z));
			float2 pos35_g2 = appendResult180_g2;
			float2 normalizeResult4_g2 = normalize( _dir2 );
			float2 dir36_g2 = normalizeResult4_g2;
			float dotResult39_g2 = dot( pos35_g2 , dir36_g2 );
			float wavenumber37_g2 = ( 6.28318548202515 / _wave2.y );
			float mulTime16_g2 = _Time.y * _wave2.z;
			float phasetime38_g2 = mulTime16_g2;
			float temp_output_44_0_g2 = ( ( dotResult39_g2 * wavenumber37_g2 ) + phasetime38_g2 );
			float amplitude53_g2 = _wave2.x;
			float temp_output_130_0_g2 = (float)numWaves14;
			float Q54_g2 = ( _wave2.w / ( wavenumber37_g2 * amplitude53_g2 * temp_output_130_0_g2 ) );
			float2 temp_output_56_0_g2 = ( cos( temp_output_44_0_g2 ) * amplitude53_g2 * Q54_g2 * dir36_g2 );
			float3 appendResult65_g2 = (float3(temp_output_56_0_g2 , ( sin( temp_output_44_0_g2 ) * amplitude53_g2 * 2 )));
			float2 appendResult180_g3 = (float2(ase_worldPos.x , ase_worldPos.z));
			float2 pos35_g3 = appendResult180_g3;
			float2 normalizeResult4_g3 = normalize( _dir3 );
			float2 dir36_g3 = normalizeResult4_g3;
			float dotResult39_g3 = dot( pos35_g3 , dir36_g3 );
			float wavenumber37_g3 = ( 6.28318548202515 / _wave3.y );
			float mulTime16_g3 = _Time.y * _wave3.z;
			float phasetime38_g3 = mulTime16_g3;
			float temp_output_44_0_g3 = ( ( dotResult39_g3 * wavenumber37_g3 ) + phasetime38_g3 );
			float amplitude53_g3 = _wave3.x;
			float temp_output_130_0_g3 = (float)numWaves14;
			float Q54_g3 = ( _wave3.w / ( wavenumber37_g3 * amplitude53_g3 * temp_output_130_0_g3 ) );
			float2 temp_output_56_0_g3 = ( cos( temp_output_44_0_g3 ) * amplitude53_g3 * Q54_g3 * dir36_g3 );
			float3 appendResult65_g3 = (float3(temp_output_56_0_g3 , ( sin( temp_output_44_0_g3 ) * amplitude53_g3 * 2 )));
			#ifdef _MODULATESTRENGTHBYDEPTH_ON
				float staticSwitch86 = saturate( ( saturate( ( ( v.color.r + _DepthOffset ) * _DepthMultiplier ) ) + ( 1.0 - _DepthModulationStrength ) ) );
			#else
				float staticSwitch86 = (float)1;
			#endif
			float depthMask85 = staticSwitch86;
			float offset_strength46 = ( floor( saturate( ( ase_worldPos.y + -2 ) ) ) * _Strength * depthMask85 );
			float3 lerpResult22 = lerp( float3( 0,0,0 ) , ( (appendResult65_g1).xzy + (appendResult65_g2).xzy + (appendResult65_g3).xzy ) , offset_strength46);
			v.vertex.xyz += lerpResult22;
			float3 ase_vertexNormal = v.normal.xyz;
			float dotResult91_g1 = dot( ( pos35_g1 + temp_output_56_0_g1 ) , dir36_g1 );
			float temp_output_95_0_g1 = ( ( dotResult91_g1 * wavenumber37_g1 ) + phasetime38_g1 );
			float c0135_g1 = cos( temp_output_95_0_g1 );
			float WA142_g1 = ( wavenumber37_g1 * amplitude53_g1 );
			float s0134_g1 = sin( temp_output_95_0_g1 );
			float3 appendResult123_g1 = (float3(( -1 * ( ( c0135_g1 * WA142_g1 ) * dir36_g1 ) ) , ( 1.0 - ( Q54_g1 * ( WA142_g1 * s0134_g1 ) ) )));
			float3 appendResult191_g1 = (float3(1.0 , temp_output_130_0_g1 , 1.0));
			float3 normalizeResult188_g1 = normalize( ( (appendResult123_g1).xzy / appendResult191_g1 ) );
			float dotResult91_g2 = dot( ( pos35_g2 + temp_output_56_0_g2 ) , dir36_g2 );
			float temp_output_95_0_g2 = ( ( dotResult91_g2 * wavenumber37_g2 ) + phasetime38_g2 );
			float c0135_g2 = cos( temp_output_95_0_g2 );
			float WA142_g2 = ( wavenumber37_g2 * amplitude53_g2 );
			float s0134_g2 = sin( temp_output_95_0_g2 );
			float3 appendResult123_g2 = (float3(( -1 * ( ( c0135_g2 * WA142_g2 ) * dir36_g2 ) ) , ( 1.0 - ( Q54_g2 * ( WA142_g2 * s0134_g2 ) ) )));
			float3 appendResult191_g2 = (float3(1.0 , temp_output_130_0_g2 , 1.0));
			float3 normalizeResult188_g2 = normalize( ( (appendResult123_g2).xzy / appendResult191_g2 ) );
			float dotResult91_g3 = dot( ( pos35_g3 + temp_output_56_0_g3 ) , dir36_g3 );
			float temp_output_95_0_g3 = ( ( dotResult91_g3 * wavenumber37_g3 ) + phasetime38_g3 );
			float c0135_g3 = cos( temp_output_95_0_g3 );
			float WA142_g3 = ( wavenumber37_g3 * amplitude53_g3 );
			float s0134_g3 = sin( temp_output_95_0_g3 );
			float3 appendResult123_g3 = (float3(( -1 * ( ( c0135_g3 * WA142_g3 ) * dir36_g3 ) ) , ( 1.0 - ( Q54_g3 * ( WA142_g3 * s0134_g3 ) ) )));
			float3 appendResult191_g3 = (float3(1.0 , temp_output_130_0_g3 , 1.0));
			float3 normalizeResult188_g3 = normalize( ( (appendResult123_g3).xzy / appendResult191_g3 ) );
			float3 appendResult11 = (float3((float)1 , (float)numWaves14 , (float)1));
			float3 normalizeResult19 = normalize( ( ( normalizeResult188_g1 + normalizeResult188_g2 + normalizeResult188_g3 ) / appendResult11 ) );
			float normal_strength24 = ( _Strength * depthMask85 * ( 1.0 - round( v.texcoord.xy.x ) ) );
			float3 lerpResult20 = lerp( ase_vertexNormal , normalizeResult19 , normal_strength24);
			v.normal = lerpResult20;
			float3 ase_vertex3Pos = v.vertex.xyz;
			float3 vertexPos101 = ase_vertex3Pos;
			float4 ase_screenPos101 = ComputeScreenPos( UnityObjectToClipPos( v.vertex ) );
			o.screenPosition101 = ase_screenPos101;
			float3 vertexPos95 = ase_vertex3Pos;
			float4 ase_screenPos95 = ComputeScreenPos( UnityObjectToClipPos( v.vertex ) );
			o.screenPosition95 = ase_screenPos95;
		}

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float4 ase_screenPos101 = i.screenPosition101;
			float4 ase_screenPosNorm101 = ase_screenPos101 / ase_screenPos101.w;
			ase_screenPosNorm101.z = ( UNITY_NEAR_CLIP_VALUE >= 0 ) ? ase_screenPosNorm101.z : ase_screenPosNorm101.z * 0.5 + 0.5;
			float screenDepth101 = LinearEyeDepth(UNITY_SAMPLE_DEPTH(tex2Dproj(_CameraDepthTexture,UNITY_PROJ_COORD( ase_screenPos101 ))));
			float distanceDepth101 = abs( ( screenDepth101 - LinearEyeDepth( ase_screenPosNorm101.z ) ) / ( _SmallDepth ) );
			float3 ase_worldPos = i.worldPos;
			float lerpResult108 = lerp( 0.0 , ( 1.0 - saturate( distanceDepth101 ) ) , round( saturate( ( ase_worldPos.y + _SmallOffset ) ) ));
			float4 ase_screenPos95 = i.screenPosition95;
			float4 ase_screenPosNorm95 = ase_screenPos95 / ase_screenPos95.w;
			ase_screenPosNorm95.z = ( UNITY_NEAR_CLIP_VALUE >= 0 ) ? ase_screenPosNorm95.z : ase_screenPosNorm95.z * 0.5 + 0.5;
			float screenDepth95 = LinearEyeDepth(UNITY_SAMPLE_DEPTH(tex2Dproj(_CameraDepthTexture,UNITY_PROJ_COORD( ase_screenPos95 ))));
			float distanceDepth95 = abs( ( screenDepth95 - LinearEyeDepth( ase_screenPosNorm95.z ) ) / ( _MainDepth ) );
			float4 lerpResult99 = lerp( _Color1 , _Color2 , saturate( distanceDepth95 ));
			o.Albedo = ( ( lerpResult108 * _SmallColor ) + lerpResult99 ).rgb;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16103
303;92;1205;650;-289.8479;-199.3273;2.075382;True;False
Node;AmplifyShaderEditor.VertexColorNode;72;809.4486,621.5198;Float;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;81;811.6109,792.8157;Float;False;Property;_DepthOffset;Depth Offset;9;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;80;1117.818,708.9729;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;83;1055.849,816.5106;Float;False;Property;_DepthMultiplier;Depth Multiplier;10;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;76;1150.302,895.7382;Float;False;Property;_DepthModulationStrength;DepthModulationStrength;8;0;Create;True;0;0;False;0;1;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;82;1303.731,745.4265;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;84;1465.949,760.0078;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;77;1457.657,901.4387;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;75;1655.192,815.0632;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;60;1691.866,-129.6205;Float;False;1106.704;605.5152;Masks;16;7;14;23;32;24;44;37;38;41;43;35;46;31;33;34;88;;1,1,1,1;0;0
Node;AmplifyShaderEditor.IntNode;44;1777.954,142.9455;Float;False;Constant;_2;-2;7;0;Create;True;0;0;False;0;-2;0;0;1;INT;0
Node;AmplifyShaderEditor.IntNode;87;1786.857,738.3595;Float;False;Constant;_Int0;Int 0;11;0;Create;True;0;0;False;0;1;0;0;1;INT;0
Node;AmplifyShaderEditor.SaturateNode;78;1788.354,814.9254;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.IntNode;7;2295.487,-79.6205;Float;False;Constant;_numWaves;numWaves;0;0;Create;True;0;0;False;0;3;0;0;1;INT;0
Node;AmplifyShaderEditor.WorldPosInputsNode;37;1741.866,1.732141;Float;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.StaticSwitch;86;1945.242,759.4777;Float;False;Property;_ModulateStrengthByDepth;ModulateStrengthByDepth;7;0;Create;True;0;0;False;0;0;0;0;True;;Toggle;2;Key0;Key1;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WorldPosInputsNode;109;-518.6542,-837.4724;Float;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.TextureCoordinatesNode;31;1749.108,319.8948;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;38;1947.209,93.18863;Float;False;2;2;0;FLOAT;0;False;1;INT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PosVertexDataNode;94;-922.1946,-568.2352;Float;False;0;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;102;-651.9388,-548.603;Float;False;Property;_SmallDepth;SmallDepth;14;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;112;-495.0166,-685.0557;Float;False;Property;_SmallOffset;SmallOffset;15;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;14;2524.617,-78.8551;Float;False;numWaves;-1;True;1;0;INT;0;False;1;INT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;111;-307.179,-743.4623;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;15;-1515.015,70.4448;Float;False;14;numWaves;1;0;OBJECT;0;False;1;INT;0
Node;AmplifyShaderEditor.Vector2Node;28;-1667.652,94.80181;Float;False;Property;_dir1;dir1;2;0;Create;True;0;0;False;0;0,0;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.GetLocalVarNode;25;-1509.784,295.4469;Float;False;14;numWaves;1;0;OBJECT;0;False;1;INT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;85;2297.643,760.3047;Float;False;depthMask;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector4Node;5;-1318.022,181.5457;Float;False;Property;_wave2;wave2;3;0;Create;True;0;0;False;0;0,0,0,0;0,0,0,0;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector2Node;29;-1668.964,322.8665;Float;False;Property;_dir2;dir2;4;0;Create;True;0;0;False;0;0,0;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.DepthFade;101;-474.2825,-567.7125;Float;False;True;False;True;2;1;FLOAT3;0,0,0;False;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;41;2083.059,93.1885;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector4Node;4;-1313.786,-45.82155;Float;False;Property;_wave1;wave1;1;0;Create;True;0;0;False;1;Gerstner();0,0,0,0;0,0,0,0;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector2Node;30;-1674.105,543.921;Float;False;Property;_dir3;dir3;6;0;Create;True;0;0;False;0;0,0;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.Vector4Node;6;-1319.433,403.264;Float;False;Property;_wave3;wave3;5;0;Create;True;0;0;False;0;0,0,0,0;0,0,0,0;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RoundOpNode;33;1996.173,342.4417;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;16;-1509.996,520.0895;Float;False;14;numWaves;1;0;OBJECT;0;False;1;INT;0
Node;AmplifyShaderEditor.GetLocalVarNode;17;-626.5931,613.3231;Float;False;14;numWaves;1;0;OBJECT;0;False;1;INT;0
Node;AmplifyShaderEditor.FloorOpNode;43;2234.003,91.93069;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;114;-1070.835,-40.64326;Float;False;GerstnerWave;-1;;1;bc47a58e99aa84ed68298787d2bd041f;0;7;106;FLOAT2;0,0;False;52;FLOAT;0;False;9;FLOAT;0;False;17;FLOAT;0;False;46;FLOAT;0;False;130;FLOAT;0;False;5;FLOAT2;0,0;False;2;FLOAT3;28;FLOAT3;124
Node;AmplifyShaderEditor.GetLocalVarNode;88;2087.137,252.4085;Float;False;85;depthMask;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;23;2007.442,176.0063;Float;False;Property;_Strength;Strength;0;0;Create;True;0;0;False;0;1;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.IntNode;18;-581.9828,535.2567;Float;False;Constant;_Int1;Int 1;0;0;Create;True;0;0;False;0;1;0;0;1;INT;0
Node;AmplifyShaderEditor.SaturateNode;103;-216.7369,-567.7647;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;116;-1069.805,407.073;Float;False;GerstnerWave;-1;;3;bc47a58e99aa84ed68298787d2bd041f;0;7;106;FLOAT2;0,0;False;52;FLOAT;0;False;9;FLOAT;0;False;17;FLOAT;0;False;46;FLOAT;0;False;130;FLOAT;0;False;5;FLOAT2;0,0;False;2;FLOAT3;28;FLOAT3;124
Node;AmplifyShaderEditor.FunctionNode;115;-1069.505,185.9939;Float;False;GerstnerWave;-1;;2;bc47a58e99aa84ed68298787d2bd041f;0;7;106;FLOAT2;0,0;False;52;FLOAT;0;False;9;FLOAT;0;False;17;FLOAT;0;False;46;FLOAT;0;False;130;FLOAT;0;False;5;FLOAT2;0,0;False;2;FLOAT3;28;FLOAT3;124
Node;AmplifyShaderEditor.OneMinusNode;34;2125.698,342.4417;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;97;-678.9993,-287.9858;Float;False;Property;_MainDepth;MainDepth;11;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;113;-176.0633,-742.6104;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;9;-370.5059,383.115;Float;False;3;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;32;2371.948,248.9828;Float;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;104;-40.81148,-568.0948;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RoundOpNode;110;-8.844319,-741.4032;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;11;-378.0229,517.3937;Float;False;FLOAT3;4;0;FLOAT;1;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;35;2371.698,91.14022;Float;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DepthFade;95;-482.36,-305.7368;Float;False;True;False;True;2;1;FLOAT3;0,0,0;False;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;10;-202.8993,439.1997;Float;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ColorNode;106;147.03,-518.8619;Float;False;Property;_SmallColor;SmallColor;16;0;Create;True;0;0;False;0;0,0,0,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SaturateNode;98;-215.7143,-305.2848;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;24;2535.571,243.735;Float;False;normal_strength;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;89;-38.43452,-186.9936;Float;False;Property;_Color2;Color2;13;0;Create;True;0;0;False;0;0,0,0,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;100;-36.3362,-354.7818;Float;False;Property;_Color1;Color1;12;0;Create;True;0;0;False;0;0,0,0,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;108;185.9537,-672.1857;Float;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;46;2533.876,86.33688;Float;False;offset_strength;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;105;387.6509,-582.8995;Float;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;26;-129.8273,531.8073;Float;False;24;normal_strength;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;47;-193.3876,132.5517;Float;False;46;offset_strength;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;99;360.3365,-350.5227;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.NormalVertexDataNode;21;-85.89602,287.6164;Float;False;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.NormalizeNode;19;-55.60468,439.0724;Float;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleAddOpNode;8;-377.8549,112.1607;Float;False;3;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleAddOpNode;107;572.4927,-470.6146;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;20;146.9679,359.558;Float;False;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.LerpOp;22;42.84189,90.72327;Float;False;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;860.6569,-187.9148;Float;False;True;2;Float;ASEMaterialInspector;0;0;Standard;GerstnerExample;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Transparent;0.5;True;True;0;False;Transparent;;Transparent;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;2;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;80;0;72;1
WireConnection;80;1;81;0
WireConnection;82;0;80;0
WireConnection;82;1;83;0
WireConnection;84;0;82;0
WireConnection;77;0;76;0
WireConnection;75;0;84;0
WireConnection;75;1;77;0
WireConnection;78;0;75;0
WireConnection;86;1;87;0
WireConnection;86;0;78;0
WireConnection;38;0;37;2
WireConnection;38;1;44;0
WireConnection;14;0;7;0
WireConnection;111;0;109;2
WireConnection;111;1;112;0
WireConnection;85;0;86;0
WireConnection;101;1;94;0
WireConnection;101;0;102;0
WireConnection;41;0;38;0
WireConnection;33;0;31;1
WireConnection;43;0;41;0
WireConnection;114;52;4;1
WireConnection;114;9;4;2
WireConnection;114;17;4;3
WireConnection;114;46;4;4
WireConnection;114;130;15;0
WireConnection;114;5;28;0
WireConnection;103;0;101;0
WireConnection;116;52;6;1
WireConnection;116;9;6;2
WireConnection;116;17;6;3
WireConnection;116;46;6;4
WireConnection;116;130;16;0
WireConnection;116;5;30;0
WireConnection;115;52;5;1
WireConnection;115;9;5;2
WireConnection;115;17;5;3
WireConnection;115;46;5;4
WireConnection;115;130;25;0
WireConnection;115;5;29;0
WireConnection;34;0;33;0
WireConnection;113;0;111;0
WireConnection;9;0;114;124
WireConnection;9;1;115;124
WireConnection;9;2;116;124
WireConnection;32;0;23;0
WireConnection;32;1;88;0
WireConnection;32;2;34;0
WireConnection;104;0;103;0
WireConnection;110;0;113;0
WireConnection;11;0;18;0
WireConnection;11;1;17;0
WireConnection;11;2;18;0
WireConnection;35;0;43;0
WireConnection;35;1;23;0
WireConnection;35;2;88;0
WireConnection;95;1;94;0
WireConnection;95;0;97;0
WireConnection;10;0;9;0
WireConnection;10;1;11;0
WireConnection;98;0;95;0
WireConnection;24;0;32;0
WireConnection;108;1;104;0
WireConnection;108;2;110;0
WireConnection;46;0;35;0
WireConnection;105;0;108;0
WireConnection;105;1;106;0
WireConnection;99;0;100;0
WireConnection;99;1;89;0
WireConnection;99;2;98;0
WireConnection;19;0;10;0
WireConnection;8;0;114;28
WireConnection;8;1;115;28
WireConnection;8;2;116;28
WireConnection;107;0;105;0
WireConnection;107;1;99;0
WireConnection;20;0;21;0
WireConnection;20;1;19;0
WireConnection;20;2;26;0
WireConnection;22;1;8;0
WireConnection;22;2;47;0
WireConnection;0;0;107;0
WireConnection;0;11;22;0
WireConnection;0;12;20;0
ASEEND*/
//CHKSM=FE0EDC50BC26ED4D950C8387ED29A87214CB179B