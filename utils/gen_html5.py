#!/usr/bin/python
# Generates a complete HTML5 DOCTYPE  document with <title> from a Markdown text document using the Python Markdown library
# (C) Copyright 2013 TJ <replicant@iam.tj>
# Licensed under the GNU General Public License version 3.0
# http://www.gnu.org/licenses/gpl-3.0.html
#

import markdown
import os, sys
import re, StringIO
from collections import deque

def footnote_format(mo):
  return '<a href="#fn_' + mo.group(1) + '"><sup>' + mo.group(1) + '</sup></a>'

extensions = list(line.rstrip('\n') for line in open("markdown-extensions.txt"))

output_html = StringIO.StringIO()
output_html.write("""
 <body>
""")

markdown.markdownFromFile(input=sys.argv[1], extensions=extensions, output_format="html5", output=output_html)
output_html.write("""
 </body>
</html>
""")

output_body = output_html.getvalue()
output_html.close()

# convert into a list of lines and add element.id anchors footnotes
body = deque([])
references = deque([])
urls = deque([])
reference_heading = None
lines = output_body.split('\n')
for line in lines:
  if not reference_heading:
    reference_heading = re.search(r"(<h.+>References</h.>)", line)
  elif reference_heading:
    reference = re.match(r'^<li><a href="(.*)">(.*)</a></li>', line)
    if reference:
      references.append(reference.group(2))
      urls.append(reference.group(1))
      line =  '<li id="fn_' + str(len(references)) + '"><a href="' + urls[-1] + '">' + references[-1] + '</a></li>'
  body.append(line)

# now rebuild the body whilst inserting footnote links
output_body = ""
# replace footnote markers '[^1]' with '<a href="#fn_1"><sup>1</sup></a>'
for line in body:
  line = re.sub(r"\[\^(\d+)(\])", footnote_format, line)
  output_body += line + "\n"

output_head = """<!DOCTYPE html>
<html lang="en">
 <head>
  <meta charset="utf-8">
"""

title = re.search(r"<h1.+>(.*)</h1>", output_body)
if title:
  output_head += "  <title>"+title.group(1)+"</title>\n"

l_rel_path = os.path.relpath(os.path.dirname(os.path.realpath(sys.argv[1]))).split('/')

relative_path = ""
for p in range(0, len(l_rel_path)):
    if l_rel_path[p] != '.':
        relative_path += "../"

#  <link rel="stylesheet" href="style.css" type="text/css" media="screen" />
output_head += '  <link rel="stylesheet" href="' + relative_path + 'style.css" type="text/css" media="screen" />'

output_head += """
 </head>
"""

print(output_head + output_body)
