#!/bin/bash
# Generates an HTML5 document from a Markdown text document using the Python Markdown library
# (C) Copyright 2013 TJ <replicant@iam.tj>
# Licensed under the GNU General Public License version 3.0
# http://www.gnu.org/licenses/gpl-3.0.html
#

if [ $# -ne 2 ]; then
  echo "usage $0 <input.md> <output.html>"
  exit 0
fi

utils/gen_html5.py "$1" style.css  >"$2"
