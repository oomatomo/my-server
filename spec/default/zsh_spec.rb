require 'spec_helper'

describe package('zsh') do
  it { should be_installed }
end

describe command('cat /etc/shells') do
    it { should return_stdout /\/bin\/zsh/ }
end

describe command('echo $SHELL') do
    it { should return_stdout /\/bin\/zsh/ }
end

describe file('/home/vagrant/.zshrc') do
    it { should be_file }
end

describe file('/home/vagrant/.oh-my-zsh') do
    it { should be_directory }
end
