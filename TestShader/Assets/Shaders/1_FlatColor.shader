﻿Shader "kokichi/1_FlatColor" {
	Properties {
		_Color("Color", Color) = (1.0,1.0,1.0,1.0)
	}
	
	SubShader {
		Pass {
			CGPROGRAM
			
			// pragmas
			#pragma vertex vert
			#pragma fragment frag
			
			// user defined variables
			uniform float4 _Color;
			
			// base input structs
			struct vertexInput {
				float4 vertex : POSITION;
			
			};
			
			struct vertexOutput {
				float4 pos : SV_POSITION;
			};
			// vertex function
			vertexOutput vert(vertexInput v) {
				vertexOutput o;
				o.pos = mul(UNITY_MATRIX_MVP, v.vertex);
				return o;
			}
			
			float4 frag(vertexOutput o) : COLOR {
				return _Color;
			}
			// fragment function
			
			
			ENDCG
		
		}
	
	}

}