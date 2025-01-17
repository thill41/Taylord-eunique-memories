# config valid for current version and patch releases of Capistrano
lock '~> 3.19.1'

set :ruby_version, '3.3.3'
set :application, 'tem'
set :repo_url, 'git@github.com:vmcilwain/Taylord-eunique-memories.git'
set :rails_env, fetch(:stage)

# set :bundle_binstubs, -> { release_path.join('bin') }
set :bundle_binstubs, -> { shared_path.join('bin') }
SSHKit.config.command_map[:bundle] = 'asdf exec bundle'

set :default_env, {
  'PATH' => '$HOME/.asdf/shims:$HOME/.asdf/bin:$PATH'
}

set :asdf_tools_version, {
  ruby: '3.3.3',
  nodejs: '21.6.2'
}

set :asdf_ruby_version, 'ruby-3.3.3'
set :asdf_map_bins, %w[ruby gem bundle]

# set :default_shell, '/bin/bash -l'

set :ssh_options, {
  keys: %w[~/.ssh/id_rsa],
  forward_agent: true
}

set :bundle_cmd, '/home/deploy/.asdf/shims/bundle' # Change this path to where bundler is installed

# Puma-specific settings
set :puma_threads,    [4, 16]
set :puma_workers,    0
set :puma_bind,       "unix://#{shared_path}/tmp/sockets/#{fetch(:application)}-puma.sock"
set :puma_state,      "#{shared_path}/tmp/pids/puma.state"
set :puma_pid,        "#{shared_path}/tmp/pids/puma.pid"
set :puma_access_log, "#{release_path}/log/puma.access.log"
set :puma_error_log,  "#{release_path}/log/puma.error.log"
set :puma_preload_app, true
set :puma_worker_timeout, nil
set :puma_init_active_record, true

# Default branch is :master
ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, "/home/deploy/#{fetch(:application)}"

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
append :linked_files, 'config/database.yml', 'config/credentials/production.key', 'config/master.key'

# Default value for linked_dirs is []
append :linked_dirs, 'log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', '.bundle', 'public/system', 'public/uploads', 'storage'

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for local_user is ENV['USER']
# set :local_user, -> { `git config user.name`.chomp }

# Default value for keep_releases is 5
# set :keep_releases, 5

# Uncomment the following to require manually verifying the host key before first deploy.
# set :ssh_options, verify_host_key: :secure

desc 'Debug Environtment'
task :debug_env do
  on roles(:app) do
    execute :echo, '$PATH'
    execute :asdf, 'current'
    execute :which, 'ruby'
    execute :ruby, '-v'
    execute :which, 'bundle'
    execute :bundle, '-v'
  end
end

desc 'Check Ruby and Bundler versions'
task :check_versions do
  on roles(:app) do
    execute 'echo $PATH'
    execute 'which ruby'
    execute 'ruby -v'
    execute 'which bundle'
    execute 'bundle -v'
  end
end

namespace :deploy do
  desc 'Upload configuration files'
  task :preflight_check do
    on roles(:app) do
      # Set the path to the asdf Ruby bin directory
      asdf_bin_path = "/home/deploy/.asdf/installs/ruby/#{fetch(:ruby_version)}/bin"
      
      # Export the path
      info "Exporting PATH to include #{asdf_bin_path}"
      execute "export PATH=#{asdf_bin_path}:$PATH && source ~/.asdf/asdf.sh && echo $PATH"

      # Ensure Ruby version
      info "Ensuring Ruby version is #{fetch(:ruby_version)}"
      execute "source ~/.asdf/asdf.sh && asdf local ruby #{fetch(:ruby_version)}"
      
      # Export RAILS_SERVE_STATIC_FILES environment variable
      execute 'export RAILS_SERVE_STATIC_FILES=true'
    end
  end

  desc 'Run bundle install'
  task :bundle_install do
    on roles(:app) do
      within release_path do
        # Using the new binstubs command
        execute :bundle, 'binstubs --all'
        execute :bundle, 'install'
      end
    end
  end

  desc 'Compile assets'
  task :compile_assets do
    on roles(:app) do
      within release_path do
        with rails_env: fetch(:rails_env) do
          execute :rake, 'assets:precompile'
        end
      end
    end
  end

  desc 'Restart Nginx'
  task :restart_nginx do
    on roles(:web) do
      execute :sudo, :systemctl, 'restart nginx'
    end
  end

  desc 'Restart Puma'
  task :restart_puma do
    on roles(:app) do
      execute :sudo, :systemctl, 'restart puma'
    end
  end

  desc 'Upload configuration files'
  task :upload_configs do
    on roles(:app) do
      # Make a copy of the files before uploading
      execute :cp, "#{shared_path}/config/database.yml.enc", "#{shared_path}/config/database.yml.enc.bak"
      execute :cp, "#{shared_path}/config/master.key", "#{shared_path}/config/master.key.bak"
      execute :cp, "#{shared_path}/config/credentials/production.key", "#{shared_path}/config/credentials/production.key.bak"
      execute :cp, "#{shared_path}/config/credentials/production.yml.enc", "#{shared_path}/config/credentials/production.yml.enc.bak"

      # Upload the new files
      upload! 'config/database.yml.enc', "#{shared_path}/config/database.yml.enc"
      upload! 'config/master.key', "#{shared_path}/config/master.key"
      upload! 'config/credentials/production.key', "#{shared_path}/config/credentials/production.key"
      upload! 'config/credentials/production.yml.enc', "#{shared_path}/config/credentials/production.yml.enc"
    end
  end

  desc 'clear cache after deployment to pick up any new changes to the front end.'
  task :clear_cache do
    on roles(:app), in: :groups, limit: 3, wait: 10 do
      within release_path do
        execute :rails, 'runner', 'Rails.cache.clear'
      end
    end
  end

  before :starting, :preflight_check
  before :updated, :bundle_install
  # after :finishing, :upload_configs
  after :finishing, :compile_assets
  after :finishing, :clear_cache
  after :finishing, :restart_nginx
  after :finishing, :restart_puma
end