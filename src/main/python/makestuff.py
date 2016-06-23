#!/usr/bin/env python
# -*- coding: utf-8 -*-

"""
TODO
"""

#** makestuff/src/main/python/makestuff.py

#pylint: disable=bad-continuation, mixed-indentation

import argparse
import codecs
import json
import os
import re
import shutil
import sys

CLONE = "git clone --branch {ver} https://{repo}.git {dir} >/dev/null 2>/dev/null"
EXT_DIR = ".dependencies"
CONFIG_FILE = "makestuff.json"

class MakeStuff(object):
	"""
	TODO
	"""
	_version = 1.0

	clone_cmd = None
	ext_dir = None
	repo = None
	config_file = None

	def __init__(self, description, command_line_args, *args):
		"""
		TODO
		"""

		self.__config(description, command_line_args, args)

	def __config(self, description, command_line_args, configurable_types):
		"""
		Initializes the ArgumentParser and injects command-line arguments as
		static variables into the types defined in the module.
		"""
		writer = codecs.getwriter("utf8")
		sys.stdout = writer(sys.stdout)

		# Create and initialize an ArgumentParser
		parser = argparse.ArgumentParser(description=description)
		parser.add_argument("--version", action="version", version="%(prog)s v" + str(self._version))
		for i in command_line_args:
			params = dict(required=i[1], type=i[2], nargs=i[3], default=i[4], action=i[5], help=i[6])
			parser.add_argument(i[0], **params)

		# Inject argument values into all types within the module with matching
		# names.
		for key, value in vars(parser.parse_args()).iteritems():
			for obj in configurable_types:
				if hasattr(obj, key):
					setattr(obj, key, value)

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

	def _load_config_file(self):
		try:
			with codecs.open(self.config_file, encoding="utf-8") as makestuff_json:
				config_file_str = makestuff_json.read()
				return json.loads(config_file_str)
		except IOError:
			print sys.argv[0] + ": Unable to load config file '" + self.config_file + "'."
		except ValueError:
			print sys.argv[0] + ": Config file not valid JSON."

	def install(self):
		"""
		TODO
		"""
		repository, version = self._get_repo_and_version()
		directory = self._get_repo_path()
		if not os.path.isdir(directory):
			os.system(self.clone_cmd.format(repo=repository, ver=version, dir=directory))

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

	def run(self):
		"""
		TODO
		"""
		config = self._load_config_file()
		print config
		return 0

if __name__ == '__main__':
	DESCRIPTION = "CLI for the makestuff module."
	# Command-line args format: (name, required, type, nargs, default, action, help)
	COMMAND_LINE_ARGS = [
		("--clone-cmd", False, str, None, CLONE, None, u"specify the repo clone command"),
		("--ext-dir", False, str, None, EXT_DIR, None, u"set the clone destination directory"),
		("--repo", True, str, None, None, None, u"specify the repo to be cloned"),
		("--config-file", False, str, None, CONFIG_FILE, None, u"specify the makestuff config file")
	]
	sys.exit(MakeStuff(DESCRIPTION, COMMAND_LINE_ARGS, MakeStuff).run())
