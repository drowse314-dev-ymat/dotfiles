# coding: utf-8


import sys


def run(vimrcpath):
    with open(vimrcpath, 'rb') as vimrc, open('_gvimrc', 'wb') as gvimrc:
        writeon = True
        reader = iter(vimrc)
        while True:
            try:
                line = next(reader).decode('utf8')
                if line == '" @vimonly\n':
                    writeon = False
                elif line == '" ~@vimonly\n':
                    writeon = True
                if writeon:
                    gvimrc.write(line.encode('utf8'))
            except StopIteration:
                break


if __name__ == '__main__':
    if len(sys.argv) <= 1:
        sys.exit(1)
    run(sys.argv[1])

