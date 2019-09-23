# OpenRS2 GL Natives

## Known bugs

### macOS performance

OpenJDK's `nativeGetTopmostPlatformWindowUnderMouse` function is very slow on
macOS. On lower-end hardware, such as a 2011 Mac Mini, the rendering loop
completely freezes whenever the mouse moves. More information is available in
the [JetBrains Runtime issuer tracker][macos-perf].

The performance is significantly better if the [JetBrains Runtime][jbr] is used
instead of OpenJDK.

### macOS lighting quality

The lighting quality is very poor on a Mac Mini with an integrated Intel HD
Graphics 3000 card: some polygons are far too dark, and they tend to flicker
between bright and dark as the camera angle changes, instead of transitioning
smoothly.

I'm not yet sure if this is a bug specific to macOS, the Intel HD Graphics 3000
drivers or the card itself. I don't believe it is the reimplemented
bindings - the same problem happens with the original jaggl bindings and build
667 of the client. I also think it is unlikely to be the client, as the same
client code works on Windows and Linux.

[macos-perf]: https://youtrack.jetbrains.com/issue/JBR-444
[jbr]: https://confluence.jetbrains.com/display/JBR/JetBrains+Runtime
