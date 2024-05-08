#!/usr/bin/env python3

import sys
import SB02 as SB02


for line in sys.stdin:
    n = int(line)
    # print(f'num = {n} result = {sb01.factorial(n)}')
    print(SB02.factorial(n))
