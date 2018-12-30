
# Gerstner-Waves-in-Unity

An implementation of the Gerstner Wave equations for Unity.

![https://giphy.com/gifs/1Aj1HrNOHlOeh6cs36/media](https://media.giphy.com/media/1Aj1HrNOHlOeh6cs36/giphy.gif)

## Contents

- [Equations](#equations)
- [Usage](#usage)
- [Implementation](#implementation)
- [Notes](#notes)
- [Sources](#sources)

<a name="equations"></a>
## Equations

The Gerstner equations describe the motion of wave(s), similar to a sinusoidal wave. Unlike a sinusoidal wave, a gerstner wave can move side-to-side as well as up and down.

This is controlled by a `steepness` parameter. A value of `0` eliminates all horizontal movement (essentially yielding a sinusoidal wave). A value of `1` allows each vertex to "roll" around its origin, simulating the displacement of water that occurs in real ocean waves. This is demonstrated in the gif below.<sup>[1]</sup>

![steepness](https://media.giphy.com/media/3ohzdDmwsUNS6E8fy8/giphy.gif)

More precisely, given an original point on the horizontal plane, we can derive its new position by the following equation.<sup>[2]</sup>

![p eq](https://developer.nvidia.com/sites/all/modules/custom/gpugems/books/GPUGems/elementLinks/013equ01.jpg)

and the accompanying normal by the following equation.<sup>[3]</sup>

![n eq](https://developer.nvidia.com/sites/all/modules/custom/gpugems/books/GPUGems/elementLinks/013equ04.jpg)


<a name="usage"></a>
## Usage

To use the equations, simply `#include "../path/to/Gerstner.cginc"` in your `.shader` file.

In your vertex shader, pass in the current vertex, normal, and a set of structs describing the waves parameters to the `Gerstner()` function.

The included [Example.shader](https://github.com/danielshervheim/Gerstner-Waves-in-Unity/blob/master/Assets/Shaders/Example.shader) demonstrates how this is done, and can be used as a template for your own shaders.

In short, the following structs need to be filled, then passed:

### GerstnerGlobal

**offsetStrength [0...1]**: 0 "turns off" the calculated vertex offset, while 1 applies the full vertex offset.

**normalStrength [0...1]**: 0 "turns off" the calculated vertex normal, while 1 applies the full vertex normal.

**steepness [0...1]**: 0 "turns off" the horizontal movement, essentially yielding a sinusoidal wave, while 1 applies the full horizontal movement. Overall this parameter controls the apparent "choppiness" of the resulting deformation.

**numWaves [1...10]**: the number of waves filled out in the `GerstnerWave[]` array.
	
### GerstnerWave

**enabled [0, 1]**: 0 disabled the wave, 1 enables it.

**amplitude (in meters)**: the height of the wave.

**wavelength (in meters)**: the length of the wave from tip to tip.

**speed (in meters/second)**: the speed at which the wave is moving.

**dir**: a unit vector whose X and Z components describe the direction in which the wave is travelling.


<a name="implementation"></a>
## Implementation

These equations are implemented in the `Gerstner.cginc` file as a series of functions.

The main function `Gerstner()` takes in the current vertex and normal vector, sums up the wave contributions, and applies them back to the vertex and normal.

The `GerstnerPositionSum()` function calculates the summed portion of the position equation, while the `GerstnerNormalSum()` function calculates the summed portion of the normal equation.


<a name="notes"></a>
## Notes

#### Coordinate System

The Gerstner wave equations are typically defined with an XY horizontal plane and a Z vertical axis.

Unity, by contrast, defines XZ as the horizontal plane and Y as the vertical axis. For simplicities sake, I have gone with the Unity convention of Y as up and Z as right.

#### Object Space vs. World Space

The vertex position in `Example.shader` is passed to the `Gerstner()` function as-is, i.e. in object space by default.

To enable proper tiling, the point is immediately transformed into world space in `Gerstner()`. This allows easy tiling, if for example you wanted to represent an ocean as a collection of vertex-dense tiles rather than a single mesh.

All the calculations are done in world space, and then transformed back to object space before re-applying to the mesh.

#### Deviation From Standard Equations

By default, the Gerstner position equation only calls for adding the XZ positions of the original point to the summed offset.

I opted to include the original Y position in the offset as well, to account for water plane meshes which are not at Y = 0.

#### Mesh Density Requirements

To achieve pleasing visual results, a rather high-density mesh plane must be used. Unless the average wavelength is sufficiently high, Unity's built in plane primitive may not be a high enough density.

#### Shader Array Limitations

Unity shaders do not allow dynamically sized arrays, so I have capped the maximum number of waves the function will consider to 10. This number can easily be increased (although Unity limits it to 1023, I believe...) by changing the expected array length in the `Gerstner()` function parameters list, and in the vertex shader in `Example.shader()`.

Although 10 waves should certainly be enough to observe realistic ocean-like movements, with the right combination of parameters.


<a name="sources"></a>
## Sources

[1] https://media.giphy.com/media/3ohzdDmwsUNS6E8fy8/giphy.gif

[2, 3] https://developer.nvidia.com/gpugems/GPUGems/gpugems_ch01.html