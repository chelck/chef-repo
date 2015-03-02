#
# Cookbook Name:: brokernet
# Recipe:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

package "tree"

search("users", "*:*").each do |user_data|
  user user_data["id"] do
    supports :manage_home => true
    comment user_data["comment"]
    uid user_data["uid"]
    gid user_data["gid"]
    home user_data["home"]
    shell user_data["shell"]
    password user_data["password"]
  end
end



search(:users, "*:*").each do |user|
  login = user["id"]

  template "/home/#{login}/.myenv.cfg" do
    source "myenv.erb"
    owner user["uid"]
    group user["gid"]
    variables(
       :myenv_steamed => user["comment"],
       :user_md => user["md"],
       :user_region => user["region"],
       :user_side => user["side"],
       :user_logicalIp => user["logicalIp"]
    )
  end
end

#include_recipe "users::groups"

search("groups", "*:*").each do |group_data|
 group group_data["id"] do
   gid group_data["gid"]
   members group_data["members"]
 end
end


directory "/home/broker/runtime" do
  group "icap"
end

#include_recioe "yum_repository"

yum_repository 'chris' do
  description "Chris' first unstable repo"
  baseurl "http://192.168.1.8/chris/yum/"
  gpgcheck false
  action :create
end

package "Example-RPM-Project"

#include_recipe "ojava"

include_recipe "tar"

version = '1.3.0'

tar_extract "http://192.168.1.8/chris/brokernet/littlebroker-#{version}.tgz" do
  target_dir "/home/broker"
  creates "/home/broker/littlebroker-#{version}/lib"
#  tar_flags [ '-P', '--strip-components 1' ]
end

#include_recipe "magic_shell"

magic_shell_environment 'PATH' do value "$PATH:/home/broker/littlebroker-#{version}/bin" end 

