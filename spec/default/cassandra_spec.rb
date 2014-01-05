require 'spec_helper'

describe file('/usr/local/cassandra/bin/cassandra') do
    it { should be_file }
end
