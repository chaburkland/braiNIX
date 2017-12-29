![stable version]![stable build date]
![latest version]![latest build date]

`braiNIX`
=========

The world's first `.bf` operating system.

About
-----

The first of its kind, braiNIX is a project to develop a \*NIX OS written
entirely in [an esoteric Turing language]. When fully functional, it will likely
be the world's smallest operating system.

Requirements
------------

_Development is currently in an unstable "0" phase. These requirements may
change at any time._

braiNIX is designed to run on most systems that support the execution of `.bf`
files. These systems fall under two categories:

- **Software Interpreters**: These are the most commonly-used implementations.
These interpreters run on top of a standard OS using general-purpose CPUs.

- **Native Hardware**: These are rare, but certainly do exist. These
implementations have instruction sets that map directly to (or are supersets of)
commands present in `.bf` files. braiNIX is inspired by, and specifically
intended for, systems such as these.

Regardless of the chosen implementation, braiNIX has a few base requirements:

### Design Requirements

To properly function, braiNIX requires the runtime environment to conform to the
following non-standardized design choices:

- Memory cells must be wrapping integers of at least 7 bits. Both signed and
unsigned designs are supported, as are finite and infinite designs.

- Memory address overflow / underflow behavior may be left undefined. However,
halting behavior is recommended to avoid errant memory corruption. Both finite
and infinite designs are supported.

- Input must be recieved via an unbuffered blocking input byte stream. As a
result, `EOF` behavior may be left undefined. Input should not be automatically
echoed to the output stream. Both input and output streams should support the
7-bit ASCII printable character set (code points `32` - `126`). Code point `10`
(line feed), must also be supported.

- To allow for persistent data between sessions, it is strongly recommended to
use static cell values that persist after restart / program termination.

- The initial cell address must be the same each time braiNIX is run. For memory
management purposes, it is recommended that this be cell `0`.

### Compatibility And Size Requirements

Each version number uses [Semantic Versioning]. For braiNIX, the build metadata
of each version number indicates its memory requirements.

Given a version number `vA.B.C+X.Y.Z`:

- `A` is the major version number. It indicates backward-compatibility with
other versions.

- `B` is the minor version number. It indicates forward-compatibility with
other versions.

- `C` is the patch version number. It indicates forward- and
backward-compatibility with other versions.

- `X` is the size of the final build in kilobytes, rounded up. The runtime
environment must have at least this much program memory available to
successfully boot braiNIX. This value assumes 8-bit characters as commands,
so it is possible to significantly reduce this requirement by mapping the
ASCII characters to words as small as 3 bits, if desired.

- `Y` is the loop depth of the final build. The runtime environment must support
at least this many nested loops to successfully boot braiNIX. More are usually
required for error-free execution.

- `Z` is the memory size of the final build. The runtime environment must have
at least this many memory cells to successfully boot braiNIX. More are usually
required for error-free execution.

--------------------------------------------------------------------------------

_Want to help write braiNIX? Fork it for an interesting side-project, then open
a pull request! Help with tooling, tests, and documentation is also greatly
appreciated._

[stable version]:
https://img.shields.io/github/release/brandtbucher/brainix.svg?style=for-the-badge&label=stable

[stable build date]:
https://img.shields.io/github/release-date/brandtbucher/brainix.svg?style=for-the-badge&label=built

[latest version]:
https://img.shields.io/github/release/brandtbucher/brainix/all.svg?style=for-the-badge&label=latest

[latest build date]:
https://img.shields.io/github/release-date-pre/brandtbucher/brainix.svg?style=for-the-badge&label=built

[an esoteric Turing language]:
https://en.wikipedia.org/wiki/Brainfuck

[Semantic Versioning]:
https://semver.org
