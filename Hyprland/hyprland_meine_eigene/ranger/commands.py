from __future__ import (absolute_import, division, print_function)
import os
from ranger.api.commands import Command

class my_edit(Command):
    """:my_edit <filename>
    A sample command for demonstration purposes that opens a file in an editor.
    """
    def execute(self):
        if self.arg(1):
            target_filename = self.rest(1)
        else:
            target_filename = self.fm.thisfile.path

        self.fm.notify("Let's edit the file " + target_filename + "!")

        if not os.path.exists(target_filename):
            self.fm.notify("The given file does not exist!", bad=True)
            return

        self.fm.edit_file(target_filename)

    def tab(self, tabnum):
        return self._tab_directory_content()

# Verhindert das Einfrieren auf USB-Sticks/Platten
class cd(Command):
    def execute(self):
        path = self.rest(1)
        if path.startswith('/run/media/georg'):
            self.fm.settings.preview_files = False
            self.fm.settings.preview_directories = False
            self.fm.settings.automatically_count_files = False
        else:
            self.fm.settings.preview_files = True
            self.fm.settings.preview_directories = True
            self.fm.settings.automatically_count_files = True
        self.fm.cd(path)
