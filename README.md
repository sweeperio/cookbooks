Overview
========

Every Chef installation needs a Chef Repository. This is the place where cookbooks, roles, config files and other artifacts for managing systems with Chef will live. We strongly recommend storing this repository in a version control system such as Git and treat it like source code.

While we prefer Git, and make this repository available via GitHub, you are welcome to download a tar or zip archive and use your favorite version control system to manage the code.

Repository Directories
======================

This repository contains several directories, and each directory contains a README file that describes what it is for in greater detail, and how to use it for managing your systems with Chef.

* `cookbooks/` - Cookbooks you download or create.
* `data_bags/` - Store data bags and items in .json in the repository (encrypt them!)
* `roles/` - Store roles in .json files in the repository.
* `environments/` - Store environments in .rb or .json in the repository.

Configuration
=============

* Copy .chef/knife.example.rb to .chef/knife.rb
* You'll need to update a few things in the file (see the comment at the top)

## General Knife Info
http://docs.chef.io/knife.html

Bootstrapping New Nodes
=======================

* Provision the new machine in EC2
* SSH to the new box and run https://www.opscode.com/chef/install.sh as root (check the script first!)
* `knife bootstrap <public_ip> -N <node-name> --sudo --secret-file .chef/encrypted_data_bag_secret`

Updating a Node
===============

* `knife node edit --editor vim`
* `knife ssh <public_ip> "sudo chef-client"`

Data Bags
==========

Normally chef works by communicating directly with the server for data bags. However, I'd prefer to store these in
json files within the repo.

I've added `knife data bag encrypt` and `knife data bag decrypt` as knife plugins in this repo. Both of these commands
use the `encrypted_data_bag_secret` setting defined in _.chef/knife.rb_ to handle encryption.

## Creating a New Data Bag

* Create a json file for the item (e.g. _data_bags/[BAG_NAME]/[ITEM].json_)
* Add any plain text entries needed
* Run `knife data bag encrypt [BAG_NAME] [ITEM] -w` (The `-w` means write to disk)
* `knife data bag from file data_bags/[BAG_NAME]/[ITEM].json`

## Editing a Data Bag

* Decrypt the file with `knife data bag decrypt [BAG_NAME] [ITEM] -w`
* Update the JSON file as needed
* Encrypt the file `knife data bag encrypt [BAG_NAME] [ITEM] -w`
* `knife data bag from file data_bags/[BAG_NAME]/[ITEM].json`

## Deleting a Data Bag

* `git rm data_bags/[BAG_NAME]/[ITEM].json`
* `knife data bag delete BAG_NAME ITEM`
