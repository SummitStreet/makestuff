#!/usr/bin/env python
# -*- coding: utf-8 -*-

"""
Parses a git URI in the format hostname/org/repo@version.git and then performs
a git clone on the repository if it is not present in the file system.

This module expects two arguments:
ext_dir=the directory into which the git repo is cloned
	(e.g.: .dependencies)
repo=the the URI of the git repo to be cloned
	(e.g.: github.com/SummitStreet/makestuff@master.git)

This code is embedded inline into makestuff makefiles to simplify retrieval of
the makestuff git repo.

The forward slashes in the protocol, https://, in the git clone command below
are escaped to prevent sed from misinterpreting these characters.

"""

#** makestuff/src/main/python/makestuff_init.py

import os
import re
import sys

C = "git clone --branch {1} https:\/\/{0}.git {2}"
R, V = re.match(r"(.+?)(@.*)?.git", sys.argv[2]).groups()
D = os.sep.join([sys.argv[1], R, V[1:]])
None if os.path.isdir(D) else os.system(C.format(R, V[1:], D))
