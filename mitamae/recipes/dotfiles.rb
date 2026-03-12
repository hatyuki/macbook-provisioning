include_recipe "../definitions/op"
include_recipe "../definitions/stow"

dotfiles = "#{ROOT_DIR}/dotfiles"

# stow
[
  :config,
  :ideavim,
  :vim,
  :zsh,
].each do |pkg|
  stow pkg do
    dir dotfiles
    use_nix_shell true
  end
end

# Git
template "#{dotfiles}/config/.config/git/config" do
  source "#{dotfiles}/config/.config/git/config.erb"
  variables node: node[:name]
end

if node[:name] == "work"
  op "#{dotfiles}/config/.config/git/includes/user.work" do
    source "#{dotfiles}/config/.config/git/includes/user.work.tpl"
  end
end
