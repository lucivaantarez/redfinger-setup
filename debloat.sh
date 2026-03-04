#!/system/bin/sh
# ============================================
#  Saturnity Debloat Tool
#  by lanavienrose
# ============================================

BASE_URL="https://github.com/lucivaantarez/redfinger-setup/releases/latest/download"
C="\033[36m"   # cyan
G="\033[32m"   # green
Y="\033[33m"   # yellow
R="\033[31m"   # red
W="\033[97m"   # white
D="\033[90m"   # dark/dim
N="\033[0m"    # reset

clear_screen() { printf "\033[2J\033[H"; }

line() { printf "${D}  ------------------------------------------------${N}\n"; }

print_header() {
  clear_screen
  printf "${C}  ██         ████   ██    ██   ████  \n"
  printf "  ██        ██  ██  ███   ██  ██  ██ \n"
  printf "  ██       ████████ ██ █  ██ ████████\n"
  printf "  ██       ██    ██ ██  █ ██ ██    ██\n"
  printf "  ████████ ██    ██ ██   ███ ██    ██${N}\n"
  printf "${D}                   v1.0.0  by lanavienrose${N}\n"
  line
  printf "\n"
}

print_section() {
  printf "  ${C}%-34s %s${N}\n" "PACKAGE" "STATUS"
  line
}

status_row() {
  pkg=$1
  color=$2
  label=$3
  printf "  ${W}%-34s${N} ${color}%s${N}\n" "$pkg" "$label"
}

uninstall_pkg() {
  result=$(su -c "pm uninstall -k --user 0 $1" 2>&1)
  if echo "$result" | grep -q "Success"; then
    status_row "$1" "${G}" "Removed"
  else
    status_row "$1" "${Y}" "Skipped"
  fi
}

install_apk() {
  name=$1
  url=$2
  status_row "$name" "${Y}" "Downloading..."
  curl -sSL "$url" -o /sdcard/Download/"$name".apk 2>/dev/null
  result=$(su -c "pm install /sdcard/Download/$name.apk" 2>&1)
  printf "\033[1A\033[2K"
  if echo "$result" | grep -q "Success"; then
    status_row "$name" "${G}" "Installed"
  else
    status_row "$name" "${R}" "Failed"
  fi
}

uninstall_bloat() {
  print_header
  printf "  ${C}>> Safe Bloatware${N}\n\n"
  print_section
  for pkg in \
    com.android.calendar com.android.email com.android.messaging \
    com.android.music com.android.musicfx com.android.soundrecorder \
    com.android.deskclock com.android.dreams.basic com.android.dreams.phototable \
    com.android.quicksearchbox com.android.wallpaper.livepicker \
    com.android.printspooler com.android.printservice.recommendation \
    com.android.bookmarkprovider com.android.egg com.android.nfc \
    com.android.bluetooth com.android.bluetoothmidiservice com.android.bips \
    com.android.gallery3d com.android.contacts com.android.dialer \
    com.android.emergency com.wsh.appstore com.wsh.toolkit \
    com.android.protips com.android.hotspot2 com.baidu.cloud.service \
    com.android.wallpapercropper com.android.wallpaperbackup com.android.traceur \
    com.android.smspush com.android.simappdialog com.android.htmlviewer \
    com.android.carrierconfig com.android.carrierdefaultapp \
    com.android.cellbroadcastreceiver com.android.ons com.android.mtp \
    android.ext.services com.google.android.apps.nbu.files
  do
    uninstall_pkg "$pkg"
  done
}

uninstall_google() {
  print_header
  printf "  ${C}>> Google Apps${N}\n\n"
  print_section
  for pkg in \
    com.android.vending com.google.android.play.games \
    com.google.android.gsf com.google.android.gsf.login \
    android.ext.shared
  do
    uninstall_pkg "$pkg"
  done
}

uninstall_themes() {
  print_header
  printf "  ${C}>> Theme & Icon Packs${N}\n\n"
  print_section
  for pkg in \
    com.android.theme.color.black com.android.theme.color.cinnamon \
    com.android.theme.color.green com.android.theme.color.ocean \
    com.android.theme.color.orchid com.android.theme.color.purple \
    com.android.theme.color.space com.android.theme.font.notoserifsource \
    com.android.theme.icon.roundedrect com.android.theme.icon.squircle \
    com.android.theme.icon.teardrop \
    com.android.theme.icon_pack.circular.android \
    com.android.theme.icon_pack.circular.launcher \
    com.android.theme.icon_pack.circular.settings \
    com.android.theme.icon_pack.circular.systemui \
    com.android.theme.icon_pack.filled.android \
    com.android.theme.icon_pack.filled.launcher \
    com.android.theme.icon_pack.filled.settings \
    com.android.theme.icon_pack.filled.systemui \
    com.android.theme.icon_pack.rounded.android \
    com.android.theme.icon_pack.rounded.launcher \
    com.android.theme.icon_pack.rounded.settings \
    com.android.theme.icon_pack.rounded.systemui
  do
    uninstall_pkg "$pkg"
  done
}

install_menu() {
  print_header
  printf "  ${C}>> Install Apps${N}\n\n"
  printf "  ${C}%-34s %s${N}\n" "OPTION" "APP"
  line
  printf "  ${C}[1]${N}  ${W}MT Manager${N}\n"
  printf "  ${C}[2]${N}  ${W}Smart Launcher 6${N}\n"
  printf "  ${C}[3]${N}  ${W}Kernel Adiutor${N}\n"
  printf "  ${C}[4]${N}  ${W}1.1.1.1 VPN${N}\n"
  printf "  ${C}[5]${N}  ${W}Install ALL${N}\n"
  printf "  ${C}[6]${N}  ${D}Back${N}\n"
  line
  printf "\n  ${C}Select option: ${N}"
  read ichoice

  print_header
  printf "  ${C}>> Installing...${N}\n\n"
  print_section

  if [ "$ichoice" = "1" ]; then
    install_apk "MT Manager"       "$BASE_URL/manager.apk"
  elif [ "$ichoice" = "2" ]; then
    install_apk "Smart Launcher 6" "$BASE_URL/launcher.apk"
  elif [ "$ichoice" = "3" ]; then
    install_apk "Kernel Adiutor"   "$BASE_URL/kernel.apk"
  elif [ "$ichoice" = "4" ]; then
    install_apk "1.1.1.1 VPN"      "$BASE_URL/vpn.apk"
  elif [ "$ichoice" = "5" ]; then
    install_apk "MT Manager"       "$BASE_URL/manager.apk"
    install_apk "Smart Launcher 6" "$BASE_URL/launcher.apk"
    install_apk "Kernel Adiutor"   "$BASE_URL/kernel.apk"
    install_apk "1.1.1.1 VPN"      "$BASE_URL/vpn.apk"
  elif [ "$ichoice" = "6" ]; then
    return
  else
    printf "  ${R}Invalid choice!${N}\n"
  fi
}

show_done() {
  line
  printf "  ${G}Done!${N} ${W}Reboot recommended.${N}\n\n"
}

# ---- MAIN MENU ----
print_header
printf "  ${C}%-34s %s${N}\n" "OPTION" "ACTION"
line
printf "  ${C}[1]${N}  ${W}Safe Bloatware${N}\n"
printf "  ${C}[2]${N}  ${W}Google Apps${N}\n"
printf "  ${C}[3]${N}  ${W}Theme & Icon Packs${N}\n"
printf "  ${Y}[4]${N}  ${W}Uninstall ALL${N}  ${D}(caution)${N}\n"
printf "  ${C}[5]${N}  ${W}Install Apps${N}\n"
printf "  ${Y}[6]${N}  ${W}Uninstall ALL + Install ALL${N}  ${D}(caution)${N}\n"
printf "  ${D}[7]  Exit${N}\n"
line
printf "\n  ${C}Select option: ${N}"
read choice

if [ "$choice" = "1" ]; then
  uninstall_bloat; show_done
elif [ "$choice" = "2" ]; then
  uninstall_google; show_done
elif [ "$choice" = "3" ]; then
  uninstall_themes; show_done
elif [ "$choice" = "4" ]; then
  uninstall_bloat; uninstall_google; uninstall_themes; show_done
elif [ "$choice" = "5" ]; then
  install_menu; show_done
elif [ "$choice" = "6" ]; then
  uninstall_bloat; uninstall_google; uninstall_themes
  install_menu; show_done
elif [ "$choice" = "7" ]; then
  clear_screen; exit 0
else
  print_header
  printf "  ${R}Invalid choice!${N}\n\n"
fi
