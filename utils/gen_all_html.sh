#!/bin/bash
# Re-generates all HTML files from Markdown text
#
# Excludes any Markdown file matching *.raw.md
#
# (C) Copyright 2013 TJ <replicant@iam.tj>
# Licensed under the GNU General Public License version 3.0
# http://www.gnu.org/licenses/gpl-3.0.html
#

find . -regex '.*\.md$' ! -regex '.*\.raw\.md' | while read MD; do
 HTML="${MD%*md}html"
 echo "$MD = $HTML"
 utils/gen_html.sh "$MD" "$HTML"
done
