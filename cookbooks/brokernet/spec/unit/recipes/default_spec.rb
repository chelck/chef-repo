#
# Cookbook Name:: brokernet
# Spec:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

require 'spec_helper'

describe 'brokernet::default' do

  context 'When all attributes are default, on an unspecified platform' do

    let(:chef_run) do
      runner = ChefSpec::ServerRunner.new do |node, server|
        server.create_data_bag('users', {
          'broker' => {
            'uid' => 12
          }
        })
        server.create_data_bag('groups', {
          'icap' => {
            'gid' => 13
          }
        })
      end
      runner.converge(described_recipe)
    end

    it 'converges successfully' do
      chef_run # This should not raise an error
    end

    it 'creates group icap' do
      expect(chef_run).to create_group('icap') 
    end

    it 'creates user Broker' do
      expect(chef_run).to create_user('broker') 
    end

    #it 'creates directories for BrokerNet' do
    #  expect(chef_run).to create_directory('/home/broker/runtime')
    #end
  end
end
