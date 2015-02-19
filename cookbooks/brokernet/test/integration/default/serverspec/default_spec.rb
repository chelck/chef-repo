require 'spec_helper'

describe 'brokernet::default' do

  # Serverspec examples can be found at
  # http://serverspec.org/resource_types.html
  
  #it 'does something' do
  #  skip 'Replace this with meaningful tests'
  #end

  describe package('tree') do
    it { should be_installed }
  end 

end

