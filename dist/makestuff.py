#!/usr/bin/env python
# -*- coding: utf-8 -*-

#** launchpad/src/main/python/app.py

"""
	The MIT License (MIT)

	Copyright (c) 2016 David Padgett/Summit Street, Inc.

	Permission is hereby granted, free of charge, to any person obtaining a copy
	of this software and associated documentation files (the "Software"), to deal
	in the Software without restriction, including without limitation the rights
	to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
	copies of the Software, and to permit persons to whom the Software is
	furnished to do so, subject to the following conditions:

	The above copyright notice and this permission notice shall be included in
	all copies or substantial portions of the Software.

	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
	IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
	FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
	AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
	LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
	OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
	SOFTWARE.
"""

#pylint: disable=bad-continuation, bare-except, mixed-indentation

from abc import ABCMeta, abstractmethod
import argparse
import codecs
import datetime
import inspect
import json
import logging
import os
import re
import shutil
import sys
import traceback

class Service(object):
	"""
	This abstract class implements the shell of an command-line app.
	"""
	__metaclass__ = ABCMeta
	_version = 0.1
	start_date_time = None
	log_level = "WARNING"
	log_date_format = "%Y-%m-%d %H:%M:%S"
	log_kv_format = "{0}={1}"
	log_format = "{date} [{level}] [{app}] [{api}] [{message}] {values}"

	# Command-line args format: (name, required, type, nargs, default, action, help)
	__command_line_args = [
		("--log-level", False, str, None, log_level, None, u"set the log output level"),
		("--log-date-format", False, str, None, log_date_format, None, u"set the log date format"),
		("--log-kv-format", False, str, None, log_kv_format, None, u"set the log key/value format"),
		("--log-format", False, str, None, log_format, None, u"set the log line format")
	]

	@classmethod
	def _format_message(cls, level, message, data):
		"""
		Formats a log message.
		"""
		date = datetime.datetime.now().strftime(cls.log_date_format)
		app = sys.argv[0]
		api = inspect.stack()[2][3]
		values = ", ".join([cls.log_kv_format.format(i, j) for i, j in data.iteritems()])
		msg = cls.log_format
		return msg.format(date=date, app=app, level=level, api=api, message=message, values=values)

	@staticmethod
	def _get_elapsed_time():
		"""
		TODO
		"""
		elapsed_date_time = datetime.datetime.now() - Service.start_date_time
		hours, minutes = divmod(elapsed_date_time.seconds, 3600)
		minutes, seconds = divmod(minutes, 60)
		return (elapsed_date_time.days * 24 + hours, minutes, seconds)

	@classmethod
	def log_debug(cls, message, **data):
		"""
		Prints a debug level log message.
		"""
		logging.debug(cls._format_message("DBG", message, data))

	@classmethod
	def log_info(cls, message, **data):
		"""
		Prints an info level log message.
		"""
		logging.info(cls._format_message("INF", message, data))

	@classmethod
	def log_critical(cls, message, **data):
		"""
		Prints a critical level log message.
		"""
		logging.critical(cls._format_message("CRI", message, data))

	@classmethod
	def log_error(cls, message, **data):
		"""
		Prints an error level log message.
		"""
		logging.error(cls._format_message("ERR", message, data))

	@classmethod
	def log_system(cls, message, **data):
		"""
		Prints a system level log message.
		"""
		logging.log(logging.SYSTEM, cls._format_message("SYS", message, data))

	@classmethod
	def log_warning(cls, message, **data):
		"""
		Prints a warning level log message.
		"""
		logging.warning(cls._format_message("WRN", message, data))

	def __init__(self, description, command_line_args, *args):
		"""
		Ensures that the comamand-line is configured/initialized.
		"""
		cli = self.__command_line_args[:]
		cli.extend(command_line_args)
		self.__config(description, cli, args if args else [self.__class__])

	def __config(self, description, command_line_args, configurable_types):
		"""
		Initializes the ArgumentParser and injects command-line arguments as
		static variables into the types defined in the module.
		"""
		sys.stdin = codecs.getreader("utf-8")(sys.stdin)
		sys.stdout = codecs.getwriter("utf-8")(sys.stdout)
		sys.stderr = codecs.getwriter("utf-8")(sys.stderr)

		# Create and initialize an ArgumentParser.
		parser = argparse.ArgumentParser(description=description)
		parser.add_argument("--version", action="version", version="%(prog)s v" + str(self._version))
		for i in command_line_args:
			params = dict(required=i[1], type=i[2], nargs=i[3], default=i[4], action=i[5], help=i[6])
			# Positional arguments do not use required.
			if i[0][:2] != "--":
				del params["required"]
			# Boolean arguments do not use type or nargs.
			if i[2] == bool:
				params.pop("type", None)
				params.pop("nargs", None)
			parser.add_argument(i[0], **params)

		# Inject argument values into all types within the module with matching
		# names.
		for key, value in vars(parser.parse_args()).iteritems():
			for obj in configurable_types:
				if hasattr(obj, key):
					setattr(obj, key, value)

		# Initialize the Python logging module.
		logging.SYSTEM = 60
		logging.addLevelName(logging.SYSTEM, "SYSTEM")
		level = getattr(logging, self.log_level)
		logging.basicConfig(level=level, format="%(message)s")

		# Display the parameter list.
		for key, value in vars(parser.parse_args()).iteritems():
			for obj in configurable_types:
				if hasattr(obj, key):
					self.log_info("Parameter", obj=obj.__name__, name=key, value=value)

	def initialize(self):
		"""
		App-specific initialization should occur here.
		"""
		self.log_system("Initializing {0}".format(type(self).__name__))

	def run(self):
		"""
		Runs the app.
		"""
		try:
			Service.start_date_time = datetime.datetime.now()
			self.log_system("Running {0}".format(type(self).__name__))
			self.initialize()
			self.start()
			self.stop()
			hours, minutes, seconds = self._get_elapsed_time()
			elapsed_time = "{0}h:{1}m:{2}s".format(hours, minutes, seconds)
			self.log_system("Succeeded", elapsed_time=elapsed_time)
		except:
			hours, minutes, seconds = self._get_elapsed_time()
			elapsed_time = "{0}h:{1}m:{2}s".format(hours, minutes, seconds)
			self.log_critical("Failed", elapsed_time=elapsed_time)
			traceback.print_exc(file=sys.stderr)
			return -1
		return 0

	@abstractmethod
	def start(self):
		"""
		App-specific startup tasks should be added here.
		"""
		self.log_system("Starting {0}".format(type(self).__name__))

	def stop(self):
		"""
		App-specific shutdown tasks should be added here.
		"""
		self.log_system("Stopping {0}".format(type(self).__name__))

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

REPO_CLONE = "git clone -q --branch {ver} https://{repo}.git {dir}"
REPO_DIR = ".makestuff"
CONFIG_FILE = "makestuff.json"
TEMP_DIR = ".tmp"

class MakeStuff(Service):
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
			self.log_system("Unable to load config file '{0}'.".format(config_file))

		except ValueError:
			self.log_system("The config file '{0}' is not valid JSON.".format(config_file))

	def _parse_repo(self):
		"""
		Extracts the repo name, version, and target directory from the repo URI.
		"""
		repo, version = re.match(r"(.+?)(@.*)?.git", sys.argv[2]).groups()
		version = version if version else "@master"
		directory = os.sep.join([self.repo_dir, repo, version[1:]])
		return (repo, version[1:], directory)

	def install(self):
		"""
		Installs the specified repository.
		"""
		repository, version, directory = self._parse_repo()
		msg = "Installing repository {0} (version: {1}) into {2}".format(repository, version, directory)
		self.log_system(msg)

		if not os.path.isdir(directory):
 			os.system(self.repo_clone.format(repo=repository, ver=version, dir=directory))
			self._load_config_file(directory)
			temp_dir = self.repo_dir + os.sep + self.temp_dir
			shutil.rmtree(temp_dir, True)
			os.makedirs(temp_dir)
			files = self.config["components"]
			prefix = os.path.commonprefix(self.config["components"])
			files = [(directory + os.sep + i, temp_dir + os.sep + i[len(prefix):]) for i in files]
			for i in files:
				source = i[0]
				target = i[1]
				if os.path.isfile(source) and not os.path.exists(os.path.dirname(target)):
					target = os.path.dirname(target)
					os.makedirs(target)
				shutil.move(source, target)
 			shutil.rmtree(directory)
 			shutil.move(temp_dir, directory)

	def path(self):
		"""
		Returns the location of the specified repository.
		"""
		repository, version, directory = self._parse_repo()
		msg = "Location of repository {0} [version: {1}] is {2}.".format(repository, version, directory)
		self.log_system(msg)
		return directory

	def remove(self):
		"""
		Removes the specified repository.
		"""
		repository, version, directory = self._parse_repo()
		msg = "Removing repository {0} [version: {1}] from {2}".format(repository, version, self.repo_dir)
		self.log_system(msg)
		# Remove and then recreate the directory, then remove empty directories.
		shutil.rmtree(directory)
		os.mkdir(directory)
		os.removedirs(directory)

	def removeall(self):
		"""
		Removes all repositories.
		"""
		self.log_system("Removing all repositories from {0}.".format(self.repo_dir))
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

