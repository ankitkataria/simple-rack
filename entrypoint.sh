#!/bin/sh

# Start server at 9292
bundle exec rackup --host 0.0.0.0 --port 3001 config.ru
