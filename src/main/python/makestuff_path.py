#!/usr/bin/env python
# -*- coding: utf-8 -*-

"""
Parses a git URI in the format hostname/org/repo@version.git and then performs
a git clone on the repository if it is not present in the file system.

This module expects three arguments:
base_dir=the directory into which git repos are cloned
	(e.g.: .dependencies)
repo_uri=the git repo to be cloned
	(e.g.: github.com/SummitStreet/makestuff@master.git)
git_command=the git clone command, should contain variables ver, repo, and dir
	(e.g.: "git clone --branch {ver} https://{repo}.git {dir} >/dev/null 2>/dev/null")

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
