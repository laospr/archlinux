#!/bin/bash
#Temporal is a file that contains parameters to use when access to chroot

partition(){

#Search and show the Hard Disks to select
aux=$(ls /dev/sd?)
index=0
for i in $aux; do
hdds[$index]="${i} ${i#/*/} off"
index=$((index+1))
done

hdd=$(dialog --stdout --radiolist "Select Hard Disk" 20 70 50 ${hdds[@]})

#If exist the line delete
if (cat ~/temporal | grep "hdd=") >/dev/null
then
sed -i -e '/hdd=*/d' ~/temporal
fi

#And add the new line with new parameter
echo "hdd=$hdd" >> ~/temporal

selection=$(dialog --stdout --menu "Partitioning method"  20 70 50 \
1 "Use EFI(512MB), swap(16GB),root(256G), home(remaining space)" \
2 "Use gparted to customize" )

case $selection in
1)
umount /mnt > /dev/null
#Create msdos partition table
parted -s $hdd -- mklabel gpt

#Create partition swap and /
parted -s $hdd -- mkpart ESP fat32 1MiB 513MiB mkpart primary 513MiB 16897MiB mkpart primary 16897MiB 279041MiB mkpart primary 279041MiB -1

#Boot option partition /
parted -s $hdd -- set 1 boot on

#Format and partitions and mount /
(echo t; echo 2; echo 82; echo w) | fdisk $hdd
mkfs.fat -F32 ${hdd}1
mkswap ${hdd}2
mkfs.ext4 -F ${hdd}3
mkfs.ext4 -F ${hdd}4
mount ${hdd}3 /mnt
mkdir /mnt/{boot,home}
mount ${hdd}1 /mnt/boot
mount ${hdd}4 /mnt/home
swapon ${hdd}2
;;
esac
}


option=0
while [ option != 9 ]; do
option=$(dialog --stdout --menu "Arch Linux Installation CLI"  20 70 50 \
1 "Set Date and Time" \
2 "Update pacman and keying" \
3 "Format and Mount Partitions" \
4 "Install Base System" \
5 "Install GRUB" \
6 "System Configure" \
7 "Create User Account" \
8 "Desktop Environment" \
9 "Exit" )

case $option in
1)
# Set date and time
unlink /etc/localtime
ln -s /usr/share/zoneinfo/$(dialog --stdout --inputbox "Enter your Zone Time:\nFor example: Asia/Vientiane" 8 40) /etc/localtime
ntpd -qg
;;
2)
# Update pacman and keying
pacman -Sy archlinux-keyring --noconfirm
pacman-key --populate archlinux
pacman-key --refresh-keys
;;
3)
partition
;;
4)
#Install base system
pacbase=0
while [ pacbase != 9 ]; do
pacbase=$(dialog --stdout --menu "Select Base to install"  20 70 50 \
1 "Generic Base" \
2 "Devel Base" \
3 "Basic Network Administration" \
9 "Exit")
case $pacbase in
1)
#Generic Base
pacstrap /mnt
pacstrap /mnt base
pacstrap /mnt dialog
pacstrap /mnt polkit
break
;;
2)
pacstrap /mnt
pacstrap /mnt base
pacstrap /mnt dialog
pacstrap /mnt base-devel
pacstrap /mnt polkit
break
;;
3)
pacstrap /mnt
pacstrap /mnt base
pacstrap /mnt dialog
pacstrap /mnt base-devel
pacstrap /mnt bind
pacstrap /mnt net-tools
pacstrap /mnt openssh
pacstrap /mnt sudo
pacstrap /mnt zsh
pacstrap /mnt ntpd
pacstrap /mnt vim
pacstrap /mnt ntfs-3g
pacstrap /mnt dosfstools
pacstrap /mnt wpa_supplicant
pacstrap /mnt polkit
break
;;
*)
break
;;
esac
done
;;
5)
#Install grub
pacstrap /mnt grub efibootmgr
;;
6)
#Generate fstab and acces to chroot to do System Config
genfstab -pU /mnt >> /mnt/etc/fstab
echo "tmpfs			/tmp		tmpfs		defaults,noatime,mode=1777	0 0" >> /mnt/etc/fstab
cp ~/temporal /mnt
cp ~/systemConfig.sh /mnt
chmod +x /mnt/systemConfig.sh
arch-chroot /mnt /systemConfig.sh
rm -r /mnt/systemConfig.sh
;;
7)
#Create a new username and save in temporal, to use after
if (cat ~/temporal | grep "userName=") >/dev/null
then
sed -i -e '/userName=*/d' ~/temporal
fi

echo "userName=$(dialog --stdout --inputbox "Enter an User Name" 8 40)" >> ~/temporal
echo "userFullname=$(dialog --stdout --inputbox "Enter an User Full Name" 8 40)" >> ~/temporal
cp ~/temporal /mnt
cp ~/userAccount.sh /mnt
chmod +x /mnt/userAccount.sh
arch-chroot /mnt /userAccount.sh
rm -r /mnt/userAccount.sh
;;
*)
#Delete temporal file and umount partitions
rm -r /mnt/temporal
umount /mnt/boot > /dev/null
umount /mnt/home > /dev/null
umount /mnt > /dev/null
swapoff -a
exit
;;
esac
done
