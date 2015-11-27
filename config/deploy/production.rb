set :stage, :production
set :rails_env, :production

server '52.27.86.62', user: 'ubuntu', roles: %w{web app db}, primary: true