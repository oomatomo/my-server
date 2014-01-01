#
# cookbook name:: my-server
# recipe:: zsh
#
# copyright (c) 2013 omagari tomohisa
#
# all rights reserved - do not redistribute
#

include_recipe "zsh"

home = "/home/#{node['user']}"

git "#{home}/.oh-my-zsh" do
  repository "https://github.com/robbyrussell/oh-my-zsh.git"
  reference "master"
  user node['user']
  group node['group']
  action :checkout
  not_if {::File.exists?("#{home}/.oh-my-zsh")}
end

bash "change shell" do
  code "chsh -s /bin/zsh vagrant"
end

bash "set up oh-my-zsh" do
  user node['user']
  code <<-EOH
  cp #{home}/.oh-my-zsh/templates/zshrc.zsh-template #{home}/.zshrc
  source #{home}/.zshrc
  EOH
end




