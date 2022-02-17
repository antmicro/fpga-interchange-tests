from argparse import ArgumentParser
import os

parser = ArgumentParser()
parser.add_argument('source')
parser.add_argument('io', nargs='*')
parser.add_argument('--top', default='top')

args = parser.parse_args()

verilog = ''

verilog += f'`include "{os.path.basename(args.source)}"\n\n'
verilog += f'module {args.top}_diff (\n'

def iogen(io):
    for iodef in io:
        iosplit = iodef.split(':')
        iotype = 'input' if iosplit[0][0] == 'i' else 'output'
        iow = 1
        if len(iosplit[0]) > 1:
            iow = int(iosplit[0][1:])
        
        iowstr = '' if iow == 1 else f'[{iow-1}:0] '

        yield f'{iotype} wire {iowstr}{iosplit[1]}'

def ionames(io):
    for iodef in io:
        iosplit = iodef.split(':')
        yield iosplit[1]

verilog += '    input wire clk_p,\n    input wire clk_n' + (',\n    ' if len(args.io) > 0 else '')
verilog += ',\n    '.join(iogen(args.io)) + '\n);\n'
verilog += '    wire clk;\n    IBUFDS ibuf_ds (.I(clk_p), .IB(clk_n), .O(clk));\n'

names = list(ionames(args.io)) + ['clk']

verilog += '    top top_ (\n        '
verilog += ',\n        '.join(f'.{n}({n})' for n in names)
verilog += '\n    );\nendmodule\n'

print(verilog)
