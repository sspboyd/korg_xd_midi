# Processing + MIDI

### Exploring MIDI using a Korg XD as a controller with Processing

This is a proof of concept project to try connecting a MIDI controller (Korg Minilogue XD) to several variables inside a Processing sketch.

The visuals are just circles and lines arranged around a central position. There are 10 different variables in the sketch that are mapped to MIDI controller knobs and switches.
| On Screen Visuals | Korg XD Controller|
|----|----|
| Number of Circles/Lines | VCO 1 Shape |
|Distance from Centre | Filter Cutoff |
Circle/Line Size | Filter Resonance |
Line Thickness | AMP EG Attack |
Transparency | AMP EG Release |
Base Colour | LFO Rate |
Colour Range | LFO Interval |
Background Colour | SYNC ON/OFF |
Circle, Line or Both | VCO 1 Wave Type (Saw, Triangle, Square)|
Rotation | Envelope Generator Interval |

### Using theMIDIBus Processing Libary.

The MIDI library is called [theMidiBus](https://github.com/sparks/themidibus) and it makes connecting and interacting with the Korg very easy. I tried installing it from the Processing IDE but I needed to download the latest version from GitHub to get it working with Processing 4.
