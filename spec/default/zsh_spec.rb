require 'spec_helper'

describe command('cat /etc/shells') do
    it { should return_stdout /\/bin\/zsh/ }
end
describe command('echo $SHELL') do
    it { should return_stdout /\/bin\/zsh/ }
end
