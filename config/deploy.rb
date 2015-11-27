# config valid only for current version of Capistrano
lock '3.4.0'

set :rvm_type
set :rvm_ruby_version, '2.2.3'

set :application, 'blogo'
set :deploy_to, "/home/ubuntu/www/#{fetch(application)}"
set :scm, :git
set :repo_url, 'https://github.com/Cicuta364/Blogo.git'
set :branch, 'master'

set :linked_files, %w{config/database.yml config/secrets.yml .env}
set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system public/uploads}

set :keep_releases, 4