#!/usr/bin/gawk -f
# Reads an unsorted raw glossary and outputs it as a sorted raw glossary
# (C) Copyright 2013 TJ <replicant@iam.tj>
# Licensed under the GNU General Public License version 3.0
# http://www.gnu.org/licenses/gpl-3.0.html
#
# The format of the input data should be one line per definition with the term suffixed with a colon and one or more spaces as separation. E.g:
# TERM:  My Definition
# Another TERM: Another definition
#
# lines with any other format will be left untouched.
# However, note that all such lines will be placed at the beginning of the output because the term list is
# only printed once all lines have been read and sorted.

BEGIN {
 count=0;
}

$0 !~ /^[[:alnum:]][-_\/[:alnum:] ]+:.+/ && !count {
 print $0
}


$0 ~ /^[[:alnum:]][-_\/[:alnum:] ]+:.+/ {
 count++;
 dl[count]=$0;
}

END {
 close(0);
 IGNORECASE=1;
 asort(dl);
 for (i=1;i<=count;i++)
 {
  split(dl[i],kv,":");
  # trim leading and trailing white-space
  gsub(/(^ +| +$)/,"",kv[1]);
  gsub(/(^ +| +$)/,"",kv[2]);
  printf("%s: %s\n\n",kv[1],kv[2])
 }
}
