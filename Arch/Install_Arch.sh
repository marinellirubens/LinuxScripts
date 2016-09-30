#Mudar teclado para abnt2
loadkeys br-abnt2
#Mudar a fonte
setfont lat4-19

#Voltar para fonte original:
setfont

#executar esses comandos:
locale-gen


#formatar a particao swap e ligar
swapon $(fdisk -l | grep swap | cut -c 1-9)

#ver o layout do particionamento
lsblk /dev/sda

echo ''
echo 'informe a partição que sera usada como raiz'

mkdir /mnt

read PARTICAO_RAIZ
#montar as particoes
mount /dev/sda5 /mnt

#criar a pasta home e montar a particao home
#mkdir /mnt/home
#mount /dev/sda4 /mnt/home



echo ''
echo 'continuar e instalar o sistema?'
read RETORNO
if [ "$RETORNO" = "N" ]; then
	exit
fi
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
#nano /etc/locale.gen

#descomentar essas linhas:
#en_US.UTF-8 UTF-8
#pt_BR.UTF-8 UTF-8

#executar esse comando:
locale-gen

#criar o aquirvo de conf de lingua
#ATENÇÂO! mesmo problema das setas anteriores
echo LANG=en_US.UTF-8 ＞ /etc/locale.conf
export LANG=pt_BR.UTF-8

#setando configuracoes de teclado para que persistam pos reboot
#nano /etc/vconsole.conf

#adiciona essas linhas no arquivo e salva
echo KEYMAP=br-abnt2 > /etc/vconsole.conf
echo FONT=Lat2-Terminus16 >> /etc/vconsole.conf
echo FONT_MAP= >> /etc/vconsole.conf

#setando fuso horario
#ls /usr/share/zoneinfo/America
ln -s /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime

#sincronizando o relogio de hardware com o do sistema
hwclock --systohc --utc

#setando a rede cabeada
systemctl enable dhcpcd@eth0.service

#setando rede wireless
pacman -S wireless_tools wpa_supplicant wpa_actiond netcf dialog --noconfirm

systemctl enable net-auto-wireless.service

#configurar os repositorios pacman para 32 e 64
#descomentar multilib
nano /etc/pacman.conf

#sincronizar os repositorios
pacman -Sy

#criar senha de root
echo 'root:linux' | chpasswd

#criar usuario e definir senha
useradd -m -g users -G wheel,storage,power -s /bin/bash rubens
echo 'rubens:linux' | chpasswd

#instalar sudo
pacman -S sudo

#editar os propriedades de sudo
#descomentar a linha que mostra wheel
#EDITOR=nano visudo
usermod -a -G root finnorx

#COMECAR A CONFIGURAR O ARCHLINUX
#mudar o nome do host
hostnamectl set-hostname archferi

#setar o som
pacman -S alsa-utils --noconfirm 
#alsamixer

#instalar xorg e um monte de ferramentas
pacman -S xorg-server xorg-xinit xorg-server-utils mesa ttf-dejavu samba smbclient networkmanager networkmanager-vpnc networkmanager-pptp networkmanager-openconnect network-manager-applet gvfs gvfs-smb sshfs --noconfirm 

#esse foi o que usei, substitua pelo seu respectivo:
pacman -S xf86-video-intel --noconfirm 
#instalar os opcionais - se quiser, claro

#ativar o gerenciador de rede automaticamente
systemctl enable NetworkManager

