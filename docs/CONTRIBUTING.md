Contributing To `braiNIX`
=========================

How It Works
------------

One unique challenge in designing braiNIX is that `.bf`-interpreting systems
don't have separate space for disk and random-access memories. Rather, they
emulate one contiguous "tape" of memory cells.

braiNIX handles this by using this space for both disk and RAM. As such, it's
important to understand the memory layout explained here before attempting to
modify the braiNIX source code. Of course, it is also important to familiarize
oneself with [the syntax and behavior of `.bf` files].

The braiNIX project also has a few often-used terms that are defined here for
clarity and consistency:

- **Cells:** Individual memory addresses.

  - **Dividers:** Cells kept at `0`, used to separate structures (explained
    below). When used with `to_previous_struct_end.bf`,
    `to_next_struct_start.bf`, or similar files, it is possible to easily
    navigate huge amounts of memory divided into structures of unknown size.

  - **Anchors:** Cells kept at `-1`, or the maximum cell value, used to separate
    arbitrarily long groups of cells with values other than `-1`. When used with
    `to_previous_anchor.bf`, `to_next_anchor.bf`, or similar files, it is
    possible to easily navigate huge amounts of unknown- or zero-valued memory.

- **Structures:** Groups of cells, separated by dividers or anchors.

  - **Disk:** Memory which should persist between commands and system resets.
    Currently, is designed to contain only one structure.

    - **`data`:** The only file allowed on the disk, at present. This file's
      name is static, but its contents can be modified by the user at will.

  - **RAM:** Memory free to be used by system-level processes.

During normal operation, braiNIX allocates memory according to this diagram:

|**Address**|`#0`    |`#1` |...|`#(d + 1)`|`#(d + 2)`|`#(d + 3)`|...|`#(m - 1)`|
|:---------:|:------:|:---:|:-:|:--------:|:--------:|:--------:|:-:|:--------:|
|**Type**   |Divider |Disk |...|Divider   |Anchor    |RAM       |...|Divider   |

Here, `d` is the total size of `data` (in cells), and `m` is the total size of
the system's memory (in cells). The disk cells (`#1` through `#d`) are only used
if `data` exists.

The Source Tree
---------------

### Overview

The `src/` directory contains all of the files needed for braiNIX. The syntax
used differs a bit from that of standard `.bf` files, to simplify building and
maintaining the source tree. There are two main additions:

- Text inside of `(parentheses)` is replaced with the corresponding `.bf` source
  file. For example, `(to_next_struct_start)` would be replaced with the text of
  `to_next_struct_start.bf` in the same `src/` directory.

- Text inside of `"double quotes"` is replaced with the equivalent `.bf` code
  to clear the current cell, print the enclosed string, and clear the cell
  again. For example, `"HELLO WORLD"` would be replaced by:

  ```bf
  [-]
  ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  .
  ---
  .
  +++++++
  ..
  +++
  .
  -----------------------------------------------
  .
  +++++++++++++++++++++++++++++++++++++++++++++++++++++++
  .
  --------
  .
  +++
  .
  ------
  .
  --------
  .
  --------------------------------------------------------------------
  ```

`brainix.bf` is where building begins. Any other source files used in braiNIX
must either be referenced by `braiNIX.bf` or one of its descendants. Once all
file references have been replaced, the build is finished.

### Building

Building braiNIX requires Python 3.6 or higher. To build, navigate to `tools/`
and run `python build.py`.

This script assembles the source tree and performs optimizations and analysis of
the resulting code. If the build is error-free, the program will prompt the user
to number the release. The resulting file will then be saved to `../builds/`.

Writing A Command
-----------------

braiNIX has been designed to make adding new commands very simple. To create a
new command `x` (replacing `x` with the command name, like `echo` or `emacs`):

1. Code the command in a file named `command_x.bf`, and place it in the `src/`
   directory. Make sure the command does not already exist (unless it is being
   updated, of course).

2. Navigate to the `tools/` directory and run `python new_command.py`.

3. When prompted, enter the new command name (in this case, `x`).

That's it! The new command is now fully integrated into the braiNIX source tree.
To edit the command's behavior (but not the name of the command itself), just
change `command_x.bf` and leave the rest of the code intact.

Guidelines
----------

### Design

The following ordered principles should guide any implementation choices during
development.

#### 1. Familiarity

The sole goal of braiNIX is to duplicate the feature sets of existing systems.
Don't create new features; clone existing ones.

#### 2. Speed

Software development isn't code golf. Speed is a far more important metric to
optimize for than source code length. It is important to remember that
unnecessary loops and address shifts add considerable overhead and complexity
(not to mention tedious memory-management challenges for the programmer),
especially for the hardware-interpreting designs that braiNIX is specifically
designed for.

Consider setting a zeroed cell to `127`:

```bf
Multiplication
==============

>
++
>
+
>
+
[
    +
    >
    +
    [
        -
        <
        ++++
        >
    ]
    <<
]
>

Total operations: 342 (stack-based looping) or 676 (parsed looping)
Nested loops: 2
Total size: 24
Cells used: 5
```

versus

```bf
Addition
========

++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
+++++++++++++++++++++++++++++++++++++++++++++++

Total operations: 127
Nested loops: 0
Total size: 127
Cells used: 1
```

For an extra 0.1 KB of program memory, the second option is 2.7x - 5.3x faster,
doesn't add any nested loops, and is 5x more memory-efficient.

Don't add by multiplying. Add by adding.

#### 3. Compatibility

Never reduce the potential user base just to make the code easier to write. The
minimum requirements for braiNIX are defined by what's realistically possible,
not by what interpreter designs are easy to ignore.

Consider the example above. While a subtraction option (127 minus signs) is just
as fast and complex as addition, it would make braiNIX incompatible with any
interpreters that have cell sizes greater than 8 bits.

#### 4. Maintainability

Again, consider the speed comparison above. The addition is much easier to
understand, debug, modify, integrate, and optimize than the multiplication.

#### 5. Stability

Design it to work well, and keep it working well. It's as simple as that.

### Style

#### Code

All tooling should be written in Python 3.6, for consistency. It should follow
the generally accepted standards found in:

- [PEP 8]
- [PEP 257]
- [The Google Python Style Guide]

All `.bf` source files should adhere to the following conventions:

- Wrap lines at 80 characters.
- Indent 4 spaces for nested loops.
- Separate strings of identical commands on their own line.
- Leave one-command loops intact, together on their own line.

#### Documentation

All documentation should be written in Markdown, for consistency. It should
adhere to the following conventions:

- Never use any profanity, even when referring to the source language.
- All links and images should be reference-style.
- Any code, directories, files, file extensions, cell addresses, cell values, or
  variables should be `code-highlighted`.
- Use underlining for level-two and level-two headings. All file references
  should be relative.
- Indent properly when wrapping lines for lists.
- Always write in the third person, passive voice.

[the syntax and behavior of `.bf` files]:
https://en.wikipedia.org/wiki/brainfuck

[PEP 8]:
https://www.python.org/dev/peps/pep-0008/

[PEP 257]:
https://www.python.org/dev/peps/pep-0257/

[The Google Python Style Guide]:
https://google.github.io/styleguide/pyguide.html
