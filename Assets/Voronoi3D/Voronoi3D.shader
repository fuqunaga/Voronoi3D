Shader "Custom/Voronoi3D"
{
	Properties
	{
		_pointData ("PointData", 2D) = "black" {}
		_pointNum("PointNum", int) = 0
		_pointScale("PointScale", float) = 1.0
		_pointOffset("PointOffset", Vector) = (0.0, 0.0, 0.0, 0.0)
	}

	SubShader
	{
		Tags
		{ 
			"Queue"="Transparent" 
			"PreviewType"="Plane"
			 "RenderType"="Transparent"
		}

		Cull Off
		Lighting Off
		ZWrite Off
		Fog { Mode Off }
		Blend SrcAlpha OneMinusSrcAlpha
		Pass
		{
		CGPROGRAM
			#pragma glsl
			#pragma vertex vert
			#pragma fragment frag
			#include "UnityCG.cginc"
			
			
			
			uniform sampler2D _pointData;
			uniform int _pointNum;
			uniform float _pointScale;
			uniform float3 _pointOffset;


			struct v2f
			{
				float4 vertex   : SV_POSITION;
				float4 posW	  : COLOR0;
			};
			
			v2f vert(appdata_base IN)
			{
				v2f o;
				o.vertex = mul(UNITY_MATRIX_MVP, IN.vertex);
				o.posW = mul(_Object2World, IN.vertex);
				
				
				return o;
			}			
			float4 frag(v2f IN) : COLOR
			{
				float3 pos = tex2D(_pointData, float2(0.0,0.0)).xyz;
				float distMin = distance(pos, IN.posW);
				float4 col = tex2D(_pointData, float2((float)0/_pointNum, 1.0));
			
				for(int i=1; i<_pointNum; i++)
				{
					float3 pos = tex2D(_pointData, float2((float)i/_pointNum, 0.0)).xyz * _pointScale + _pointOffset;
					float dist = distance(pos, IN.posW);
					if ( dist < distMin)
					{
						col = tex2D(_pointData, float2((float)i/_pointNum, 1.0));
					}
				}
				
				return col;
			}
		ENDCG
		}
	}
	
	Fallback Off
}
