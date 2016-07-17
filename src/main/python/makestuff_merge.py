#!/usr/bin/env python
# -*- coding: utf-8 -*-

"""
Merges multiple source code files into a single file.

For Python scripts, import statements and pylint directives are merged so that
regardless of the number of source files, these statements are located in the
same section of the resulting output file.  In addition, singleton statements
are included in the output file only one time.

"""

#** makestuff/src/main/python/makestuff_merge.py

#pylint: disable=bad-continuation, mixed-indentation

import codecs
import inspect
import os
import re
import sys

class PythonImport(object):
	"""
	TODO
	"""
	regex = [r"import ", r"from.*import"]
	imports = []

	@classmethod
	def inject(cls, script_lines, source_line):
		"""
		TODO
		"""
		# Add all import statements when the 1st import line is encountered.
		if any([re.match(r, source_line) for r in cls.regex]):
			if cls.imports:
				script_lines += cls.imports
				cls.imports = []
			return True
		return False

	@classmethod
	def parse(cls, source_lines):
		"""
		TODO
		"""
		cls.imports = sorted(set([i for i in source_lines if any([re.match(r, i) for r in cls.regex])]))

class PythonPylintDirective(object):
	"""
	TODO
	"""

	regex = [r"#pylint: disable=", r"#pylint: enable="]
	directives = []

	@classmethod
	def inject(cls, script_lines, source_line):
		"""
		TODO
		"""
		# Add all pylint directives when the 1st pylint directive is encountered.
		if any([re.match(r, source_line) for r in cls.regex]):
			if cls.directives:
				script_lines += cls.directives
				cls.directives = []
			return True
		return False

	@classmethod
	def parse(cls, source_lines):
		"""
		TODO
		"""
		lines = [i for i in source_lines if any([re.match(r, i) for r in cls.regex])]
		lines = [[i[len(r):] for i in lines if i.startswith(r) and i[len(r):]] for r in cls.regex]
		lines = [", ".join(sorted(set([j.strip() for j in (",".join(i)).split(",")]))) for i in lines]
		cls.directives = [cls.regex[i] + lines[i] for i in range(len(cls.regex)) if lines[i]]

class PythonSingleton(object):
	"""
	TODO
	"""
	regex = [
		r"#!/usr/bin/env python",
		r"# -\*- coding: utf-8 -\*-"
	]
	singleton_lines = set()

	@classmethod
	def inject(cls, script_lines, source_line):
		"""
		TODO
		"""
		if any([re.match(r, source_line) for r in cls.regex]):
			if not source_line in cls.singleton_lines:
				script_lines += [source_line]
			cls.singleton_lines.add(source_line)
			return True
		return False

	@classmethod
	def parse(cls, source_lines):
		"""
		TODO
		"""

class Python(object):
	"""
	TODO
	"""
	extension = ["py"]
	python_import = PythonImport()
	python_pylint_directive = PythonPylintDirective()
	python_singleton = PythonSingleton()

	@classmethod
	def assemble(cls, source_lines):
		"""
		TODO
		"""
		script_lines = []
		for i in source_lines:

			# Remove all but one occurrence of singleton lines.
			if cls.python_singleton.inject(script_lines, i):
				continue

			# Combine pylint directives.
			if cls.python_pylint_directive.inject(script_lines, i):
				continue

			# Add all import statements when the first import line is encountered.
			if cls.python_import.inject(script_lines, i):
				continue

			script_lines += [i]
		return script_lines

	@classmethod
	def merge(cls, source_lines):
		"""
		TODO
		"""
		cls.python_import.parse(source_lines)
		cls.python_pylint_directive.parse(source_lines)
		return cls.assemble(source_lines)

class MakestuffMerge(object):
	"""
	TODO
	"""

	source_types = set()
	source_lines = []
	source_file_names = []
	target_lines = []

	@classmethod
	def load_source_files(cls):
		"""
		TODO
		"""
		for file_name in cls.source_file_names:
			_, extension = os.path.splitext(file_name)
			cls.source_types.add(extension[1:])
			with codecs.open(file_name, encoding="utf-8") as input_file:
				cls.source_lines += input_file.read().splitlines()

	@classmethod
	def merge(cls):
		"""
		TODO
		"""
		key = "extension"
		for target in [o for _, o in inspect.getmembers(sys.modules[__name__], inspect.isclass)]:
			if hasattr(target, key):
				value = getattr(target, key)
				if cls.source_types < set(value) or cls.source_types == set(value):
					cls.target_lines = target.merge(MakestuffMerge.source_lines)
					return "\n".join(cls.target_lines)
		err_msg = "Unsupported file extension: ext='{0}'.".format(", ".join(cls.source_types))
		raise ValueError(err_msg)

	@classmethod
	def run(cls, source_file_names):
		"""
		TODO
		"""
		cls.source_file_names = source_file_names
		cls.load_source_files()
		return cls.merge()

if __name__ == "__main__":
    SCRIPT_LINES = MakestuffMerge.run(sys.argv[1:])
    print SCRIPT_LINES
