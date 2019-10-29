#!/bin/sh

# This file does lots of running around before generating a new AIDE database.

if [ -f /var/lib/aide/aide.conf ]
  then
  # override the existing AIDE configuration file if exists
  # in the database directory.
  echo "Found /var/lib/aide/aide.conf. Overriding the default configuration with this."
  ln -sf /var/lib/aide/aide.conf /etc/aide.conf
  chmod 600 /var/lib/aide/aide.conf
  echo ""
fi

# Generate a new database
if [ ! -f /var/lib/aide/aide.db.gz ]
  then
  echo "Generating a new AIDE database in /var/lib/aide/aide.db.gz..."
  /usr/sbin/aide --init
  mv -vf /var/lib/aide/aide.db.new.gz /var/lib/aide/aide.db.gz
  echo "Done generating AIDE database... exiting..."
else
  echo "Found existing AIDE database in /var/lib/aide/aide.db.gz"
  echo ""
  echo "Executing AIDE as normal..."
  /usr/sbin/aide --update -c /etc/aide.conf -B database=file:/var/lib/aide/aide.db.gz -B database_out=file:/var/lib/aide/aide.db.new.gz
  mv -vf /var/lib/aide/aide.db.new.gz /var/lib/aide/aide.db.gz
fi
