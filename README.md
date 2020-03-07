# OpenRS2 Natives

[![Build status badge](https://build.openrs2.dev/buildStatus/icon?job=openrs2-natives&build=lastCompleted)](https://build.openrs2.dev/job/openrs2-natives/)

## Introduction

OpenRS2 Natives are open-source replacements for the jaggl, jaggl\_dri and
jagmisc native libraries.

## Prerequisites

Building OpenRS2 Natives requires the following pieces of software on all
platforms:

* [Java Development Kit][jdk] (version 8 or later)
* [Apache Maven][maven] (version 3.3.9 or later)

### Platform-specific dependencies

Your platform's standard C compiler and [OpenGL][opengl] development headers
must be installed.

#### Windows

Install the [Build Tools for Visual Studio][visualstudio] (2019 or later),
which provide a command-line version of the Visual C++ compiler. The full GUI
version of Visual Studio will also work, but it is not required.

The Visual C++ tools must be present on your `%PATH%` when building OpenRS2
Natives. The easiest way to achieve this is to open the command prompt with the
'Developer Command Prompt for VS 2019' item from the start menu.

The Java Development Kit and Apache Maven `bin` directories must be manually
[added to your `%PATH%` variable][path].

##### Cross-compiling

To compile a 32-bit DLL on a 64-bit Windows system, open the 'x64\_x86 Cross
Tools Command Prompt for VS 2019' instead.

Maven's `nar.javaHome` variable must point to a 32-bit JDK and `nar.arch` must
be set to `x86`:

    -Dnar.javaHome="C:\Program Files (x86)\path\to\jdk" -Dnar.arch=x86

#### macOS

Run `xcode-select --install` from the terminal to install the [Xcode][xcode]
command-line tools.

The easiest way to install the Java Development Kit and Apache Maven is with the
[Homebrew][homebrew] package manager. After installing Homebrew, run
`brew cask install java` and `brew install maven`.

##### Cross-compiling

The last version of Java to support the 32-bit version of Mac OS X is the
[legacy Java 6 runtime][mac-legacy-java].

Pass the following flags to Maven to compile against the 32-bit version of the
legacy runtime on a 64-bit macOS system:

    -Dnar.javaHome=/Library/Java/JavaVirtualMachines/1.6.0.jdk/Contents/Home -Dnar.arch=i386

#### UNIX

OpenRS2 Natives requires the [GNU Compiler Collection][gcc] and the [Mesa 3D
Graphics Library][mesa] on UNIX-like systems (e.g. Linux).

The easiest way to install all the dependencies is with your system's package
manager. For example:

* Debian-based systems: `apt install openjdk-8-jdk maven gcc libgl1-mesa-dev`
* RPM-based systems: `yum install java-8-openjdk-devel maven gcc mesa-libGL-devel`
* ArchLinux-based systems: `pacman -S jdk8-openjdk maven gcc mesa`

`-headless` packages are not sufficient as the `gl-natives` module is linked
with `libjawt`.

##### Compatibility

The `aol.properties` file uses the normalized `os.name` property as part of the
architecture/operating system/linker key. It currently only contains properties
for Linux. While the default settings will probably work for other UNIX-like
systems, the defaults are not ideal. For example, `g++` will be used as the
linker instead of `gcc`, introducing a redundant dependency on `libstdc++`.

##### Cross-compiling

To compile a 32-bit shared object on a 64-bit UNIX system, Maven's
`nar.javaHome` variable must point to a 32-bit JDK and `nar.arch` must be set
to `i386`:

    -Dnar.javaHome=/path/to/jdk -Dnar.arch=i386

## Building

Run `mvn verify` to build the code and package it.

## Performing a release

This works slightly differently to a standard Maven release as it must be
performed manually for each operating system and architecture.

First prepare the release to create the tag:

    mvn -Pmac,unix,windows release:prepare

The temporary release files may then be deleted:

    mvn -Pmac,unix,windows release:clean

On each operating system and architecture, checkout the new tag and manually
deploy the release:

    mvn -Prelease <optional flags for cross-compilation> clean deploy

## License

OpenRS2 is available under the terms of the [ISC license][isc], which is
similar to the 2-clause BSD license. The full copyright notice and terms are
available in the `LICENSE` file.

[gcc]: https://gcc.gnu.org/
[homebrew]: https://brew.sh/
[isc]: https://opensource.org/licenses/ISC
[jdk]: https://jdk.java.net/
[mac-legacy-java]: https://support.apple.com/kb/DL1572
[maven]: https://maven.apache.org/
[mesa]: https://www.mesa3d.org/
[opengl]: https://www.opengl.org/
[path]: https://www.java.com/en/download/help/path.xml
[visualstudio]: https://visualstudio.microsoft.com/downloads/
[xcode]: https://developer.apple.com/xcode/
