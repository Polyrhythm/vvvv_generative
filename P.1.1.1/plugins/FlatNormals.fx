cbuffer cbPerDraw : register( b0 )
{
	float4x4 tVP : LAYERVIEWPROJECTION;	
};

cbuffer cbPerObj : register( b1 )
{
	float4x4 tW : WORLD;
};

struct VS_IN
{
	float4 PosO : POSITION;
	float4 Normal : NORMAL;

};

struct vs2ps
{
    float4 PosWVP: SV_Position;
    float4 Normal : NORMAL;
};

struct vs2ps_nointerp
{
	float4 PosWVP : SV_Position;
	nointerpolation float4 Normal : NORMAL;
};

vs2ps VS(VS_IN input)
{
    vs2ps output;
    output.PosWVP  = mul(input.PosO,mul(tW,tVP));
    output.Normal = input.Normal;
    return output;
}

vs2ps_nointerp VS_NI(VS_IN input)
{
	vs2ps_nointerp output;
	output.PosWVP  = mul(input.PosO,mul(tW,tVP));
    output.Normal = input.Normal;
    return output;
}


float4 PS(vs2ps In): SV_Target
{
    return In.Normal + float4(0.25f, 0.25f, 0.25f, 0.0f);
}

float4 PS_NI(vs2ps_nointerp In): SV_Target
{
    return In.Normal + float4(0.25f, 0.25f, 0.25f, 0.0f);
}

technique10 Interpolated
{
	pass P0
	{
		SetVertexShader( CompileShader( vs_4_0, VS() ) );
		SetPixelShader( CompileShader( ps_4_0, PS() ) );
	}
}

technique11 NoInterpolation
{
	pass P0
	{
		SetVertexShader(CompileShader(vs_4_0, VS_NI()));
		SetPixelShader(CompileShader(ps_5_0, PS_NI()));
	}
}



