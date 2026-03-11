include_recipe "../definitions/stow"

[
  :config,
  :ideavim,
  :vim,
  :zsh,
].each do |pkg|
  stow pkg do
    dir File.expand_path("../../../dotfiles", __FILE__)
    use_nix_shell true
  end
end
