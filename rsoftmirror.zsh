#!/usr/bin/zsh

# This script requires $HOME/.yek/rsoftmirrorrc
if [[ ! -e $HOME/.yek/rsoftmirrorrc ]]
then
  print "rc file isn't exist. Abort" >&2
  exit 1
fi

# Standard style rsync
# $1 -> master dir
# $2 -> slave dir (with host)
# $3 -> keyfile
# For rc file definition.
do_mirror() {
  rsync -auv --delete-after -e "ssh -i $3" $1 $2 >&2
}

# rc file must define sync_start()
# This script calls sync_start
. $HOME/.yek/rsoftmirrorrc


notify-send "${start_message:-RSoftSync Progress...}"

sync_start

notify-send "${end_message:-RSoftSync Finished.}"


at now + ${=sync_interval:-15 minutes} << $0