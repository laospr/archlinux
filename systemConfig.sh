#!/bin/bash

echo "$(dialog --stdout --inputbox "Enter Hostname:" 8 40)" > /etc/hostname

ln -s /usr/share/zoneinfo/$(dialog --stdout --inputbox "Enter your Zone Time:\nFor example: Asia/Vientiane" 8 40) /etc/localtime

keymaps=(
"ANSI-dvorak ANSI-dvorak off"
"amiga-de amiga-de off"
"amiga-us amiga-us off"
"applkey applkey off"
"atari-de atari-de off"
"atari-se atari-se off"
"atari-uk-falcon atari-uk-falcon off"
"atari-us atari-us off"
"azerty azerty off"
"backspace backspace off"
"bashkir bashkir off"
"be-latin1 be-latin1 off"
"bg-cp1251 bg-cp1251 off"
"bg-cp855 bg-cp855 off"
"bg_bds-cp1251 bg_bds-cp1251 off"
"bg_bds-utf8 bg_bds-utf8 off"
"bg_pho-cp1251 bg_pho-cp1251 off"
"bg_pho-utf8 bg_pho-utf8 off"
"br-abnt br-abnt off"
"br-abnt2 br-abnt2 off"
"br-latin1-abnt2 br-latin1-abnt2 off"
"br-latin1-us br-latin1-us off"
"by by off"
"by-cp1251 by-cp1251 off"
"bywin-cp1251 bywin-cp1251 off"
"cf cf off"
"colemak colemak off"
"croat croat off"
"ctrl ctrl off"
"cz cz off"
"cz-cp1250 cz-cp1250 off"
"cz-lat2 cz-lat2 off"
"cz-lat2-prog cz-lat2-prog off"
"cz-qwertz cz-qwertz off"
"cz-us-qwertz cz-us-qwertz off"
"de de off"
"de-latin1 de-latin1 off"
"de-latin1-nodeadkeys de-latin1-nodeadkeys off"
"de-mobii de-mobii off"
"de_CH-latin1 de_CH-latin1 off"
"de_alt_UTF-8 de_alt_UTF-8 off"
"defkeymap defkeymap off"
"defkeymap_V1.0 defkeymap_V1.0 off"
"dk dk off"
"dk-latin1 dk-latin1 off"
"dvorak dvorak off"
"dvorak-ca-fr dvorak-ca-fr off"
"dvorak-es dvorak-es off"
"dvorak-fr dvorak-fr off"
"dvorak-l dvorak-l off"
"dvorak-r dvorak-r off"
"dvorak-ru dvorak-ru off"
"dvorak-sv-a1 dvorak-sv-a1 off"
"dvorak-sv-a5 dvorak-sv-a5 off"
"dvorak-uk dvorak-uk off"
"emacs emacs off"
"emacs2 emacs2 off"
"es es off"
"es-cp850 es-cp850 off"
"es-olpc es-olpc off"
"et et off"
"et-nodeadkeys et-nodeadkeys off"
"euro euro off"
"euro1 euro1 off"
"euro2 euro2 off"
"fi fi off"
"fr fr off"
"fr-bepo fr-bepo off"
"fr-bepo-latin9 fr-bepo-latin9 off"
"fr-latin1 fr-latin1 off"
"fr-latin9 fr-latin9 off"
"fr-pc fr-pc off"
"fr_CH fr_CH off"
"fr_CH-latin1 fr_CH-latin1 off"
"gr gr off"
"gr-pc gr-pc off"
"hu hu off"
"hu101 hu101 off"
"il il off"
"il-heb il-heb off"
"il-phonetic il-phonetic off"
"is-latin1 is-latin1 off"
"is-latin1-us is-latin1-us off"
"it it off"
"it-ibm it-ibm off"
"it2 it2 off"
"jp106 jp106 off"
"kazakh kazakh off"
"keypad keypad off"
"ky_alt_sh-UTF-8 ky_alt_sh-UTF-8 off"
"kyrgyz kyrgyz off"
"la-latin1 la-latin1 off"
"lt lt off"
"lt.baltic lt.baltic off"
"lt.l4 lt.l4 off"
"lv lv off"
"lv-tilde lv-tilde off"
"mac-be mac-be off"
"mac-de-latin1 mac-de-latin1 off"
"mac-de-latin1-nodeadkeys mac-de-latin1-nodeadkeys off"
"mac-de_CH mac-de_CH off"
"mac-dk-latin1 mac-dk-latin1 off"
"mac-dvorak mac-dvorak off"
"mac-es mac-es off"
"mac-euro mac-euro off"
"mac-euro2 mac-euro2 off"
"mac-fi-latin1 mac-fi-latin1 off"
"mac-fr mac-fr off"
"mac-fr_CH-latin1 mac-fr_CH-latin1 off"
"mac-it mac-it off"
"mac-pl mac-pl off"
"mac-pt-latin1 mac-pt-latin1 off"
"mac-se mac-se off"
"mac-template mac-template off"
"mac-uk mac-uk off"
"mac-us mac-us off"
"mk mk off"
"mk-cp1251 mk-cp1251 off"
"mk-utf mk-utf off"
"mk0 mk0 off"
"nl nl off"
"nl2 nl2 off"
"no no off"
"no-dvorak no-dvorak off"
"no-latin1 no-latin1 off"
"pc110 pc110 off"
"pl pl off"
"pl1 pl1 off"
"pl2 pl2 off"
"pl3 pl3 off"
"pl4 pl4 off"
"pt-latin1 pt-latin1 off"
"pt-latin9 pt-latin9 off"
"pt-olpc pt-olpc off"
"ro ro off"
"ro_std ro_std off"
"ro_win ro_win off"
"ru ru off"
"ru-cp1251 ru-cp1251 off"
"ru-ms ru-ms off"
"ru-yawerty ru-yawerty off"
"ru1 ru1 off"
"ru2 ru2 off"
"ru3 ru3 off"
"ru4 ru4 off"
"ru_win ru_win off"
"ruwin_alt-CP1251 ruwin_alt-CP1251 off"
"ruwin_alt-KOI8-R ruwin_alt-KOI8-R off"
"ruwin_alt-UTF-8 ruwin_alt-UTF-8 off"
"ruwin_alt_sh-UTF-8 ruwin_alt_sh-UTF-8 off"
"ruwin_cplk-CP1251 ruwin_cplk-CP1251 off"
"ruwin_cplk-KOI8-R ruwin_cplk-KOI8-R off"
"ruwin_cplk-UTF-8 ruwin_cplk-UTF-8 off"
"ruwin_ct_sh-CP1251 ruwin_ct_sh-CP1251 off"
"ruwin_ct_sh-KOI8-R ruwin_ct_sh-KOI8-R off"
"ruwin_ct_sh-UTF-8 ruwin_ct_sh-UTF-8 off"
"ruwin_ctrl-CP1251 ruwin_ctrl-CP1251 off"
"ruwin_ctrl-KOI8-R ruwin_ctrl-KOI8-R off"
"ruwin_ctrl-UTF-8 ruwin_ctrl-UTF-8 off"
"se-fi-ir209 se-fi-ir209 off"
"se-fi-lat6 se-fi-lat6 off"
"se-ir209 se-ir209 off"
"se-lat6 se-lat6 off"
"sg sg off"
"sg-latin1 sg-latin1 off"
"sg-latin1-lk450 sg-latin1-lk450 off"
"sk-prog-qwerty sk-prog-qwerty off"
"sk-prog-qwertz sk-prog-qwertz off"
"sk-qwerty sk-qwerty off"
"sk-qwertz sk-qwertz off"
"slovene slovene off"
"sr-cy sr-cy off"
"sun-pl sun-pl off"
"sun-pl-altgraph sun-pl-altgraph off"
"sundvorak sundvorak off"
"sunkeymap sunkeymap off"
"sunt4-es sunt4-es off"
"sunt4-fi-latin1 sunt4-fi-latin1 off"
"sunt4-no-latin1 sunt4-no-latin1 off"
"sunt5-cz-us sunt5-cz-us off"
"sunt5-de-latin1 sunt5-de-latin1 off"
"sunt5-es sunt5-es off"
"sunt5-fi-latin1 sunt5-fi-latin1 off"
"sunt5-fr-latin1 sunt5-fr-latin1 off"
"sunt5-ru sunt5-ru off"
"sunt5-uk sunt5-uk off"
"sunt5-us-cz sunt5-us-cz off"
"sunt6-uk sunt6-uk off"
"sv-latin1 sv-latin1 off"
"tj_alt-UTF8 tj_alt-UTF8 off"
"tr_f-latin5 tr_f-latin5 off"
"tr_q-latin5 tr_q-latin5 off"
"tralt tralt off"
"trf trf off"
"trf-fgGIod trf-fgGIod off"
"trq trq off"
"ttwin_alt-UTF-8 ttwin_alt-UTF-8 off"
"ttwin_cplk-UTF-8 ttwin_cplk-UTF-8 off"
"ttwin_ct_sh-UTF-8 ttwin_ct_sh-UTF-8 off"
"ttwin_ctrl-UTF-8 ttwin_ctrl-UTF-8 off"
"ua ua off"
"ua-cp1251 ua-cp1251 off"
"ua-utf ua-utf off"
"ua-utf-ws ua-utf-ws off"
"ua-ws ua-ws off"
"uk uk off"
"unicode unicode off"
"us us on"
"us-acentos us-acentos off"
"wangbe wangbe off"
"wangbe2 wangbe2 off"
"windowkeys windowkeys off"
)

echo "KEYMAP=$(dialog --stdout --radiolist "Select Keymap" 20 70 50 ${keymaps[@]})" > /etc/vconsole.conf

aux=$(sed -e '1,23d' -e 's/#//g' -e 's/ /#/g' -e 's/..$//' /etc/locale.gen)
index=0
for i in $aux; do
i=$(echo $i | sed -e 's/#/ /g')
locales+=("$i" "$i" off)
if [[ $i == "en_US.UTF-8 UTF-8" || $i == "en_US ISO-8859-1" ]]; then
locales[$index]="$i"
locales[$((index+1))]="$i"
locales[$((index+2))]="on"
fi
index=$((index+3))
done

locale=$(dialog --stdout --checklist "Select Locales" 20 70 50 "${locales[@]}")
locale=$(echo ${locale} | sed -e 's/" "/\n/g' -e 's/ /#/g' -e 's/"//g')

for i in ${locale[@]}; do
i=$(echo $i | sed -e 's/#/ /g')
sed -i -e "s/#$i/$i/g" /etc/locale.gen
done

locale-gen

aux=$(locale -a)
index=0
for i in $aux; do
langs+=("$i" "$i" on)
index=$((index+1))
done

echo "LANG=$(dialog --stdout --radiolist "Select your language" 20 70 50 ${langs[@]})" > /etc/locale.conf

mkinitcpio -p linux

hdd=$(cat /temporal | grep 'hdd=')
grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=grub --recheck
grub-mkconfig -o /boot/grub/grub.cfg

password=$(dialog --stdout --passwordbox "Insert root password" 8 40)

while [[ $password != $password2 ]]; do
password2=$(dialog --stdout --passwordbox "Repite root password" 8 40)
done

usermod -p $(openssl passwd ${password}) root

exit
