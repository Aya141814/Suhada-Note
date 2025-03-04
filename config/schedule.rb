# Use this file to easily define all of your cron jobs.
env :PATH, ENV["PATH"]
set :output, "/var/log/cron.log"
set :environment, ENV["RAILS_ENV"]
