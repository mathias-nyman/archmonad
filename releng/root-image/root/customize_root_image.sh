#!/bin/bash

set -e -u
USER=arch

sed -i 's/#\(en_US\.UTF-8\)/\1/' /etc/locale.gen
locale-gen

ln -sf /usr/share/zoneinfo/UTC /etc/localtime

usermod -s /usr/bin/zsh root
cp -aT /etc/skel/ /root/

useradd -m -p "" -g users -G "adm,audio,floppy,log,network,rfkill,scanner,storage,optical,power,wheel" -s /usr/bin/zsh $USER

chmod 750 /etc/sudoers.d
chmod 440 /etc/sudoers.d/g_wheel

sed -i "s/#Server/Server/g" /etc/pacman.d/mirrorlist
sed -i 's/#\(Storage=\)auto/\1volatile/' /etc/systemd/journald.conf

systemctl enable pacman-init.service choose-mirror.service

# Replace dhcpcd with NetworkManager
systemctl disable dhcpcd.service
systemctl enable NetworkManager.service

# Copy files over to home
for user in root $USER
do
    su -c "git clone --recursive https://github.com/mathias-nyman/dotfiles.git ~$user/dotfiles" $user
    su -c "cd ~$user/dotfiles && ./install.sh force" $user
done

# Enable ssh server
sed -i 's/#PermitRootLogin yes/PermitRootLogin no/' /etc/ssh/sshd_config
systemctl enable sshd.service

# Fetch OpenVAS plugins
openvas-nvt-sync

