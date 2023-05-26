Vagrant.configure("2") do |config|

  if Vagrant.has_plugin? "vagrant-vbguest"
    config.vbguest.no_install  = true
    config.vbguest.auto_update = false
    config.vbguest.no_remote   = true
  end
config.vm.define :firewall do |firewall|
    firewall.vm.box = "generic/centos8"
    firewall.vm.network :private_network, ip: "192.168.70.1"
    firewall.vm.network :public_network, ip: "192.168.67.48"
    firewall.vm.provision "shell", path: "script.sh"
    firewall.vm.hostname = "firewall"
  end
config.vm.define :streama do |streama|
    streama.vm.box = "generic/centos8"
    streama.vm.network :private_network, ip: "192.168.70.2"
    streama.vm.network :public_network, ip: "192.168.67.49"
    streama.vm.provision "shell", path: "scriptst.sh"
    streama.vm.hostname = "streama"
  end

end