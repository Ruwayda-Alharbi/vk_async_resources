#version 460 
#extension GL_EXT_debug_printf : require
#extension GL_EXT_scalar_block_layout : enable
#extension GL_GOOGLE_include_directive : enable

layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;



layout(binding = 0, scalar) buffer a_
{
  int a[];
};
layout(binding = 1, scalar) buffer b_
{
  int b[];
};

void main()
{
    uint id=gl_GlobalInvocationID.x;
    if(id>=20)
      return;
 
   /* if(id==0)
    {
        debugPrintfEXT("Hello from first invocation" );
    }
    else if(id==19)
    {
        debugPrintfEXT("Hello from Last invocation" );
    }*/
    barrier();
    memoryBarrierShared();

    for (int i = 0; i < 10000000; i++)
    {
        atomicAdd(b[id], a[id]);
    }
    barrier();
    memoryBarrierShared();

}