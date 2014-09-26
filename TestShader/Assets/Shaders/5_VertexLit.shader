Shader "kokichi/5_VertexLit" {
	Properties {
		_MainTex ("Base (RGB)", 2D) = "white" {}
	}
	SubShader 
	{
		
		Pass
		{
			Tags { "LightMode" = "ForwardBase" }
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#include "UnityCG.cginc"
			#include "Lighting.cginc"
			sampler2D _MainTex;
			float4 _MainTex_ST;
			
			struct appdata 
			{
				float4 vertex : POSITION;
				float2 texcoord : TEXCOORD0;
				float3 normal : NORMAL;
			};
			
			struct v2f
			{
				float4 pos : SV_POSITION;
				float2 uv : TEXCOORD0;
				float4 color : COLOR0;
			};
			
			v2f vert(appdata v)
			{
				v2f o;
				o.pos = mul(UNITY_MATRIX_MVP, v.vertex);
				o.uv = TRANSFORM_TEX (v.texcoord, _MainTex);
//				o.uv = v.texcoord;
				float3 normalDirection = normalize(float3(mul(float4(v.normal, 0.0), _World2Object)));

				float3 lightDirection = normalize(float3(_WorldSpaceLightPos0));

				float3 diffuseReflection = float3(_LightColor0) * max(0.0, dot(normalDirection, lightDirection));

				o.color = float4(diffuseReflection, 1.0) + UNITY_LIGHTMODEL_AMBIENT;
				return o;
				
			}
			
			fixed4 frag(v2f i) : COLOR0
			{
				return tex2D (_MainTex, i.uv) * i.color;
			}
			
			ENDCG
		}
		
	} 
	FallBack "Diffuse"
}
