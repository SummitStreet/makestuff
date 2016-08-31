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

#pylint: disable=bad-continuation, mixed-indentation, too-few-public-methods

import codecs
import inspect
import os
import re
import sys

class Group(object):
	"""
	Group multiple, like sequences into a single location, the number of lines
	does not change.
	"""

	@staticmethod
	def parse(source_code, regular_expressions, sort_matching_lines=True):
		"""
		Parses the source code, group multiple, like sequences into a single
		location.
		"""
		matching_lines = []
		start_pos = len(source_code)
		for regex in regular_expressions:
			matching_lines += re.findall(regex, source_code)
			match = re.search(regex, source_code)
			if match and match.start() < start_pos:
				start_pos = match.start()

		matching_lines = list(set(matching_lines))
		if sort_matching_lines:
			matching_lines = sorted(matching_lines)
		source_code = Remove.parse(source_code, regular_expressions)
		return source_code[:start_pos] + "\n".join(matching_lines) + source_code[start_pos:]

class Merge(object):
	"""
	Merge multiple, like sequences into a line and location.
	"""

	@staticmethod
	def parse(source_code, delimiter, regular_expression, sort_items=True):
		"""
		Parses the source code, consolidates multiple, like sequences.
		"""
		result = ""
		constant = None
		items = []
		first_match_pos = 0
		for line in source_code.splitlines():
			matching_items = re.findall(regular_expression, line)
			if matching_items and matching_items[0] and matching_items[0][0]:
				if not first_match_pos:
					first_match_pos = len(result)
					constant = matching_items[0][0]
				items += [i for j in matching_items[1:] for i in j if i]
			else:
				result += line + "\n"

		temp_set = set()
		items = [i for i in items if i and not (i in temp_set or temp_set.add(i))]
		if sort_items:
			items = sorted(items)
 		consolidated_text = "" if not constant else constant + delimiter.join(items) + "\n"
		return result[:first_match_pos] + consolidated_text+ result[first_match_pos:]

class Remove(object):
	"""
	Removes unneeded sequences (e.g.: comments) from the source code.
	"""

	@staticmethod
	def parse(source_code, regular_expressions):
		"""
		Parses the source code, removes matching strings.
		"""
		for regex in regular_expressions:
			source_code = re.sub(regex, "", source_code)
		return source_code

class RemoveExtraBlankLines(object):
	"""
	Removes extra blank lines from the source code.
	"""

	@staticmethod
	def parse(source_code):
		"""
		Parses the source code, removes extra blank lines.
		"""
		retained_lines = []
		for current_line in source_code.splitlines():
			current_line = current_line.rstrip()
			if current_line or (retained_lines and retained_lines[-1]):
				retained_lines.append(current_line)
		return "\n".join(retained_lines)

class Singleton(object):
	"""
	Removes all but one occurrence of a string from the source code.
	"""

	@staticmethod
	def parse(source_code, regular_expressions):
		"""
		Parses the string, removes all but one occurrence of the strings matching
		the regular expressions provided via the constructor.
		"""
		for regex in regular_expressions:
			strings = set()
			strings = [s for s in re.split(regex, source_code) if not (s in strings or strings.add(s))]
			source_code = "".join(strings)
		return source_code

class JavaScript(object):
	"""
	TODO
	"""
	extension = ["js"]

	@classmethod
	def merge(cls, source_code):
		"""
		TODO
		"""
		source_code = Remove.parse(source_code, [
			r"//.*?\n",
			r"/\*(?!\s*eslint).*\*/",
			re.compile(r"/\*[^*]*^.*?\*/", re.DOTALL | re.MULTILINE)
		])
		source_code = Singleton.parse(source_code, [
			r"(\"use strict\";)"
		])
		source_code = RemoveExtraBlankLines.parse(source_code)
		return source_code

class Python(object):
	"""
	TODO
	"""
	extension = ["py"]

	@classmethod
	def merge(cls, source_code):
		"""
		TODO
		"""
		source_code = Singleton.parse(source_code, [
			r"^(#!/usr/bin/env python)"
			r"^(# -\*- coding: utf-8 -\*-)"
		])
		source_code = Merge.parse(source_code, ", ", r"^(#pylint: enable=)|([\w-]+)(?:,|$)")
		source_code = Merge.parse(source_code, ", ", r"^(#pylint: disable=)|([\w-]+)(?:,|$)")
		source_code = Group.parse(source_code, [
			re.compile(r"^from .* import .*", re.MULTILINE),
			re.compile(r"^import .*", re.MULTILINE)
		])
		#r"(?!from .*)import .*"
		source_code = RemoveExtraBlankLines.parse(source_code)
		return source_code

class MakestuffMerge(object):
	"""
	TODO
	"""

	source_types = set()
	source_code = u""
	source_file_names = []

	@classmethod
	def load_source_files(cls):
		"""
		TODO
		"""
		for file_name in cls.source_file_names:
			_, extension = os.path.splitext(file_name)
			cls.source_types.add(extension[1:])
			with codecs.open(file_name, encoding="utf-8") as input_file:
				cls.source_code += input_file.read() + "\n"

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
					return target.merge(MakestuffMerge.source_code)
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

