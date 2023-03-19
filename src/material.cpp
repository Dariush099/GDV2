#include "material.h"

BHandle CreateMaterial(BHandle _vertextConstantBuffer, BHandle _pixelConstantBuffer, BHandle _vertexShader, BHandle _pixelShader)
{
    SMaterialInfo MaterialInfo;

    MaterialInfo.m_NumberOfTextures = 0;                          
    MaterialInfo.m_NumberOfVertexConstantBuffers = 1;                         
    MaterialInfo.m_pVertexConstantBuffers[0] = _vertextConstantBuffer;    
    MaterialInfo.m_NumberOfPixelConstantBuffers = 1;                           
    MaterialInfo.m_pPixelConstantBuffers[0] = _pixelConstantBuffer;      
    MaterialInfo.m_pVertexShader = _vertexShader;         
    MaterialInfo.m_pPixelShader = _pixelShader;              
    MaterialInfo.m_NumberOfInputElements = 1;                        
    MaterialInfo.m_InputElements[0].m_pName = "POSITION";               
    MaterialInfo.m_InputElements[0].m_Type = SInputElement::Float3;      

    BHandle material = nullptr;
    CreateMaterial(MaterialInfo, &material);

    return material;
}

