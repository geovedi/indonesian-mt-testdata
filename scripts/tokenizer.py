#!/usr/bin/env python3
import sys
import re


def tokenize(text, separator='￭'):
    text = re.sub(
        r'(?<=[^\s])([^\w\s{0}])'.format(separator),
        r' {0}\1'.format(separator),
        text,
        flags=re.U)
    text = re.sub(
        r'([^\w\s{0}])(?=[^\s])'.format(separator),
        r'\1{0} '.format(separator),
        text,
        flags=re.U)
    return re.sub(' +', ' ', text).strip()


if __name__ == '__main__':
    for line in sys.stdin:
        text = line.strip()
        print(tokenize(text))