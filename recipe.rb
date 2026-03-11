# SEE ALSO: https://nix.dev/install-nix
execute :install_nix do
  # TODO: Linux では Option が必要
  command "curl -L https://nixos.org/nix/install | sh"
  not_if "command -v nix"
end

execute "nix run nix-darwin" do
  command "sudo nix run nix-darwin --extra-experimental-features 'nix-command flakes' -- switch --flake #{node[:flake]}"
end

include_recipe "mitamae/recipes/dotfiles"
