#
# Cookbook Name:: zsh
# Recipe:: default
#
# Copyright 2013, Mario A. Chavez
#
# All rights reserved - Do Not Redistribute
#
home_dir = ENV['HOME']
zsh_dir = "#{home_dir}/.zsh"
plugins_dir = "#{zsh_dir}/oh-my-zsh/plugins"
zsh_file = "#{home_dir}/.zshrc"

directory zsh_dir do
  action :create
  not_if "test -e #{zsh_dir}"
end

git "#{zsh_dir}/oh-my-zsh" do
  repository 'https://github.com/robbyrussell/oh-my-zsh.git'
  reference 'master'
  action :sync
end

git "#{zsh_dir}/zsh-syntax-highlighting" do
  repository 'https://github.com/zsh-users/zsh-syntax-highlighting.git'
  reference 'master'
  action :sync
end

%w(bundler gem git history-substring-search rails4 tmux).each do |plugin|
  bash "link #{plugin}" do
    code <<-EOH
    ln -s #{plugins_dir}/#{plugin} #{zsh_dir}/#{plugin}
    EOH
    not_if "test -e #{zsh_dir}/#{plugin}"
  end

  unless %w(history-substring-search gem).include?(plugin)
    file "#{zsh_dir}/#{plugin}.zsh" do
      content "source #{zsh_dir}/#{plugin}/#{plugin}.plugin.zsh"
      mode "0755"
      action :create_if_missing
    end
  end
end

file "#{zsh_dir}/history-substring-search.zsh" do
  content "source #{zsh_dir}/history-substring-search/history-substring-search.zsh"
  mode "0755"
  action :create_if_missing
end

cookbook_file 'theme.zsh' do
  user 'action'
  path "#{zsh_dir}/theme.zsh"
  action :create_if_missing
end

cookbook_file '.zshrc' do
  user 'action'
  path zsh_file
  action :create_if_missing
end
