#!/bin/bash

echo "#Gemfile
source 'https://rubygems.org'

gem 'kitchen-salt'
gem 'kitchen-docker'
gem 'kitchen-sync'">>Gemfile
~/.rbenv/versions/3.2.2/bin/bundle install



