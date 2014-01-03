require 'spec_helper'

describe file('/home/vagrant/.oh-my-zsh/custom/custom.zsh') do
    it { should be_file }
end

describe file('/home/vagrant/.oh-my-zsh/themes/ooma.zsh-theme') do
    it { should be_file }
end
