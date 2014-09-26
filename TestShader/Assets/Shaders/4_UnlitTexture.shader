Shader "kokichi/4_UnlitTexture" {
	Properties {
		_MainTex ("Base (RGB)", 2D) = "white" {}
	}
	SubShader 
	{
		
		Pass
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#include "UnityCG.cginc"
			
			sampler2D _MainTex;
			float4 _MainTex_ST;
			
			struct appdata 
			{
				float4 vertex : POSITION;
				float2 texcoord : TEXCOORD0;
			};
			
			struct v2f
			{
				float4 pos : SV_POSITION;
				float2 uv : TEXCOORD0;
			};
			
			v2f vert(appdata v)
			{
				v2f o;
				o.pos = mul(UNITY_MATRIX_MVP, v.vertex);
				o.uv = TRANSFORM_TEX (v.texcoord, _MainTex);
//				o.uv = v.texcoord;
				return o;
				
			}
			
			fixed4 frag(v2f i) : COLOR0
			{
				return tex2D (_MainTex, i.uv);
			}
			
			ENDCG
		}
		
	} 
	FallBack "Diffuse"
}
