#define TIME		PSConstant.x
#define RESOLUTION	PSConstant.yz
float BASE_ANGLE = 8.5;
float ANGLE_DELTA = 0.03;
float XOFF = 5.2;

// define constant buffers

cbuffer VSBuffer : register(b0)
{
	float4x4 ScreenMatrix;
};

cbuffer PSBuffer : register(b0)
{
	float4 PSConstant;
};

// define input and output

struct VSInput
{
	float3 position : POSITION;
};

struct PSInput
{
	float4 position : SV_POSITION;
};

// Vertex Shader

PSInput VSShader(VSInput _Input)
{
    PSInput Output = (PSInput) 0;

    Output.position = mul(float4(_Input.position, 1.0f), ScreenMatrix);

    return Output;
}

// basic functions

float2x2 Rotate(float _a) {
    float c = cos(_a), s = sin(_a);
    return float2x2(c, -s, s, c);
}

float f(float2 _p, float _featureSize) {
    _p.x = sin(_p.x * 1.0 + TIME * 1.2) * sin(TIME + _p.x * 0.1) * 3.0;
    _p += sin(_p.x * 1.5) * 0.1;
    return smoothstep(-0.0, _featureSize, abs(_p.y));
}

// Pixel Shader

float4 PSShader(PSInput _Input) : SV_Target
{
    float aspect = RESOLUTION.x / RESOLUTION.y;
    float featureSize = 50.0 / ((RESOLUTION.x * aspect + RESOLUTION.y));

    float2 p = _Input.position.xy / RESOLUTION.xy * 8.0 - float2(4.0, 0);
    p.x *= aspect;
    p.y = abs(p.y);

    float3 col = float3(0, 0, 0);
    for (float i = 0; i < 50; i++) {
        float3 col2 = (sin(float3(3.3, 2.5, 2.2) + i * 0.15) * 0.5 + 0.54) * (1.0 - f(p, featureSize));
        col = max(col, col2);

        p.x -= XOFF;
        p.y -= sin(TIME * 0.3 + 1.5) * 1.5 + 1.5;
        p = mul(p, (float2x2)Rotate(i * ANGLE_DELTA + BASE_ANGLE));

        float2 pa = float2(abs(p.x - 0.9), abs(p.y));
        float2 pb = float2(p.x, abs(p.y));

        p = lerp(pa, pb, smoothstep(-0.1, 0.1, sin(TIME * 0.3) + 0.5));
    }
    return float4(col, 1.0);
}


// Vorlage: https://www.shadertoy.com/view/XdSSz1










