"""A non-interactive .bf interpreter for automated testing."""

def run(program, stream=''):
    """Interpret and get info for the given .bf program with the given input."""

    commands = ['+', ',', '-', '.', '<', '>', '[', ']']
    stream = list(stream)
    tape = bytearray(1)
    stack_count = 0
    parse_count = 0
    status = "OK"
    depth = [0]
    index = 0
    head = 0
    out = ''

    while index < len(program):

        command = program[index]

        if command is '+':

            tape[head] = (tape[head] + 1) % 256

        elif command is ',':

            try: tape[head] = ord(stream.pop(0))
            except IndexError:
                status = "NO INPUT"
                break

        elif command is '-':

            tape[head] = (tape[head] - 1) % 256

        elif command is '.':

            out += chr(tape[head])

        elif command is '<':

            head -= 1

        elif command is '>':

            head += 1
            while len(tape) <= head:
                tape.append(0)

        elif command is '[' and not tape[head]:

            index += 1
            parse_count += 1
            depth.append(1)

            if len(program) <= index:
                status = "NO RIGHT BRACKET"
                break

            while program[index] is not ']' or 1 < depth[-1]:

                if program[index] is '[': depth.append(depth[-1] + 1)
                elif program[index] is ']': depth.append(depth[-1] - 1)

                parse_count += 1
                index += 1

                if len(program) <= index:
                    status = "NO RIGHT BRACKET"
                    break

        elif command is ']' and tape[head]:

            index -= 1
            parse_count += 1
            depth.append(1)

            if index < 0:
                status = "NO LEFT BRACKET"
                break

            while program[index] is not '[' or 1 < depth[-1]:

                if program[index] is ']': depth.append(depth[-1] + 1)
                elif program[index] is '[': depth.append(depth[-1] - 1)

                parse_count += 1
                index -= 1

                if index < 0:
                    status = "NO LEFT BRACKET"
                    break

        stack_count += 1
        parse_count += 1
        index += 1

    return status, out, list(tape), head, stack_count, parse_count, max(depth)
