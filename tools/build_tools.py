"""Define functions used by build.py."""


import re


build_report = """
{}

Name: {}
Size: {} KB

Saved to builds.
"""


def cell_usage(build):

    cells = [0]
    index = 0
    head = 0

    while index < len(build):
        if build[index] is '+':
            cells[head] += 1
            if 256 <= cells[head]:
                cells[head] -= 256
        elif build[index] is ',':
            break
        elif build[index] is '-':
            cells[head] -= 1
            if cells[head] < 0:
                cells[head] += 256
        elif build[index] is '.':
            pass
        elif build[index] is '<':
            head -= 1
            if head < 0:
                cells.insert(0, 0)
                head = 0
        elif build[index] is '>':
            head += 1
            while len(cells) <= head:
                cells.append(0)
        elif build[index] is '[':
            if not cells[head]:
                loops = 1
                while True:
                    index += 1
                    if build[index] is '[':
                        loops += 1
                    elif build[index] is ']':
                        loops -= 1
                        if not loops:
                            break
                    if len(build) <= index:
                        break
        elif build[index] is ']':
            if cells[head]:
                loops = 1
                while True:
                    index -= 1
                    if build[index] is '[':
                        loops -= 1
                        if not loops:
                            break
                    elif build[index] is ']':
                        loops += 1
                    if len(build) <= index:
                        break
        index += 1

    return len(cells)


def filter_commands(build):
    """Remove all non-command characters from build."""
    
    commands = ['+', ',', '-', '.', '<', '>', '[', ']']
    build = [char for char in build if char in commands]
    build = ''.join(build)
    
    return build


def replace_sources(build):
    """Replace all {bracketed sources} in build with their source code."""

    files = re.findall("\(([\w/]+)\)", build)

    if not files:
        return build
    
    for source in files:
        with open(f"../src/{source}.bf", 'r') as file:
            build = build.replace(f"({source})", file.read())
            
    return replace_sources(build)


def report(build):
    """Report size, loop depth, and contents of build. Return build name."""

    brackets = {'[': 1, ']': -1}
    depth = [brackets.get(command, 0) for command in build]

    for index in range(1, len(depth)):
        depth[index] += depth[index-1]

    depth = max(depth)
    cells = cell_usage(build)
    version = input("\nVersion: v")
    size = round(len(build) / 1024, 3)
    name = f"brainix_v{version}+{int(size) + 1}.{depth}.{cells}.bf"
    print(build_report.format(build, name, size))

    return name


def reduce_commands(build):
    """Remove all non-effective command strings from build."""
    
    opposites = ["+-", "-+", "<>", "><"]
    
    for string in opposites:
        if string in build:
            build = build.replace(string, '')
            return reduce_commands(build)
        
    if re.findall("]\[[^]]*]", build):
        build = re.sub("]\[[^]]*]", ']', build)
        return reduce_commands(build)
        
    return build


def replace_strings(build):
    """Replace all "quoted strings" in build with code to print them."""
    
    build = build.replace("\\n", '\n')
    strings = re.findall('"([^"]*)"', build)
    
    for string in strings:
        bf = '[-]'
        for char in string:
            bf += '+' * ord(char)
            bf += '.'
            bf += '-' * ord(char)
        build = build.replace(f'"{string}"', bf)
        
    return build 
