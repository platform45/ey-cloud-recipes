#
# Cookbook Name:: amadeus_poller
# Recipe:: default
#

ey_cloud_report "AmadeusPoller" do
  message "configuring amadeus poller"
end

if node[:instance_role] == "solo"
  template "/etc/monit.d/amadeus_poller.monitrc" do
    source "amadeus.monitrc.erb"
    owner "root"
    group "root"
    mode 0644
    variables({
      :app_name => app_name,
      :user => node[:owner_name]
    })
  end
  
  execute "monit-reload-restart" do
     command "sleep 30 && monit quit"
     action :run
  end
end