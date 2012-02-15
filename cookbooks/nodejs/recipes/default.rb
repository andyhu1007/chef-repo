#
# Cookbook Name:: nodejs
# Recipe:: default
#
# Copyright 2012, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe "build-essential"

case node[:platform]
  when "centos","redhat","fedora"
    package "openssl-devel"
  when "debian","ubuntu"
    package "libssl-dev"
end

nodejs_tar = "node-v#{node[:nodejs][:version]}.tar.gz"
nodejs_tar_path = nodejs_tar

if node[:nodejs][:version].split('.')[1].to_i >= 5
  nodejs_tar_path = "v#{node[:nodejs][:version]}/#{nodejs_tar_path}"
end

remote_file "/usr/local/src/#{nodejs_tar}" do
  source "http://nodejs.org/dist/#{nodejs_tar_path}"
  checksum node[:nodejs][:checksum]
  mode 0644
end

# --no-same-owner required overcome "Cannot change ownership" bug
# on NFS-mounted filesystem
execute "tar --no-same-owner -zxf #{nodejs_tar}" do
  cwd "/usr/local/src"
  creates "/usr/local/src/node-v#{node[:nodejs][:version]}"
end

bash "compile node.js" do
  cwd "/usr/local/src/node-v#{node[:nodejs][:version]}"
  code <<-EOH
    ./configure --prefix=#{node[:nodejs][:dir]} && \
    make
  EOH
  creates "/usr/local/src/node-v#{node[:nodejs][:version]}/node"
end

execute "make install" do
  cwd "/usr/local/src/node-v#{node[:nodejs][:version]}"
  not_if { `#{node[:nodejs][:dir]}/bin/node --version`.chomp == "v#{node[:nodejs][:version]}" }
end
