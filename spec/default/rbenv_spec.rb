require 'spec_helper'

describe package('ruby') do
  it { should be_installed }
end

describe file('/home/vagrant/.rbenv') do
    it { should be_directory}
end
