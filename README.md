# Overview

[![Build Status](https://travis-ci.org/sweeperio/cookbooks.svg?branch=master)](https://travis-ci.org/sweeperio/cookbooks)

This is the main chef repo for the sweeper.io organization. Data bags, roles, environments and tests are stored here.
_**Cookbooks should not be added to this repo.**_

## Setup

### Install the ChefDK

Head over to the [ChefDK] site and download/install the current version for your platform.

### Configure Knife, Etc.

In order to work with our chef server, you'll need some common files (validator.pem, chef plugins, etc.). Instead of
storing these per repo, or in the global `~/.chef` directory, we've elected to use our own folder. This will allow you
to continue to use `~/.chef` for your supermarket account or your own chef repo.

To get started, you'll need to:

* Have someone create a client for your node (for `node_name` and `client_key` settings in _knife.rb_)
* Untar our `chef-sweeper` tarball to `~/.chef-sweeper`
* Add your client pem file to `~/.chef-sweeper` and update the `node_name` and `client_key` attributes appropriately
* Symlink `./.chef` (via `ln -s ~/.chef-sweeper .chef`)

[ChefDK]: https://downloads.chef.io/chef-dk/


## Bootstrapping New Nodes

* Provision the new machine in EC2
* SSH to the new box and run https://www.opscode.com/chef/install.sh as root (check the script first!)
* `knife bootstrap <public_ip> -N <node-name> --sudo --secret-file .chef/encrypted_data_bag_secret`

### Updating a Node

* `knife node edit --editor vim`
* `knife ssh <public_ip> "sudo chef-client"`

## Data Bags

Normally chef works by communicating directly with the server for data bags. However, I'd prefer to store these in
json files within the repo. This gives us the ability to use git for version history.

I've added `knife data bag encrypt` and `knife data bag decrypt` as knife plugins in this repo. Both of these commands
use the `encrypted_data_bag_secret` setting defined in _.chef/knife.rb_ to handle encryption.

### Creating a New Data Bag

* Create a json file for the item (e.g. _data_bags/[BAG_NAME]/[ITEM].json_)
* Add any plain text entries needed
* Run `knife data bag encrypt [BAG_NAME] [ITEM] -w` (The `-w` means write to disk)
* `knife data bag from file data_bags/[BAG_NAME]/[ITEM].json`

### Editing a Data Bag

* Decrypt the file with `knife data bag decrypt [BAG_NAME] [ITEM] -w`
* Update the JSON file as needed
* Encrypt the file `knife data bag encrypt [BAG_NAME] [ITEM] -w`
* `knife data bag from file data_bags/[BAG_NAME]/[ITEM].json`

### Deleting a Data Bag

* `git rm data_bags/[BAG_NAME]/[ITEM].json`
* `knife data bag delete BAG_NAME ITEM`
