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
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" }
		Cull Back
		CGPROGRAM
		#pragma target 3.0
		#include "../Gerstner/GerstnerWave.cginc"
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows vertex:vertexDataFunc 
		struct Input
		{
			float3 worldPos;
		};

		uniform float4 _wave1;
		uniform float2 _dir1;
		uniform float4 _wave2;
		uniform float2 _dir2;
		uniform float4 _wave3;
		uniform float2 _dir3;
		uniform float _Strength;

		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			float localMyCustomExpression9_g3 = ( 0.0 );
			float3 ase_worldPos = mul( unity_ObjectToWorld, v.vertex );
			float2 appendResult12_g3 = (float2(ase_worldPos.x , ase_worldPos.z));
			float2 worldPos9_g3 = appendResult12_g3;
			float amplitude9_g3 = _wave1.x;
			float wavelength9_g3 = _wave1.y;
			float speed9_g3 = _wave1.z;
			float steepness9_g3 = _wave1.w;
			int numWaves14 = 3;
			int numWaves9_g3 = (int)(float)numWaves14;
			float2 direction9_g3 = _dir1;
			float3 vertexOffset9_g3 = float3( 0,0,0 );
			float3 vertexNormal9_g3 = float3( 0,0,0 );
			GerstnerWave(worldPos9_g3, amplitude9_g3, wavelength9_g3, speed9_g3, steepness9_g3, numWaves9_g3, direction9_g3, vertexOffset9_g3, vertexNormal9_g3);
			float localMyCustomExpression9_g1 = ( 0.0 );
			float2 appendResult12_g1 = (float2(ase_worldPos.x , ase_worldPos.z));
			float2 worldPos9_g1 = appendResult12_g1;
			float amplitude9_g1 = _wave2.x;
			float wavelength9_g1 = _wave2.y;
			float speed9_g1 = _wave2.z;
			float steepness9_g1 = _wave2.w;
			int numWaves9_g1 = (int)(float)numWaves14;
			float2 direction9_g1 = _dir2;
			float3 vertexOffset9_g1 = float3( 0,0,0 );
			float3 vertexNormal9_g1 = float3( 0,0,0 );
			GerstnerWave(worldPos9_g1, amplitude9_g1, wavelength9_g1, speed9_g1, steepness9_g1, numWaves9_g1, direction9_g1, vertexOffset9_g1, vertexNormal9_g1);
			float localMyCustomExpression9_g2 = ( 0.0 );
			float2 appendResult12_g2 = (float2(ase_worldPos.x , ase_worldPos.z));
			float2 worldPos9_g2 = appendResult12_g2;
			float amplitude9_g2 = _wave3.x;
			float wavelength9_g2 = _wave3.y;
			float speed9_g2 = _wave3.z;
			float steepness9_g2 = _wave3.w;
			int numWaves9_g2 = (int)(float)numWaves14;
			float2 direction9_g2 = _dir3;
			float3 vertexOffset9_g2 = float3( 0,0,0 );
			float3 vertexNormal9_g2 = float3( 0,0,0 );
			GerstnerWave(worldPos9_g2, amplitude9_g2, wavelength9_g2, speed9_g2, steepness9_g2, numWaves9_g2, direction9_g2, vertexOffset9_g2, vertexNormal9_g2);
			float offset_strength46 = ( floor( saturate( ( ase_worldPos.y + -2 ) ) ) * _Strength );
			float3 lerpResult22 = lerp( float3( 0,0,0 ) , ( vertexOffset9_g3 + vertexOffset9_g1 + vertexOffset9_g2 ) , offset_strength46);
			v.vertex.xyz += lerpResult22;
			float3 ase_vertexNormal = v.normal.xyz;
			float3 appendResult11 = (float3((float)1 , (float)numWaves14 , (float)1));
			float3 normalizeResult19 = normalize( ( ( vertexNormal9_g3 + vertexNormal9_g1 + vertexNormal9_g2 ) / appendResult11 ) );
			float normal_strength24 = ( _Strength * ( 1.0 - round( v.texcoord.xy.x ) ) );
			float3 lerpResult20 = lerp( ase_vertexNormal , normalizeResult19 , normal_strength24);
			v.normal = lerpResult20;
		}

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16103
303;92;1216;650;2022.842;314.5769;1;True;False
Node;AmplifyShaderEditor.CommentaryNode;60;780.6044,-159.4453;Float;False;1106.704;605.5152;Masks;15;7;14;23;32;24;44;37;38;41;43;35;46;31;33;34;;1,1,1,1;0;0
Node;AmplifyShaderEditor.IntNode;44;866.6926,113.1207;Float;False;Constant;_2;-2;7;0;Create;True;0;0;False;0;-2;0;0;1;INT;0
Node;AmplifyShaderEditor.IntNode;7;1384.225,-109.4453;Float;False;Constant;_numWaves;numWaves;0;0;Create;True;0;0;False;0;3;0;0;1;INT;0
Node;AmplifyShaderEditor.WorldPosInputsNode;37;830.6045,-28.09265;Float;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.TextureCoordinatesNode;31;837.8466,290.07;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;14;1613.355,-108.6799;Float;False;numWaves;-1;True;1;0;INT;0;False;1;INT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;38;1035.947,63.36385;Float;False;2;2;0;FLOAT;0;False;1;INT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;25;-1509.784,295.4469;Float;False;14;numWaves;1;0;OBJECT;0;False;1;INT;0
Node;AmplifyShaderEditor.GetLocalVarNode;16;-1509.996,520.0895;Float;False;14;numWaves;1;0;OBJECT;0;False;1;INT;0
Node;AmplifyShaderEditor.Vector4Node;6;-1319.433,403.264;Float;False;Property;_wave3;wave3;5;0;Create;True;0;0;False;0;0,0,0,0;0,0,0,0;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector4Node;4;-1313.786,-45.82155;Float;False;Property;_wave1;wave1;1;0;Create;True;0;0;False;1;Gerstner();0,0,0,0;0,0,0,0;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector2Node;28;-1667.652,94.80181;Float;False;Property;_dir1;dir1;2;0;Create;True;0;0;False;0;0,0;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.Vector4Node;5;-1318.022,181.5457;Float;False;Property;_wave2;wave2;3;0;Create;True;0;0;False;0;0,0,0,0;0,0,0,0;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RoundOpNode;33;1084.911,312.6169;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;15;-1515.015,70.4448;Float;False;14;numWaves;1;0;OBJECT;0;False;1;INT;0
Node;AmplifyShaderEditor.Vector2Node;30;-1674.105,543.921;Float;False;Property;_dir3;dir3;6;0;Create;True;0;0;False;0;0,0;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.SaturateNode;41;1171.797,63.36372;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;29;-1668.964,322.8665;Float;False;Property;_dir2;dir2;4;0;Create;True;0;0;False;0;0,0;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.OneMinusNode;34;1214.436,312.6169;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;23;1096.18,170.1815;Float;False;Property;_Strength;Strength;0;0;Create;True;0;0;False;0;1;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;17;-626.5931,613.3231;Float;False;14;numWaves;1;0;OBJECT;0;False;1;INT;0
Node;AmplifyShaderEditor.IntNode;18;-581.9828,535.2567;Float;False;Constant;_Int1;Int 1;0;0;Create;True;0;0;False;0;1;0;0;1;INT;0
Node;AmplifyShaderEditor.FloorOpNode;43;1322.741,62.10591;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;61;-1064.444,184.8567;Float;False;GerstnerCGINC;-1;;1;9ad91cfb63db56e4db63f48388814e1e;0;7;1;FLOAT2;0,0;False;7;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;2;FLOAT2;0,0;False;2;FLOAT3;0;FLOAT3;8
Node;AmplifyShaderEditor.FunctionNode;62;-1060.199,407.7733;Float;False;GerstnerCGINC;-1;;2;9ad91cfb63db56e4db63f48388814e1e;0;7;1;FLOAT2;0,0;False;7;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;2;FLOAT2;0,0;False;2;FLOAT3;0;FLOAT3;8
Node;AmplifyShaderEditor.FunctionNode;63;-1064.41,-38.36185;Float;False;GerstnerCGINC;-1;;3;9ad91cfb63db56e4db63f48388814e1e;0;7;1;FLOAT2;0,0;False;7;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;2;FLOAT2;0,0;False;2;FLOAT3;0;FLOAT3;8
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;35;1460.435,61.31544;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;9;-370.5059,383.115;Float;False;3;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.DynamicAppendNode;11;-378.0229,517.3937;Float;False;FLOAT3;4;0;FLOAT;1;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;32;1460.685,219.158;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;10;-202.8993,439.1997;Float;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;24;1624.309,213.9102;Float;False;normal_strength;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;46;1622.614,56.5121;Float;False;offset_strength;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;8;-377.8549,112.1607;Float;False;3;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;47;-193.3876,132.5517;Float;False;46;offset_strength;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;26;-129.8273,531.8073;Float;False;24;normal_strength;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.NormalVertexDataNode;21;-85.89602,287.6164;Float;False;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.NormalizeNode;19;-55.60468,439.0724;Float;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.LerpOp;22;42.84189,90.72327;Float;False;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.LerpOp;20;146.9679,359.558;Float;False;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;375.6402,-59.47801;Float;False;True;2;Float;ASEMaterialInspector;0;0;Standard;GerstnerExample;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;14;0;7;0
WireConnection;38;0;37;2
WireConnection;38;1;44;0
WireConnection;33;0;31;1
WireConnection;41;0;38;0
WireConnection;34;0;33;0
WireConnection;43;0;41;0
WireConnection;61;7;5;1
WireConnection;61;3;5;2
WireConnection;61;4;5;3
WireConnection;61;5;5;4
WireConnection;61;6;25;0
WireConnection;61;2;29;0
WireConnection;62;7;6;1
WireConnection;62;3;6;2
WireConnection;62;4;6;3
WireConnection;62;5;6;4
WireConnection;62;6;16;0
WireConnection;62;2;30;0
WireConnection;63;7;4;1
WireConnection;63;3;4;2
WireConnection;63;4;4;3
WireConnection;63;5;4;4
WireConnection;63;6;15;0
WireConnection;63;2;28;0
WireConnection;35;0;43;0
WireConnection;35;1;23;0
WireConnection;9;0;63;8
WireConnection;9;1;61;8
WireConnection;9;2;62;8
WireConnection;11;0;18;0
WireConnection;11;1;17;0
WireConnection;11;2;18;0
WireConnection;32;0;23;0
WireConnection;32;1;34;0
WireConnection;10;0;9;0
WireConnection;10;1;11;0
WireConnection;24;0;32;0
WireConnection;46;0;35;0
WireConnection;8;0;63;0
WireConnection;8;1;61;0
WireConnection;8;2;62;0
WireConnection;19;0;10;0
WireConnection;22;1;8;0
WireConnection;22;2;47;0
WireConnection;20;0;21;0
WireConnection;20;1;19;0
WireConnection;20;2;26;0
WireConnection;0;11;22;0
WireConnection;0;12;20;0
ASEEND*/
//CHKSM=1C4F691D84EFDBB57A30F93A6CA0EA561201E19C