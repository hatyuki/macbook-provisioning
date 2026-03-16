include_recipe "../definitions/dotfile"
include_recipe "../definitions/op"

%w[
  config/ghostty
  config/git
  config/gwq
  config/sheldon
  config/zellij
  ideavimrc
  vim
  vimrc
  zsh
  zshenv
  zshrc
].each do |pkg|
  dotfile ".#{pkg}" do
    source pkg
  end
end

dotfiles = File.expand_path("../../../dotfiles", __FILE__)

# Git
template "#{dotfiles}/config/git/config" do
  source "#{dotfiles}/config/git/config.erb"
  variables node: node[:name]
end

if node[:name] == "work"
  op "#{dotfiles}/config/git/includes/user.work" do
    source "#{dotfiles}/config/git/includes/user.work.tpl"
  end
end
