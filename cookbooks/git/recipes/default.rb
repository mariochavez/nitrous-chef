#
# Cookbook Name:: git
# Recipe:: default
#
# Copyright 2013, Mario A. Chavez
#
# All rights reserved - Do Not Redistribute
#
home_dir = ENV['HOME']
git_config_file = "#{home_dir}/.gitconfig"

cookbook_file '.gitconfig' do
  user 'action'
  path git_config_file
  action :create_if_missing
end
