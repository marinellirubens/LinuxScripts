#Mudar teclado para abnt2
loadkeys br-abnt2
#Mudar a fonte
setfont lat4-19

#ativar wifi 
wifi-menu

#Voltar para fonte original:
setfont

#muda a lingua da instalação para portugues br
nano /etc/locale.gen

#descomentar essas linhas:
en_US.UTF-8 UTF-8
pt_BR.UTF-8 UTF-8

#executar esses comandos:
locale-gen
export LANG=pt_BR.UTF-8

#testa coneccao com a internet
ping -c 3 www.google.com

#mostra as particoes
fdisk -l

#comecar o particionamento
cfdisk /dev/sda
#se for GPT criar uma particao de boot BIOS de 2Mb

#formatar as particoes
mkfs.ext4 /dev/sda2
mkfs.ext4 /dev/sda4

#formatar a particao swap e ligar
mkswap /dev/sda3
swapon /dev/sda3

#ver o layout do particionamento
lsblk /dev/sda

#montar as particoes
mount /dev/sda2 /mnt

#criar a pasta home e montar a particao home
mkdir /mnt/home
mount /dev/sda4 /mnt/home

#instalar o sistema base
pacstrap /mnt base base-devel

#gerar o arquivo fstab que decreve as particoes
# ATENÇÃO! essa setas direcionais não devem ser copiadas, o you tube não deixa colocar as orgirnais. digite eles diretamente mesmo e entre elas não tem espaço!
genfstab -U -p /mnt ＞＞ /mnt/etc/fstab

#ver o que esta escrito nesse arquivo
cat /mnt/etc/fstab

#logando na instalacao para setar algumas outras coisas
arch-chroot /mnt

#muda a lingua novamente
nano /etc/locale.gen

#descomentar essas linhas:
en_US.UTF-8 UTF-8
pt_BR.UTF-8 UTF-8

#executar esse comando:
locale-gen

#criar o aquirvo de conf de lingua
#ATENÇÂO! mesmo problema das setas anteriores
echo LANG=pt_BR.UTF-8 ＞ /etc/locale.conf
export LANG=pt_BR.UTF-8

#setando configuracoes de teclado para que persistam pos reboot
nano /etc/vconsole.conf

#adiciona essas linhas no arquivo e salva
KEYMAP=br-abnt2
FONT=Lat2-Terminus16
FONT_MAP=

#setando fuso horario
ls /usr/share/zoneinfo/America
ln -s /usr/share/zoneinfo/America/Recife /etc/localtime

#sincronizando o relogio de hardware com o do sistema
hwclock --systohc --utc

#setando a rede cabeada
systemctl enable dhcpcd@eth0.service

#setando rede wireless
pacman -S wireless_tools wpa_supplicant wpa_actiond netcf dialog

systemctl enable net-auto-wireless.service

#configurar os repositorios pacman para 32 e 64
#descomentar multilib
nano /etc/pacman.conf

#sincronizar os repositorios
pacman -Sy

#criar senha de root
passwd

#criar usuario e definir senha
useradd -m -g users -G wheel,storage,power -s /bin/bash finnorx
passwd finnorx

#instalar sudo
pacman -S sudo

#editar os propriedades de sudo
#descomentar a linha que mostra wheel
EDITOR=nano visudo

#baixar e instalar grub
pacman -S grub-bios
grub-install --target=i386-pc --recheck /dev/sda
cp /usr/share/locale/en\@quot/LC_MESSAGES/grub.mo /boot/grub/locale/en.mo

#criar o arquivo de configuracao do grub
grub-mkconfig -o /boot/grub/grub.cfg

#sair do arch-chroot
exit

#desmontar as particoes
umount /mnt/home
umount /mnt

#reiniciar
reboot

#COMECAR A CONFIGURAR O ARCHLINUX

#mudar o nome do host
sudo hostnamectl set-hostname archfx

#conectar o computador a internet
dhcpcd
ping -c 3 www.google.com

#setar o som
pacman -S alsa-utils
alsamixer

#instalar xorg e um monte de ferramentas
sudo pacman -S xorg-server xorg-xinit xorg-server-utils mesa ttf-dejavu samba smbclient networkmanager networkmanager-vpnc networkmanager-pptp networkmanager-openconnect network-manager-applet gvfs gvfs-smb sshfs
#escolher as

#instalar driver de video
#Instalar o que for o seu:
virtualbox-guest-utils - para o virtualbox
nvidia - para placas nvidia
xf86-video-ati - para placas amd-radeon
xf86-video-intel - para drivers da intel

#esse foi o que usei, substitua pelo seu respectivo:
sudo pacman -S virtualbox-guest-utils
#instalar os opcionais - se quiser, claro

#ativar o gerenciador de rede automaticamente
sudo systemctl enable NetworkManager
