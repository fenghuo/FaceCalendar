set :stage, :production

set :rvm_type, :user #Tell rvm to look in ~/.rvm
set :rvm_ruby_version, '2.0.0-p247'

# Simple Role Syntax
# ==================
# Supports bulk-adding hosts to roles, the primary
# server in each group is considered to be the first
# unless any hosts have the primary property set.

#set :server_name, %w{ec2-54-226-227-186.compute-1.amazonaws.c
#s1= '72.44.55.153'
#s2= '54.205.123.82'

s1='ec2-50-16-79-127.compute-1.amazonaws.com'
s2='ec2-54-204-98-237.compute-1.amazonaws.com'
s3='ec2-54-224-89-87.compute-1.amazonaws.com'
s4='ec2-23-23-40-78.compute-1.amazonaws.com'
s5='ec2-54-234-15-229.compute-1.amazonaws.com'
s6='ec2-54-237-82-202.compute-1.amazonaws.com'
s7='ec2-107-21-133-69.compute-1.amazonaws.com'
s8='ec2-54-242-16-10.compute-1.amazonaws.com'
s9='ec2-54-211-73-159.compute-1.amazonaws.com'
s10='ec2-54-204-79-235.compute-1.amazonaws.com'
s11='ec2-54-211-195-188.compute-1.amazonaws.com'
s12='ec2-54-227-221-251.compute-1.amazonaws.com'
s13='ec2-54-205-123-82.compute-1.amazonaws.com'
s14='ec2-72-44-55-153.compute-1.amazonaws.com'


role :web,[ s1,s2,s3,s4,s5,s6,s7,s8,s9,s10,s11,s12,s13,s14] # Needed for precompiling assets
role :app,[ s1,s2,s3,s4,s5,s6,s7,s8,s9,s10,s11,s12,s13,s14] # Needed for preparing something I forgot what
#role :db, fetch(:server_name) # Needed for migration
role :all,[ s1,s2,s3,s4,s5,s6,s7,s8,s9,s10,s11,s12,s13,s14] # This doesn't work completely yet, hence the above 3 specifications

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
