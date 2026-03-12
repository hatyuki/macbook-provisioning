define :op, source: nil, path: "" do
  path = if params[:path].empty?
           params[:name]
         else
           params[:path]
         end

  execute "op inject --force --in-file #{params[:source]} --out-file #{path}" do
    not_if "test -f #{path}"
  end
end
