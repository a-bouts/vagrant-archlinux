# -*- mode: ruby -*-
# vi: set ft=ruby :

DOCKER_COMPOSE_VERSION = "1.18.0"

Vagrant.configure("2") do |config|

  config.vm.box = "archlinux/archlinux"

  config.vm.synced_folder "C:/source", "/home/vagrant/source"

  config.vm.provider "virtualbox" do |vb|
   vb.name = "archlinux"
   # Display the VirtualBox GUI when booting the machine
   vb.gui = true
   # Customize the amount of memory on the VM:
   vb.memory = "4096"

   vb.customize ['modifyvm', :id, '--clipboard', 'bidirectional']
   vb.customize ["modifyvm", :id, "--vram", "64"]
  end

  # virtualbox-guest-utils
  config.vm.provision "shell", inline: "pacman -Rs --noconfirm virtualbox-guest-utils-nox"
  config.vm.provision "shell", inline: "pacman -Syu --noconfirm virtualbox-guest-utils"

  # zsh
  config.vm.provision "shell", inline: "pacman -S --noconfirm zsh"

  # yaourt
  config.vm.provision "shell", inline: <<-SHELL
    pacman -S --noconfirm base-devel

    echo "[archlinuxfr]" >> /etc/pacman.conf
    echo "SigLevel = Never" >> /etc/pacman.conf
    echo "Server = http://repo.archlinux.fr/x86_64" >> /etc/pacman.conf

    pacman -Sy
    pacman -S --noconfirm yaourt

  SHELL

  # java
  config.vm.provision "shell", inline: "pacman -S --noconfirm jdk8-openjdk"

  # git
  config.vm.provision "shell", inline: "pacman -S --noconfirm git"

  # docker
  config.vm.provision "shell", inline: <<-SHELL
    pacman -S --noconfirm docker
    systemctl enable docker
    curl -L https://github.com/docker/compose/releases/download/#{DOCKER_COMPOSE_VERSION}/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
    chmod +x /usr/local/bin/docker-compose
    usermod -aG docker vagrant
  SHELL

  # kde
  config.vm.provision "file", source: "sddm.conf", destination: "/tmp/sddm.conf"
  config.vm.provision "shell", inline: "mv /tmp/sddm.conf /etc/sddm.conf"
  config.vm.provision "shell", inline: <<-SHELL
    pacman -S --noconfirm xorg-server plasma-desktop sddm kwallet-pam ark dolphin kate konsole kwalletmanager okular gwenview
    systemctl enable sddm
    localectl --no-convert set-x11-keymap fr
  SHELL

  # atom
  config.vm.provision "shell", inline: "pacman -S --noconfirm atom"

  # IntelliJ
  config.vm.provision "shell", inline: "pacman -S --noconfirm intellij-idea-community-edition"

  # Firefox
  config.vm.provision "shell", inline: "pacman -S --noconfirm firefox"

  # gatling
  config.vm.provision "shell", privileged: false, inline: "yaourt -S --noconfirm gatling-stress-tool"

end
