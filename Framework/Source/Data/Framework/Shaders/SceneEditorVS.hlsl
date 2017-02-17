/***************************************************************************
# Copyright (c) 2017, NVIDIA CORPORATION. All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions
# are met:
#  * Redistributions of source code must retain the above copyright
#    notice, this list of conditions and the following disclaimer.
#  * Redistributions in binary form must reproduce the above copyright
#    notice, this list of conditions and the following disclaimer in the
#    documentation and/or other materials provided with the distribution.
#  * Neither the name of NVIDIA CORPORATION nor the names of its
#    contributors may be used to endorse or promote products derived
#    from this software without specific prior written permission.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS ``AS IS'' AND ANY
# EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
# IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
# PURPOSE ARE DISCLAIMED.  IN NO EVENT SHALL THE COPYRIGHT OWNER OR
# CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
# EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
# PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
# PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY
# OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
# (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
# OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
***************************************************************************/

#ifdef PATH_RENDERER

#include "ShaderCommon.h"
float4 main(float3 position : POSITION) : SV_POSITION
{
    return mul(gCam.viewProjMat, float4(position, 1));
}

#else

#include "SceneEditorCommon.hlsli"

EDITOR_VS_OUT main(VS_IN vIn)
{
    EDITOR_VS_OUT vOut;
    vOut.vOut = defaultVS(vIn);

#ifdef PICKING
    vOut.drawID = gDrawId[vIn.instanceID];
#endif

#ifdef CULL_REAR_SECTION
    // Get instance origin
    float4x4 worldMtx = getWorldMat(vIn);
    float3 instancePos = float3(worldMtx._m03, worldMtx._m13, worldMtx._m23);

    // Direction to vertex
    vOut.toVertex = vOut.vOut.posW - instancePos;
#endif

    return vOut;
}

#endif
