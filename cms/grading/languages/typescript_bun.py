#!/usr/bin/env python3

# Contest Management System - http://cms-dev.github.io/
# Copyright © 2016 Stefano Maggiolo <s.maggiolo@gmail.com>
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

"""TypeScript programming language definition."""

import os
import string
from cms.grading import CompiledLanguage


__all__ = ["TypeScriptBun"]


class TypeScriptBun(CompiledLanguage):
    """This defines the TypeScript programming language, compiled with bun
    (the version available on the system).

    """

    @property
    def name(self):
        """See Language.name."""
        return "TypeScript / bun"

    @property
    def source_extensions(self):
        """See Language.source_extensions."""
        return [".ts"]

    def get_compilation_commands(self,
                                 source_filenames, executable_filename,
                                 for_evaluation=True):
        """See Language.get_compilation_commands."""
        commands = []

        commands.append(["/usr/bin/bun", "build", "--compile",
                         "--target=bun", "--outfile", executable_filename,
                         source_filenames[0]])
        return commands
