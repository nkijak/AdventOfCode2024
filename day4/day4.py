from dataclasses import dataclass

@dataclass
class Tree:
    value: str
    right: 'Tree' = None
    down: 'Tree' = None
    corner: 'Tree' = None


def part1(path):
    with open(path) as input:
        lines = []
        last = None
        for line in input.readlines():
            row = []
            line = line.replace("\n", "")
            for c in reversed(line):
                last = Tree(value=c, right=last)
                row.append(last)
            row.reverse()
            lines.append(row)
    lines.reverse()
    for i in range(0, len(lines)-1):
        print(f"bottom={i} top={i+1}")
        bottoms = lines[i]
        tops = lines[i+1]
        for i,t in enumerate(tops):
            print(f"{i} of {len(bottoms)}")
            t.bottom = bottoms[i]
            t.corner = bottoms[i+1] if i+1 < len(bottoms) else None
    lines.reverse()
    print(lines)


if __name__ == '__main__':
    #"test/test_data.txt"
    part1("test/small_data.txt")