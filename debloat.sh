#!/system/bin/sh
# Lana Debloat Tool by lanavienrose

BASE_URL="https://github.com/lucivaantarez/redfinger-setup/releases/latest/download"
C="\033[36m"; G="\033[32m"; Y="\033[33m"; R="\033[31m"; D="\033[90m"; N="\033[0m"

cls() { printf "\033[2J\033[H"; }
hr()  { printf "${D}  ----------------------------------------${N}\n"; }

hdr() {
  cls
  printf "${C}  _    __   _  _   __ \n"
  printf " | |  / _| | \| | / _|\n"
  printf " | |_| |_  | .  || |_ \n"
  printf " |___|___| |_|\_| \__|\n${N}"
  printf "${D}  v1.0.0 by lanavienrose${N}\n"
  hr; printf "\n"
}

row() {
  # $1=name $2=color $3=label
  short=$(echo "$1" | awk -F'.' '{print $NF}')
  printf "  %-26s ${2}%s${N}\n" "$short" "$3"
}

upm() {
  r=$(su -c "pm uninstall -k --user 0 $1" 2>&1)
  if echo "$r" | grep -q "Success"; then row "$1" "$G" "OK"
  else row "$1" "$D" "--"; fi
}

iapk() {
  short=$(echo "$1" | awk -F'.' '{print $NF}' | cut -c1-26)
  printf "  %-26s ${Y}downloading${N}\n" "$1"
  curl -sSL "$2" -o /sdcard/Download/"$1".apk 2>/dev/null
  r=$(su -c "pm install /sdcard/Download/$1.apk" 2>&1)
  printf "\033[1A\033[2K"
  if echo "$r" | grep -q "Success"; then printf "  %-26s ${G}OK${N}\n" "$1"
  else printf "  %-26s ${R}FAILED${N}\n" "$1"; fi
}

do_bloat() {
  hdr; printf "  ${C}[Bloatware]${N}\n\n"
  printf "  %-26s %s\n" "PACKAGE" "STATUS"; hr
  for p in calendar email messaging music musicfx soundrecorder deskclock \
    dreams.basic dreams.phototable quicksearchbox wallpaper.livepicker \
    printspooler printservice.recommendation bookmarkprovider egg nfc \
    bluetooth bluetoothmidiservice bips gallery3d contacts dialer emergency; do
    upm "com.android.$p"
  done
  for p in com.wsh.appstore com.wsh.toolkit com.android.protips \
    com.android.hotspot2 com.baidu.cloud.service com.android.wallpapercropper \
    com.android.wallpaperbackup com.android.traceur com.android.smspush \
    com.android.simappdialog com.android.htmlviewer com.android.carrierconfig \
    com.android.carrierdefaultapp com.android.cellbroadcastreceiver \
    com.android.ons com.android.mtp android.ext.services \
    com.google.android.apps.nbu.files; do
    upm "$p"
  done
}

do_google() {
  hdr; printf "  ${C}[Google Apps]${N}\n\n"
  printf "  %-26s %s\n" "PACKAGE" "STATUS"; hr
  for p in com.android.vending com.google.android.play.games \
    com.google.android.gsf com.google.android.gsf.login android.ext.shared; do
    upm "$p"
  done
}

do_themes() {
  hdr; printf "  ${C}[Themes]${N}\n\n"
  printf "  %-26s %s\n" "PACKAGE" "STATUS"; hr
  for p in black cinnamon green ocean orchid purple space; do
    upm "com.android.theme.color.$p"
  done
  upm "com.android.theme.font.notoserifsource"
  for p in roundedrect squircle teardrop; do
    upm "com.android.theme.icon.$p"
  done
  for s in circular filled rounded; do
    for t in android launcher settings systemui; do
      upm "com.android.theme.icon_pack.$s.$t"
    done
  done
}

do_install() {
  hdr
  printf "  ${C}[1]${N} MT Manager\n"
  printf "  ${C}[2]${N} Smart Launcher 6\n"
  printf "  ${C}[3]${N} Kernel Adiutor\n"
  printf "  ${C}[4]${N} 1.1.1.1 VPN\n"
  printf "  ${C}[5]${N} Install ALL\n"
  printf "  ${D}[6] Back${N}\n"
  hr; printf "\n  ${C}Select: ${N}"; read ic
  hdr; printf "  ${C}[Installing]${N}\n\n"
  printf "  %-26s %s\n" "APP" "STATUS"; hr
  case "$ic" in
    1) iapk "MT Manager"       "$BASE_URL/manager.apk" ;;
    2) iapk "Smart Launcher 6" "$BASE_URL/launcher.apk" ;;
    3) iapk "Kernel Adiutor"   "$BASE_URL/kernel.apk" ;;
    4) iapk "1.1.1.1 VPN"      "$BASE_URL/vpn.apk" ;;
    5) iapk "MT Manager"       "$BASE_URL/manager.apk"
       iapk "Smart Launcher 6" "$BASE_URL/launcher.apk"
       iapk "Kernel Adiutor"   "$BASE_URL/kernel.apk"
       iapk "1.1.1.1 VPN"      "$BASE_URL/vpn.apk" ;;
  esac
}

done_msg() { hr; printf "  ${G}Done!${N} Reboot recommended.\n\n"; }

# MAIN
hdr
printf "  ${C}[1]${N} Safe Bloatware\n"
printf "  ${C}[2]${N} Google Apps\n"
printf "  ${C}[3]${N} Theme & Icon Packs\n"
printf "  ${Y}[4]${N} Uninstall ALL\n"
printf "  ${C}[5]${N} Install Apps\n"
printf "  ${Y}[6]${N} Uninstall ALL + Install ALL\n"
printf "  ${D}[7] Exit${N}\n"
hr; printf "\n  ${C}Select: ${N}"; read ch

case "$ch" in
  1) do_bloat; done_msg ;;
  2) do_google; done_msg ;;
  3) do_themes; done_msg ;;
  4) do_bloat; do_google; do_themes; done_msg ;;
  5) do_install; done_msg ;;
  6) do_bloat; do_google; do_themes; do_install; done_msg ;;
  7) cls; exit 0 ;;
  *) hdr; printf "  ${R}Invalid!${N}\n\n" ;;
esac
