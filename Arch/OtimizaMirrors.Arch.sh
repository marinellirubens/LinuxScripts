cd /etc/pacman.d/
cat /etc/pacman.d/mirrorlist
cp mirrorlist mirrorlist.bak
rankmirrors -n 6 mirrorlist.bak > mirrorlist