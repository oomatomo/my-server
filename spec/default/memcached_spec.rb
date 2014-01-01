require 'spec_helper'

describe user('memcached') do
    it { should exist }
end

describe service('memcached') do
    it { should be_running }
end

describe port(11211) do
    it { should be_listening.with('tcp') }
end

describe process("memcached") do
    it { should be_running }
end

describe file('/etc/sysconfig/memcached') do
    it { should be_file }
end


