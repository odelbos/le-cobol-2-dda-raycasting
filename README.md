# Synopsis

Basic Flat Raycasting Algorithm in COBOL. (using DDA algorithm).

It's an attemps to rewrite in COBOL the C version : [Flat Raycasting in C](https://github.com/odelbos/le-c-2-dda-raycasting)

> [!NOTE]
> With all my repositories, the `le-` prefix mean: Learning Exercise.

- [Raylib](https://www.raylib.com/)
- GCC
- [GnuCOBOL](https://gnucobol.sourceforge.io/)

## Install dependencies on Mac OSX:

Install GCC:

```console
xcode-select --install
```

```console
% gcc --version
Apple clang version 16.0.0 (clang-1600.0.26.4)
Target: arm64-apple-darwin24.1.0
Thread model: posix
```

Install Raylib and GnuCOBOL:

```console
brew install raylib glfw gnucobol
```

Version:

- Raylib 5.5

```console
% cobc --version
cobc (GnuCOBOL) 3.2.0
C version "Apple LLVM 16.0.0 (clang-1600.0.26.3)"
```

# Build

```console
git clone https://github.com/odelbos/le-cobol-2-dda-raycasting
cd le-cobol-2-dda-raycasting
```

```console
./make.sh
```

# Run

```console
./raycast
```