#
# Cookbook Name:: ctags
# Recipe:: default
#
# Copyright 2013, Mario A. Chavez
#
# All rights reserved - Do Not Redistribute
#
home_dir = ENV['HOME']

ctags_version = '5.8'
ctags_file = "#{home_dir}/ctags-#{ctags_version}.tar.gz"
ctags_dir = "#{home_dir}/ctags-#{ctags_version}"

remote_file "#{ctags_file}" do
  source "http://prdownloads.sourceforge.net/ctags/ctags-#{ctags_version}.tar.gz"
end

bash 'install ctags' do
  code <<-EOH
  cd #{home_dir}
  tar zxf #{ctags_file}
  rm #{ctags_file}
  cd #{ctags_dir}
  ./configure --prefix=$HOME
  make && make install
  EOH
end
