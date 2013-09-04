#
# Cookbook Name:: dot_files
# Recipe:: default
#
# Copyright 2013, Mario A Chavez
#
# All rights reserved - Do Not Redistribute
#
home_dir = ENV['HOME']
dot_dir = "#{home_dir}/.dot_files"
vim_dir = "#{home_dir}/.vim"
vimrc_file = "#{home_dir}/.vimrc"
tmux_file = "#{home_dir}/.tmux.conf"

git dot_dir do
  user 'action'
  repository 'https://github.com/mariochavez/vim-dot-files.git'
  reference 'master'
  action :checkout
  enable_submodules true
end

bash "link #{vim_dir}" do
   user 'action'
   code <<-EOH
   ln -s #{dot_dir} #{vim_dir}
   EOH
   not_if "test -e #{vim_dir}"
end

bash "link #{vimrc_file}" do
   user 'action'
   code <<-EOH
   ln -s #{vim_dir}/vimrc #{vimrc_file}
   EOH
   not_if "test -e #{vimrc_file}"
end

# We need ruby 1.8.7 to run this step
bash 'build command-t' do
   code <<-EOH
   cd #{vim_dir}/bundle/command-t/ruby/command-t
   make clean
   ruby extconf.rb
   make
   EOH
end

bash "link #{tmux_file}" do
  user 'action'
  code <<-EOH
  ln -s #{dot_dir}/tmux.conf #{tmux_file}
  EOH
  not_if "test -e #{tmux_file}"
end
