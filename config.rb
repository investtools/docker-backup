# encoding: utf-8

##
# Backup v5.x Configuration
#
# Documentation: http://backup.github.io/backup
# Issue Tracker: https://github.com/backup/backup/issues

root_path '/Backup'

Logger.configure do
  logfile.enabled = false
end

Utilities.configure do
  mongodump '/usr/local/bin/mongodump'
end

