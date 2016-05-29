#!/usr/bin/env python
# -*- coding: utf-8 -*-

"""
TODO
"""

#** makestuff/src/main/python/makestuff.py

#pylint: disable=

import os
import re
import sys

GIT_COMMAND = "git clone --branch {1} https://{0}.git {2} >/dev/null 2>/dev/null"
EXT_DIR = sys.argv[1]
REPO, VERSION = re.match(r"(.+?)(@.*)?.git", sys.argv[2]).groups()
VERSION = VERSION[1:] if VERSION else "master"
REPO_DIR = EXT_DIR + "/" + REPO + "/" + VERSION
print REPO_DIR, os.path.isdir(REPO_DIR)

if not os.path.isdir(REPO_DIR):
    print "missing dir"
#	os.system(git_command.format(version, repo, repo_dir))

print GIT_COMMAND.format(REPO, VERSION, REPO_DIR)
