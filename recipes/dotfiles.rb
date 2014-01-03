#
# Cookbook Name:: my-server
# Recipe:: dotfiles
#
# Copyright (C) 2013 Omagari Tomohisa
#
# All rights reserved - Do Not Redistribute
#

dotfiles_home = "#{node['home']}/dotfiles"

git dotfiles_home do
  repository "https://github.com/oomatomo/dotfiles.git"
  reference "master"
  user node['user']
  group node['group']
  action :sync
  not_if {::File.exists?(dotfiles_home)}
end

execute "set up dotfiles" do
  user node['user']
  group node['group']
  command <<-EOH
    ln -sf #{dotfiles_home}/.vimrc #{node['home']}/.vimrc
    ln -sf #{dotfiles_home}/.tmux.conf #{node['home']}/.tmux.conf
  EOH
end

execute "set up oh-my-zsh" do
  user node['user']
  group node['group']
  command <<-EOH
    ln -sf #{dotfiles_home}/oh-my-zsh/custom.zsh #{node['home']}/.oh-my-zsh/custom/custom.zsh
    ln -sf #{dotfiles_home}/oh-my-zsh/ooma.zsh-theme #{node['home']}/.oh-my-zsh/themes/ooma.zsh-theme
  EOH
  only_if {::File.exists?("#{node['home']}/.oh-my-zsh")}
end
