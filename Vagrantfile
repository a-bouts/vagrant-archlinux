# -*- mode: ruby -*-
# vi: set ft=ruby :

DOCKER_COMPOSE_VERSION = "1.24.1"

Vagrant.configure("2") do |config|

  config.vm.box = "archlinux/archlinux"

  if Vagrant.has_plugin?("vagrant-disksize")
    config.disksize.size = '40GB'
  end

  config.vm.synced_folder "C:/source", "/home/vagrant/host-source"

  config.vm.provider "virtualbox" do |vb|
   vb.name = "archlinux"
   # Display the VirtualBox GUI when booting the machine
   vb.gui = true
   vb.customize ["modifyvm", :id, "--monitorcount", "2"]
   vb.customize ["modifyvm", :id, "--cpus", 4]

   # Customize the amount of memory on the VM:
   vb.memory = "8192"

   vb.customize ['modifyvm', :id, '--clipboard-mode', 'bidirectional']
   vb.customize ["modifyvm", :id, "--vram", "64"]

   unless File.exist?('./data.vdi')
     vb.customize ['createhd', '--filename', './data.vdi', '--variant', 'Fixed', '--size', 20 * 1024]
   end

   vb.customize ['storageattach', :id,  '--storagectl', 'IDE Controller', '--port', 1, '--device', 0, '--type', 'hdd', '--medium', './data.vdi']
  end

  # virtualbox-guest-utils
  config.vm.provision "shell", run: "never", inline: "pacman -Rs --noconfirm virtualbox-guest-utils-nox || true"
  config.vm.provision "shell", inline: "pacman -Syu --noconfirm --needed --noprogressbar virtualbox-guest-utils"

  # yay
  config.vm.provision "Yay Requirements", type: "shell", inline: <<-SHELL
    pacman -S --noconfirm --needed --noprogressbar base-devel git
  SHELL

  config.vm.provision "Yay", type: "shell", privileged: false, inline: <<-SHELL
    cd /tmp
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si --noconfirm
    cd ..
    rm -rf /tmp/yay
  SHELL

  # zsh
  config.vm.provision "Zsh-1", type: "shell", inline: <<-SHELL
    pacman -S --noconfirm --needed --noprogressbar zsh powerline powerline-fonts
  SHELL
  config.vm.provision "Zsh-2", type: "shell", privileged: false, inline: <<-SHELL
      yay -S --noconfirm --needed --noprogressbar antigen-git
  SHELL
  config.vm.provision "Zsh Conf", type: "file", source: ".zshrc", destination: "~/.zshrc"
  config.vm.provision "Zsh-3", type: "shell", privileged: false, inline: <<-SHELL
    chsh -s $(which zsh) vagrant || true
  SHELL


  # java
  config.vm.provision "Java 8", type: "shell", inline: "pacman -S --noconfirm --needed --noprogressbar jdk8-openjdk"

  # docker
  config.vm.provision "Docker", type: "shell", inline: <<-SHELL
    pacman -S --noconfirm --needed --noprogressbar docker
    systemctl enable docker
    curl -L --silent https://github.com/docker/compose/releases/download/#{DOCKER_COMPOSE_VERSION}/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
    chmod +x /usr/local/bin/docker-compose
    usermod -aG docker vagrant
  SHELL

  # kde
  config.vm.provision "Sddm Conf", type: "file", source: "sddm.conf", destination: "/tmp/sddm.conf"
  config.vm.provision "Sddm", type: "shell", inline: <<-SHELL
    mv /tmp/sddm.conf /etc/sddm.conf
    pacman -S --noconfirm --needed --noprogressbar xorg-server plasma-desktop sddm kwallet-pam ark dolphin kate konsole kwalletmanager okular gwenview spectacle
    systemctl enable sddm
    localectl --no-convert set-x11-keymap fr
  SHELL

  # atom
  config.vm.provision "Atom", type: "shell", inline: "pacman -S --noconfirm --needed --noprogressbar atom"

  # IntelliJ
  config.vm.provision "IntelliJ", type: "shell", inline: "pacman -S --noconfirm --needed --noprogressbar intellij-idea-community-edition"

  # Firefox
  config.vm.provision "Firefox", type: "shell", inline: "pacman -S --noconfirm --needed --noprogressbar firefox"

  # Kdiff3
  config.vm.provision "Firefox", type: "shell", inline: "pacman -S --noconfirm --needed --noprogressbar kdiff3"

  # gatling
  #config.vm.provision "shell", privileged: false, inline: "yay -S --noconfirm gatling-stress-tool"

  # Kubectl
  config.vm.provision "Kubectl", type: "shell", inline: <<-SHELL
    curl -LO --silent https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl
    chmod +x ./kubectl
    mv ./kubectl /usr/local/bin/kubectl
  SHELL
end
