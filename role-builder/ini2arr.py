#!/usr/bin/env python

# from: http://serverfault.com/questions/345665/parse-and-convert-ini-into-bash-array-variables

import sys, ConfigParser

config = ConfigParser.ConfigParser()
config.readfp(sys.stdin)

if len(sys.argv) > 1 and sys.argv[1] == '--containers':
  for sec in config.sections():
    print sec
else:
  try:
    print config.get(sys.argv[1], sys.argv[2])
  except:
  	print ""

# print "No " + sys.argv[1] + ":" + sys.argv[2] + " defined, using defaults."
# for sec in config.sections():
#   for key, val in config.items(sec):
#       print '%s[%s]="%s"' % (sec, key, val)