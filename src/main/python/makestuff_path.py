#!/usr/bin/env python
# -*- coding: utf-8 -*-

"""
Parses a git URI in the format hostname/org/repo@version.git and then performs
a git clone on the repository if it is not present in the file system.

This module expects three arguments:
repo_dir=the directory into which the external repo is cloned
	(e.g.: .makestuff)
repo=the the URI of the git repo to be cloned
	(e.g.: github.com/SummitStreet/makestuff@master.git)

This code is embedded inline into makestuff makefiles to simplify retrieval of
the makestuff git repo.
"""

#** makestuff/src/main/python/makestuff_path.py

#pylint: disable=

import os
import re
import sys

R, V = re.match(r"(.+?)(@.*)?.git", sys.argv[2]).groups()
print os.sep.join([sys.argv[1], R, V[1:]])
