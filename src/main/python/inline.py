#!/usr/bin/env python
# -*- coding: utf-8 -*-

"""
Converts a Python script into a single line string suitable for use with
python as a program passed in via the -c option.
"""

#** makestuff/src/main/python/inline.py

#pylint: disable=

import re
import sys

SRC = re.sub(re.compile("#.*?\n|\r|\r\n"), "", sys.stdin.read())
SRC = re.sub(re.compile("\"{3}.*?\"{3}", re.DOTALL), "", SRC)
LINES = [i for i in SRC.splitlines(False) if i]
IMPORTS = "import " + ", ".join([i.split()[1] for i in LINES if i.startswith("import")]) + " ; "
CODE = " ; ".join([i for i in LINES if not i.startswith("import")])
print IMPORTS + CODE
