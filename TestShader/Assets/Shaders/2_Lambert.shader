Shader "kokichi/2_Lambert" {
	Properties {
		_Color("Color", Color) = (1,1,1,1)
	
	}
	
	SubShader{
		Pass {
			Tags {"LightMode" = "ForwardBase"}
			CGPROGRAM
			
			// pragmas
			#pragma vertex vert
			#pragma fragment frag
			
			// user defined variables
			uniform float4 _Color;
			uniform float4 _LightColor0;
			// base input structs
			struct vertexInput {
				float4 vertex : POSITION;
				float3 normal : NORMAL;
			};
			
			struct vertexOutput {
				float4 pos : SV_POSITION;
				float4 col : COLOR;
			};
			// vertex function
			vertexOutput vert(vertexInput v) {
				vertexOutput o;
				
				float3 normalDir =normalize( mul(float4(v.normal,0.0), _World2Object).xyz );
				float atten = 1;
				float3 lightDir = normalize ( _WorldSpaceLightPos0.xyz);
				float3 diffuseReflection = dot(normalDir, lightDir);
				
				o.col = float4(diffuseReflection,1.0);
				o.pos = mul(UNITY_MATRIX_MVP, v.vertex);
				return o;
			}
			
			float4 frag(vertexOutput o) : COLOR {
				return o.col;
			}
			// fragment function
			
			
			ENDCG	
		
		}
	
	}

}