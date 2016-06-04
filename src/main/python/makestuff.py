#!/usr/bin/env python
# -*- coding: utf-8 -*-

"""
TODO
path repo		-d dependency_dir
install repo	-d dependency_dir
remove repo		-d dependency_dir

removeall		-d dependency_dir

"""

#** makestuff/src/main/python/makestuff.py

#pylint: disable=

import os
import re
import sys

class MakeStuff(object):

	git_clone = "git clone --branch {ver} https://{repo}.git {dir} >/dev/null 2>/dev/null"
	dependency_dir = ".dependencies"
	repo = None

	def _get_repo_and_version(self):
		"""
		TODO
		"""
		repo, version = re.match(r"(.+?)(@.*)?.git", sys.argv[2]).groups()
		return (repo, version)

	def _get_repo_path(self):
		"""
		TODO
		"""
		repo, version = self._get_repo_and_version()
		return os.sep.join([sys.argv[1], repo, version[1:]])

	def install(self):
		"""
		TODO
		"""
		repo, ver = self._get_repo_and_version()
		dir = self._get_repo_path()
		if not os.path.isdir(dir):
			os.system(self.git_clone.format(repo=repo, ver=ver, dir=dir))

	def path(self):
		"""
		TODO
		"""
		print self._get_repo_path()

	def remove(self):
		"""
		TODO
		"""
		return

	def removeall(self):
		"""
		TODO
		"""
		return

if __name__ == '__main__':
	sys.exit(0)
