set :stage, :production

set :rvm_type, :user #Tell rvm to look in ~/.rvm
set :rvm_ruby_version, '2.0.0-p247'

# Simple Role Syntax
# ==================
# Supports bulk-adding hosts to roles, the primary
# server in each group is considered to be the first
# unless any hosts have the primary property set.

#set :server_name, %w{ec2-54-226-227-186.compute-1.amazonaws.com}
set :server_name, %w{ec2-50-16-79-127.compute-1.amazonaws.com}
set :server_name, %w{ec2-54-204-98-237.compute-1.amazonaws.com}

#set :server_name, %w{54.196.36.102}

role :web, fetch(:server_name) # Needed for precompiling assets
role :app, fetch(:server_name) # Needed for preparing something I forgot what
#role :db, fetch(:server_name) # Needed for migration
role :all, fetch(:server_name) # This doesn't work completely yet, hence the above 3 specifications

# Extended Server Syntax
# ======================
# This can be used to drop a more detailed server
# definition into the server list. The second argument
# something that quacks like a has can be used to set
# extended properties on the server.
# server 'example.com', user: 'deploy', roles: %w{web app}, my_property: :my_value

# you can set custom ssh options
# it's possible to pass any option but you need to keep in mind that net/ssh understand limited list of options
# you can see them in [net/ssh documentation](http://net-ssh.github.io/net-ssh/classes/Net/SSH.html#method-c-start)
# set it globally
set :ssh_options, {
    user: %{ubuntu},                # The user we want to log in as
    keys: %w{/home/ubuntu/face1.pem}, # Your .pem file
    forward_agent: true,          # In order for our EC2 instance to be able to access Github via ssh we need to forward our local ssh agent (since we have set up Github to accept that)
    auth_methods: %w(publickey)   # We are using ssh with .pem files
}
# and/or per server
# server 'example.com',
#   user: 'user_name',
#   roles: %w{web app},
#   ssh_options: {
#     user: 'user_name', # overrides user setting above
#     keys: %w(/home/user_name/.ssh/id_rsa),
#     forward_agent: false,
#     auth_methods: %w(publickey password)
#     # password: 'please use keys'
#   }
# setting per server overrides global ssh_options

set :rails_env, :production #This is for the rails module which does not find the env correctly
fetch(:default_env).merge!(rails_env: :production)  # Use RAILS_ENV=production
