require 'spec_helper'

describe package('MySQL-server') do
  it { should be_installed }
end

describe package('MySQL-client') do
  it { should be_installed }
end

describe package('MySQL-devel') do
  it { should be_installed }
end

describe service('mysql') do
    it { should be_running }
end
