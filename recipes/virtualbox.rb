if platform?("mac_os_x")
    include_recipe "applications::homebrewcask"
    applications_cask "virtualbox"
elsif platform_family?("debian")
    apt_repository "virtualbox" do
        uri "http://download.virtualbox.org/virtualbox/debian"
        distribution node["lsb"]["codename"]
        components ["contrib"]
        keyserver "keys.gnupg.net"
        key "54422A4B98AB5139"
        action :add
        notifies :run, "execute[apt-get update]", :immediately
    end

    %w[ virtualbox-4.2 ].each do |pkg|
        package pkg do
            action [:install, :upgrade]
        end
    end
end
