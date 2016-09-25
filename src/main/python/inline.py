#!/usr/bin/env python
# -*- coding: utf-8 -*-

"""
Converts a Python script into a single line string suitable for use with
python as a program passed in via the -c option.
"""

#** makestuff/src/main/python/inline.py

#pylint: disable=

import codecs
import re
import sys

sys.stdin = codecs.getreader("utf-8")(sys.stdin)
sys.stdout = codecs.getwriter("utf-8")(sys.stdout)
sys.stderr = codecs.getwriter("utf-8")(sys.stderr)
SRC = re.sub(re.compile("#.*?\n|\r|\r\n"), "", sys.stdin.read())
SRC = re.sub(re.compile("\"{3}.*?\"{3}", re.DOTALL), "", SRC)
LINES = [i for i in SRC.splitlines(False) if i]
IMPORTS = [i.split()[1] for i in LINES if i.startswith("import")]
IMPORTS = "" if not IMPORTS else "import " + ", ".join(IMPORTS) + " ; "
LINES = [i for i in LINES if not i.startswith("import")]
CODE = "".join([("" if not i or j[:1].isspace() else " ; ") + j for i, j in enumerate(LINES)])
print IMPORTS + CODE
