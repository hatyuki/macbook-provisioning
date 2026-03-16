dotfiles = File.expand_path("../../../dotfiles", __FILE__)

define :dotfile, source: nil, destination: nil do
  dir = File.dirname(destination = File.join(ENV["HOME"], params[:destination] || params[:name]))

  directory dir do
    user node[:user]
  end

  link destination do
    force true
    to File.join(dotfiles, params[:source])
    user node[:user]
  end
end
