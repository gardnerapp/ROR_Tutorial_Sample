#Puma config file, should be available @heroku docs

max_threads_count = ENV.fetch('RAILS_MAX_THREADS') {5}
min_threads_count = ENV.fetch('RAILS_MINX_THREADS') {max_threads_count}
threads min_threads_count, max_threads_count
port    ENV.fetch("PORT") {3000}
enviroment ENV.fetch("RAILS_ENV") {ENV['RACK_ENV'] ||"development" }
pidfile ENV.fetch("PIDFILE") {"tmp/pids/server.pid"}
workers ENV.fetch("WEB_CONCURRENCY") {2}
preload_app!
plugin :tmp_restart 