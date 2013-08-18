#!/bin/sh
#
# Upload only web-site HTML and supporting assets
#
# (C) Copyright 2013 TJ <replicant@iam.tj>
# Licensed under the GNU General Public License version 3.0
# http://www.gnu.org/licenses/gpl-3.0.html
#


# default values unless over-ridden by calling environment
REMOTE_USER=${REMOTE_USER:-iam}
REMOTE_HOST=${REOMTE_HOST:-pella}
REMOTE_PATH_BASE=${REMOTE_PATH_BASE:-public_html/projects/hacking/}

rsync -vr --include='*.html' --include='style.css' --include='utils/' --include='101/' --include='201/' --include='301/' --exclude='*.md' --exclude='*.zip' --exclude='.git/' --exclude='*' . $REMOTE_USER@$REMOTE_HOST:$REMOTE_PATH_BASE

