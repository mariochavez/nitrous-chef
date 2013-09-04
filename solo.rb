home_dir    = ENV['HOME']

file_cache_path "#{home_dir}/chef-repo"
cookbook_path [ "#{home_dir}/chef-repo/cookbooks" ]
