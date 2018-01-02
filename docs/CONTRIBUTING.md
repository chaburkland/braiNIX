Contributing To `braiNIX`
=========================

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
    below). When used with `to_previous_struct.bf`, `to_next_struct.bf`, or
    similar files, it is possible to easily navigate huge amounts of memory
    divided into structures of unknown size.

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

|**Address**|`#0`    |`#1` |...|`#(d + 2)`|`#(d + 3)`|...|`#(m - 1)`|
|:---------:|:------:|:---:|:-:|:--------:|:--------:|:-:|:--------:|
|**Type**   |Divider |Disk |...|Anchor    |RAM       |...|Divider   |

Here, `d` is the total size of `data` (in cells), and `m` is the total size of
the system's memory (in cells).

[the syntax and behavior of `.bf` files]:
https://en.wikipedia.org/wiki/brainfuck
