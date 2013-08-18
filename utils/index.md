# UTILITIES

[TOC]

## Generating HTML from Markdown (.md) text files

On the assumption that you're using a pretty standard Linux-based OS then these instructions should work
for you to (re)-generate HTML files from Markdown text.

I use Ubuntu so these instructions should also work for Debian and all Debian-based derivatives.

Ensure the Python Markdown libraries are installed:

    sudo apt-get install python-markdown

In the root of the project directory is the text file "markdown-extensions.txt". It contains a list, one extension per line, of all the Markdown extensions to use. If you're using the GUI-based ReText application (as I do: `sudo apt-get install retext`) it will read this file to determine which extensions to use for its Preview function. Because there are Markdown text files in sub-directories too I recommend copying the file to `~/.config/` so that it applies globally to ReText. If not, a copy - or symbolic or hard link - needs to be in every directory that contains Markdown text files in order for ReText to find and use it.

>**Note:** I've found there are bugs in the QT rendering library so its best to do **Edit > Use WebKit renderer**.

I also use the "markdown-extensions.txt" file to tell `utils/gen_html5.py` which extensions to use.

`utils/gen_html5.py` is a Python script that calls on the markdown library and encapsulates the generated HTML tags into a complete HTML DOCTYPE template. It will include in-line any text from the file "style.css" in the current working directory into a `<style>` tag.  It will look for a `<h1>` tag in the generated HTML and if found take its content to create a `<title>` tag in the `<head>` of the document. Output is written to STDOUT and therefore can be redirected as required.

Working always in the directory at the root of the project repository, to generate HTML from a specific Markdown do:

    utils/gen_html.sh <path/to/input.md> <path/to/output.html>

To (re)-generate HTML for every Markdown text file in the project (but ignoring all those matching `*.raw.md`):

    utils/gen_all_html.sh

## Generating the GLOSSARY

Markdown text files ending `.raw.md` are special cases which I use for creating and generating the Glossary.

`GLOSSARY.html` is generated from `GLOSSARY.md`, which in turn is generated from `GLOSSARY.raw.md`. The reason for this indirection is to allow entry of terms in the glossary in unsorted order (just add new terms at the end of `GLOSSARY.raw.md`). When it is time to generate a new (sorted) `GLOSSARY.md` do:

    utils/glossary.gawk <GLOSSARY.raw.md >GLOSSARY.md

To sort the entries in `GLOSSARY.raw.md` to make editing easier:

    echo "$(utils/glossary.raw.gawk GLOSSARY.raw.md)" >GLOSSARY.raw.md

These commands call GNU awk (gawk) scripts that use GNU awk's `asort()` function so please ensure that is installed too:

    sudo apt-get install gawk
