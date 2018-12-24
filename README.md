
# Gerstner-Waves-in-Unity

An implementation of the Gerstner Wave equations for Unity.

The wave is defined as a shader function in `Assets/Gerstner/GerstnerWave.cginc`. To use this function, you may simply `#include "GerstnerWave.cginc/relative/to/your/shader"` in your shader, and call it by name `GerstnerWave(...etc...)`.

Additionally, an Amplify shader function is also provided in `Assets/Shaders/GerstnerAmplify`, which offers the same functionality.

Finally, an example shader is provided in `Assets/Shaders/GerstnerExample.shader`, which demonstrates a simple way to combine multiple waves together.

**pictures + more to come soon. wip!**