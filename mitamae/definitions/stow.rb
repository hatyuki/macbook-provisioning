include_recipe "nix-shell"

define :stow, dir: nil, target: ENV["HOME"], use_nix_shell: false do
  cmd = "stow --dir=#{params[:dir]} --target=#{params[:target]} #{params[:name]}"

  if params[:use_nix_shell]
    nix_shell cmd do
      packages :stow
    end
  else
    execute cmd
  end
end
