
#** makestuff/src/main/python/makestuff.py

# This module contains the command line interface for he makestuff module.  It
# may be used to install and remove modules stored in an external repository.
# By default:
#
# 1) repositories are assumed to be git-based
# 2) repositories are stored in the directory .makestuff
#
# Example (install a repo):
# 	makestuff.py --repo github.com/SummitStreet/makestuff@master.git install
#
# Example (refresh/update a repo):
# 	makestuff.py --repo github.com/SummitStreet/makestuff@master.git remove install
#
# Example (remove a repo):
# 	makestuff.py --repo github.com/SummitStreet/makestuff@master.git remove
#
# Example (remove all repos):
# 	makestuff.py removeall

import codecs
import json
import os
import re
import shutil
import sys

REPO_CLONE = "git clone -q --branch {ver} https://{repo}.git {dir}"
REPO_DIR = ".makestuff"
CONFIG_FILE = "makestuff.json"
TEMP_DIR = ".tmp"

class MakeStuff(CommandLineApp):
	"""
	Implements the CLI of the makestuff module.
	"""
	_version = 1.0
	repo_clone = None
	repo_dir = None
	repo = None
	config_file = None
	temp_dir = None
	config = None
	command = []

	def _load_config_file(self, repo_dir):
		"""
		Loads the external repository config file, makestuff.json.
		"""
		try:
			config_file = repo_dir + os.sep + self.config_file
			with codecs.open(config_file, encoding="utf-8") as makestuff_json:
				config_file_str = makestuff_json.read()
				self.config = json.loads(config_file_str)
		except IOError:
			msg = "{0}: Unable to load config file '{1}'."
			print msg.format(sys.argv[0], config_file)
		except ValueError:
			msg = "{0}: The config file '{1}' is not valid JSON."
			print msg.format(sys.argv[0], config_file)

	def _parse_repo(self):
		"""
		Extracts the repo name, version, and target directory from the repo URI.
		"""
		repo, version = re.match(r"(.+?)(@.*)?.git", sys.argv[2]).groups()
		directory = os.sep.join([self.repo_dir, repo, version[1:]])
		return (repo, version[1:], directory)

	def install(self):
		"""
		Installs the specified repository.
		"""
		repository, version, directory = self._parse_repo()
		msg = "{0}: Installing repository {1} [version: {2}] into {3}"
		print msg.format(sys.argv[0], repository, version, directory)
		if not os.path.isdir(directory):
 			os.system(self.repo_clone.format(repo=repository, ver=version, dir=directory))
			self._load_config_file(directory)
			temp_dir = self.repo_dir + os.sep + self.temp_dir
			shutil.rmtree(temp_dir, True)
			os.mkdir(temp_dir)
			for i in self.config["components"]:
 				shutil.move(directory + os.sep + i, temp_dir)
 			shutil.rmtree(directory)
 			shutil.move(temp_dir, directory)

	def path(self):
		"""
		Returns the location of the specified repository.
		"""
		msg = "{0}: Location of repository {1} [version: {2}] is {3}"
		repository, version, directory = self._parse_repo()
		print msg.format(sys.argv[0], repository, version, directory)
		return directory

	def remove(self):
		"""
		Removes the specified repository.
		"""
		msg = "{0}: Removing repository {1} [version: {2}] from {3}"
		repository, version, directory = self._parse_repo()
		print msg.format(sys.argv[0], repository, version, self.repo_dir)
		# Remove and then recreate the directory, then remove empty directories.
		shutil.rmtree(directory)
		os.mkdir(directory)
		os.removedirs(directory)

	def removeall(self):
		"""
		Removes all repositories.
		"""
		msg = "{0}: Removing all repositories from {1}"
		print msg.format(sys.argv[0], self.repo_dir)
		shutil.rmtree(self.repo_dir, True)

	def start(self):
		"""
		Invokes all commands provided via the command line.
		"""
		super(MakeStuff, self).start()
		try:
			for i in self.command:
				getattr(self, i)()
			return 0
		except:
			return -1

if __name__ == '__main__':
	sys.stdin = codecs.getreader("utf-8")(sys.stdin)
	sys.stdout = codecs.getwriter("utf-8")(sys.stdout)
	sys.stderr = codecs.getwriter("utf-8")(sys.stderr)
	DESCRIPTION = "CLI for the makestuff module."
	# Command-line args format: (name, required, type, nargs, default, action, help)
	COMMAND_LINE_ARGS = [
		("--repo-clone", False, str, None, REPO_CLONE, None, u"specify the repo clone command"),
		("--repo-dir", False, str, None, REPO_DIR, None, u"specify the clone destination directory"),
		("--repo", True, str, None, None, None, u"specify the repo to be cloned"),
		("--temp-dir", False, str, None, TEMP_DIR, None, u"specify a temporary directory"),
		("--config-file", False, str, None, CONFIG_FILE, None, u"specify the makestuff config file"),
		("command", True, str, "+", None, None, u"valid commands: install, remove, removall, path"),
	]
	sys.exit(MakeStuff(DESCRIPTION, COMMAND_LINE_ARGS, MakeStuff).run())
