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

include_recipe "ojava"
