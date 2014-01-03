#
# cookbook name:: my-server
# recipe:: zsh
#
# copyright (c) 2013 omagari tomohisa
#
# all rights reserved - do not redistribute
#

package "zsh"

zsh_home = "#{node['home']}/.oh-my-zsh"

git zsh_home do
  repository "https://github.com/robbyrussell/oh-my-zsh.git"
  reference "master"
  user node['user']
  group node['group']
  action :checkout
  not_if {::File.exists?(zsh_home)}
end

bash "change shell" do
  code "chsh -s /bin/zsh vagrant"
end

bash "set up oh-my-zsh" do
  user node['user']
  code <<-EOH
  cp #{zsh_home}/templates/zshrc.zsh-template #{node['home']}/.zshrc
  source #{node['home']}/.zshrc
  EOH
end
