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
must either be referenced by `braiNIX.bf` or one of its decedents. Once all file
references have been replaced, the build is finished.

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

1. Code the command in a file called `command_x.bf`, and place it in the `src/`
   directory. Make sure the command does not already exist (unless it is being
   updated, of course).

2. Navigate to the `tools/` directory and run `python new_command.py`.

3. When prompted, enter the new command name (in this case, `x`).

That's it! The new command is now fully integrated into the braiNIX source tree.
To edit the command's behavior (but not the name of the command itself), just
change `command_x.bf` and leave the rest of the code intact.

Guidelines
----------

All tooling should be written in Python 3.6, for consistency. It should follow
the generally accepted standards found in:

- [PEP 8]
- [PEP 257]
- [The Google Python Style Guide]

[the syntax and behavior of `.bf` files]:
https://en.wikipedia.org/wiki/brainfuck

[PEP 8]:
https://www.python.org/dev/peps/pep-0008/

[PEP 257]:
https://www.python.org/dev/peps/pep-0257/

[The Google Python Style Guide]:
https://google.github.io/styleguide/pyguide.html
