struct VS_IN
{
	float4 pos : POSITION;
	float4 uv : TEXCOORD0;

};

struct vs2ps
{
    float4 pos : SV_Position;
    float4 uv : TEXCOORD0;
};

vs2ps VS(VS_IN input)
{
    return input;
}

float getHue(float3 rgb)
{
	float r = rgb.r;
	float g = rgb.g;
	float b = rgb.b;
	float biglyChannel = max(r, max(g, b));
	float small = min(r, min(g, b));
	
	if (biglyChannel == r) {
		return (g - b) / (biglyChannel - small);
	} else if (biglyChannel == g) {
		return 2.0 + (b - r) / (biglyChannel - small);
	} else {
		return 4.0 + (r - g) / (biglyChannel - small);
	}
}

float segments = 10.0f;
float4 PS(vs2ps input): SV_Target
{
	float2 uv = float2(
		floor(input.uv.x * segments) * (1.0f / segments),
		input.uv.y
	);
	
    return float4(uv.xxx, 1.0);
}

technique10 Constant
{
	pass P0
	{
		SetVertexShader( CompileShader( vs_4_0, VS() ) );
		SetPixelShader( CompileShader( ps_4_0, PS() ) );
	}
}




