#!/bin/bash

fullname=$(dialog --stdout --inputbox "Full name" 8 40)

user=$(dialog --stdout --inputbox "user name" 8 40)

password=$(dialog --stdout --passwordbox "Insert ${user#*=} password" 8 40)

while [[ $password != $password2 ]]; do
password2=$(dialog --stdout --passwordbox "Reply  password" 8 40)
done

useradd -m -g users -G wheel,power,storage -s /bin/zsh -p $(openssl passwd $password) -c ${fullname#*=} ${user#*=}

exit
