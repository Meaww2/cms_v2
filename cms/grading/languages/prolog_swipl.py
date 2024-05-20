#!/usr/bin/env python3

# Contest Management System - http://cms-dev.github.io/
# Copyright © 2016 Stefano Maggiolo <s.maggiolo@gmail.com>
# Copyright © 2020 Andrey Vihrov <andrey.vihrov@gmail.com>
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License as
# published by the Free Software Foundation, either version 3 of the
# License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Affero General Public License for more details.
#
# You should have received a copy of the GNU Affero General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

"""Prolog programming language definition."""

from cms.grading import CompiledLanguage


__all__ = ["PrologSwipl"]


class PrologSwipl(CompiledLanguage):
    """This defines the C++ programming language, compiled with g++ (the
    version available on the system) using the C++17 standard.

    """

    @property
    def name(self):
        """See Language.name."""
        return "Prolog / swipl"

    @property
    def source_extensions(self):
        """See Language.source_extensions."""
        return [".pl", ".pro"]

    def get_compilation_commands(self,
                                 source_filenames, executable_filename,
                                 for_evaluation=True):
        """See Language.get_compilation_commands."""
        command = ["/usr/bin/swipl"]
        if for_evaluation:
            command += ["-O"]
        if len(source_filenames) == 1:
            command += ["--goal=main"]
        else:
            command += ["--goal=grader_main"]
        command += ["-o", executable_filename, "-c", source_filenames[0]]
        return [command]
