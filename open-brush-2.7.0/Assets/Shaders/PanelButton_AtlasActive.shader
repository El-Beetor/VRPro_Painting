// Copyright 2020 The Tilt Brush Authors
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

Shader "Custom/PanelButton_AtlasActive" {
  Properties {
    _Color ("Main Color", Color) = (1,1,1,1)
    _MainTex ("Texture", 2D) = "white" {}
    _Cutoff ("Alpha cutoff", Range(0,1)) = 0.5
  }
  SubShader {
    Tags {"Queue"="AlphaTest+20" "IgnoreProjector"="True" "RenderType"="TransparentCutout"}

    Pass {
      Lighting Off

      CGPROGRAM
      #pragma vertex vert
      #pragma fragment frag
      #pragma multi_compile __ HDR_EMULATED HDR_SIMPLE
      #include "Assets/Shaders/Include/Brush.cginc"
      #include "Assets/Shaders/Include/Hdr.cginc"
      #include "UnityCG.cginc"

      sampler2D _MainTex;
      float4 _Color;
      float _Cutoff;
      float2 _Dimensions;
      float2 _TextureDim;
      float _Padding;
      float _BorderPercent;
      uniform float _PanelMipmapBias;

      struct appdata_t {
        float4 vertex : POSITION;
        float2 texcoord : TEXCOORD0;
      };

      struct v2f {
        float4 vertex : POSITION;
        float4 texcoord : TEXCOORD0;
      };

      v2f vert (appdata_t v)
      {
        v2f o;
        o.vertex = UnityObjectToClipPos(v.vertex);
        o.texcoord = float4(v.texcoord.xy, 0, _PanelMipmapBias);
        return o;
      }

      fixed4 frag (v2f i) : COLOR
      {
        float2 naturalspan = _TextureDim / _Dimensions;

        // Build in padding in to texture segmenting.
        float2 texDim = _TextureDim + _Padding;
        float2 stride = _Dimensions / texDim;
        float2 span = 1 / stride;
        float2 halfSpan = span * 0.5;
        float2 border = halfSpan * _BorderPercent;

        fixed4 c = tex2Dbias(_MainTex, i.texcoord);
        float modx = fmod(i.texcoord.x, span.x);
        float mody = fmod(i.texcoord.y, span.y);
        if( (modx > border.x) &&
            (modx < naturalspan.x - border.x) &&
            (mody > border.y) &&
            (mody < naturalspan.y - border.y))
        {
            c.rgb = .5 - c.rgb;
        }
        else
        {
            c.rgb = 1;
        }

        if (c.a < _Cutoff) discard;
        c.rgb *= _Color.rgb;

        return encodeHdr(saturate(c.rgb * c.a));
      }
      ENDCG
    }
  }
  FallBack "Diffuse"
}

