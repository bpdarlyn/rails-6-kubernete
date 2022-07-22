#!/usr/bin/env bash

bundle install
bundle exec rails assets:precompile
bundle exec rails db:migrate
cmd="$@"
exec $cmd