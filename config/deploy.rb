set :application, 'FaceCalendar'
set :repo_url, 'git@github.com:fenghuo/FaceCalendar.git'

ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }

set :deploy_to, '/home/ubuntu'
set :user, %{ubuntu}
set :use_sudo, false
set :latest_release_directory, File.join(fetch(:deploy_to), 'current')

# set :format, :pretty
set :log_level, :debug
set :rvm1_ruby_version, "2.0.0"
# set :pty, true

# set :linked_files, %w{config/database.yml}
# set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

# set :default_env, { path: "/opt/ruby/bin:$PATH" }
set :keep_releases, 5

set :normalize_asset_timestamps, %{public/images public/javascripts public/stylesheets}

#set :default_environment, {
#	'PATH' => "/home/ubuntu/.rvm/gems/ruby-2.0.0-p247/bin:/home/ubuntu/.rvm/gems/ruby-2.0.0-p247@global/bin:/home/ubuntu/.rvm/bin:$PATH",
#	'RUBY_VERSION' => 'ruby 2.0.0',
#	'GEM_HOME' => '/home/ubuntu/.rvm/gems/ruby-2.0.0-p247/gems',
#	'GEM_PATH' => '/home/ubunt/.rvm/gems/ruby-2.0.0-p247/gems:/home/ubuntu/.rvm/gems/ruby-2.0.0-p247@global',
#	'BUNDLE_PATH' => '/home/ubuntu/.rvm/gems/ruby-2.0.0-p247@global/bin'
#}
namespace :deploy do

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      # Your restart mechanism here, for example:
      execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end

  after :finishing, 'deploy:cleanup'



end
