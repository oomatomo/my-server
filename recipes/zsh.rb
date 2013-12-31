#
# cookbook name:: my-server
# recipe:: zsh
#
# copyright (c) 2013 omagari tomohisa
#
# all rights reserved - do not redistribute
#

include_recipe "zsh"

execute "change login shell" do
  command "chsh -s /bin/zsh vagrant"
end


