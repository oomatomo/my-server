require 'spec_helper'

describe file('/home/vagrant/.perl5/bin/perlbrew') do
    it { should be_file }
end
