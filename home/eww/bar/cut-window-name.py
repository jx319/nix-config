#!/usr/bin/env python3

import sys

windowname = sys.stdin.read()

if len(windowname) >= 70:
    print(windowname[:70] + "...")
else:
    print(windowname)

