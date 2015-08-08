# Things you'll need before using this:
# * your client key and the validator pem
# * the encrypted data bag secret file
# * our chef server url
# * AWS access id, secret key and region

current_dir = File.dirname(__FILE__)

log_level                 :info
log_location              STDOUT

cookbook_copyright        "Sweeper"
cookbook_email            "developers@sweeper.io"
cookbook_license          "mit"
cookbook_path             "#{current_dir}/../cookbooks"
data_bag_encrypt_version  2

node_name                 "YOUR_NODE_NAME"
client_key                "#{current_dir}/YOUR_CLIENT_KEY.pem"
validation_client_name    "sweeper-validator"
validation_key            "#{current_dir}/validator.pem"
chef_server_url           "CHEF_SERVER_URL"
syntax_check_cache_path   "#{current_dir}/syntax_check_cache"
encrypted_data_bag_secret "#{current_dir}/encrypted_data_bag_secret"

knife[:ssh_user]              = "ubuntu"
knife[:aws_access_key_id]     = "YOUR_AWS_KEY"
knife[:aws_secret_access_key] = "YOUR_AWS_SECRET"
knife[:region]                = "YOUR_AWS_REGION"
