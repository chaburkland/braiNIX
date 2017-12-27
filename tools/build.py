"""Build ../src/brainix.bf, write to ../build/, and print specs."""


import build_tools


with open("../src/brainix.bf", 'r') as file:
    build = file.read()
    
build = build_tools.replace_sources(build)
build = build_tools.replace_strings(build)
build = build_tools.filter_commands(build)
build = build_tools.reduce_commands(build)
build_name = build_tools.report(build)

with open(f"../build/{build_name}", 'w') as file:
    file.write(build)
