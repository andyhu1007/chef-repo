include_recipe "nodejs"

package "curl"

bash "install npm - package manager for node" do
  cwd "/usr/local/src"
  user "root"
  code <<-EOH
    mkdir -p npm-v#{node[:nodejs][:npm]} && \
    cd npm-v#{node[:nodejs][:npm]}
    curl -L http://registry.npmjs.org/npm/-/npm-#{node[:nodejs][:npm]}.tgz | tar xzf - --strip-components=1 && \
    make uninstall dev
  EOH
  not_if "#{node[:nodejs][:dir]}/bin/npm -v 2>&1 | grep '#{node[:nodejs][:npm]}'"
end

