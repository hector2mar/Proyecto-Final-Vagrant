Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/focal64"

  # Configuración común para todas las máquinas
  config.vm.provision "shell", path: "scripts/common.sh"

  # Load Balancer (Nginx)
  config.vm.define "lb" do |lb|
    lb.vm.hostname = "lb"
    lb.vm.network "private_network", ip: "192.168.56.10"
    lb.vm.network "forwarded_port", guest: 80, host: 8080
    lb.vm.provider "virtualbox" do |vb|
      vb.memory = "512" # 
    end
    lb.vm.provision "shell", path: "scripts/lb.sh"
  end

  # Servidores Web (Apache + PHP)
  (1..3).each do |i|
    config.vm.define "web#{i}" do |web|
      web.vm.hostname = "web#{i}"
      web.vm.network "private_network", ip: "192.168.56.1#{i}"
      web.vm.provider "virtualbox" do |vb|
        vb.memory = "1024" # 
      end
      web.vm.provision "shell", path: "scripts/web.sh"
    end
  end

  # Base de Datos (MySQL)
  config.vm.define "db" do |db|
    db.vm.hostname = "db"
    db.vm.network "private_network", ip: "192.168.56.20"
    db.vm.provider "virtualbox" do |vb|
      vb.memory = "2048" # [cite: 20]
    end
    db.vm.provision "shell", path: "scripts/db.sh"
  end
end