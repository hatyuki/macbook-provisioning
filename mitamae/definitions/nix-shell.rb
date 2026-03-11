define :nix_shell, packages: nil, command: "" do
  packages = if params[:packages].is_a?(Array)
               params[:packages].join(" ")
             else
               params[:packages]
             end
  packages = "--packages #{packages}" unless packages.empty?

  command = if params[:command].empty?
              params[:name]
            else
              params[:command]
            end

  execute "nix-shell #{packages} --run '#{command}'"
end
