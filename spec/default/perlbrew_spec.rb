require 'spec_helper'

describe package('perl') do
  it { should be_installed }
end

describe file('/home/vagrant/.perl5/bin/perlbrew') do
    it { should be_file }
end
