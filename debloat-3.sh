#!/system/bin/sh
# ============================================
#  Saturnity Debloat Tool
#  by lanavienrose
# ============================================

BASE_URL="https://github.com/lucivaantarez/redfinger-setup/releases/latest/download"

clear_screen() {
  printf "\033[2J\033[H"
}

print_header() {
  clear_screen
  printf "\033[36m"
  printf "  ███████╗ █████╗ ████████╗██╗   ██╗██████╗ ███╗   ██╗██╗████████╗██╗   ██╗\n"
  printf "  ██╔════╝██╔══██╗╚══██╔══╝██║   ██║██╔══██╗████╗  ██║██║╚══██╔══╝╚██╗ ██╔╝\n"
  printf "  ███████╗███████║   ██║   ██║   ██║██████╔╝██╔██╗ ██║██║   ██║    ╚████╔╝\n"
  printf "  ╚════██║██╔══██║   ██║   ██║   ██║██╔══██╗██║╚██╗██║██║   ██║     ╚██╔╝\n"
  printf "  ███████║██║  ██║   ██║   ╚██████╔╝██║  ██║██║ ╚████║██║   ██║      ██║\n"
  printf "  ╚══════╝╚═╝  ╚═╝   ╚═╝    ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═══╝╚═╝   ╚═╝      ╚═╝\n"
  printf "\033[0m"
  printf "\033[36m                        v1.0.0  by lanavienrose\033[0m\n"
  printf "\033[90m  ─────────────────────────────────────────────────────\033[0m\n\n"
}

print_section() {
  printf "  \033[36m%-40s %s\033[0m\n" "PACKAGE" "STATUS"
  printf "\033[90m  ─────────────────────────────────────────────────\033[0m\n"
}

print_status_row() {
  printf "  \033[37m%-40s\033[0m ${2}%s\033[0m\n" "$1" "$3"
}

uninstall_pkg() {
  result=$(su -c "pm uninstall -k --user 0 $1" 2>&1)
  if echo "$result" | grep -q "Success"; then
    print_status_row "$1" "\033[32m" "Removed"
  else
    print_status_row "$1" "\033[33m" "Skipped"
  fi
}

install_apk() {
  name=$1
  url=$2
  print_status_row "$name" "\033[33m" "Downloading..."
  curl -sSL "$url" -o /sdcard/Download/"$name".apk 2>/dev/null
  result=$(su -c "pm install /sdcard/Download/$name.apk" 2>&1)
  if echo "$result" | grep -q "Success"; then
    printf "\033[1A\033[2K"
    print_status_row "$name" "\033[32m" "Installed"
  else
    printf "\033[1A\033[2K"
    print_status_row "$name" "\033[31m" "Failed"
  fi
}

uninstall_bloat() {
  print_header
  printf "  \033[36mUninstalling Safe Bloatware...\033[0m\n\n"
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
  printf "  \033[36mUninstalling Google Apps...\033[0m\n\n"
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
  printf "  \033[36mUninstalling Themes & Icon Packs...\033[0m\n\n"
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
  printf "  \033[36mInstall Apps\033[0m\n\n"
  printf "  \033[36m%-40s %s\033[0m\n" "OPTION" "APP"
  printf "\033[90m  ─────────────────────────────────────────────────\033[0m\n"
  printf "  \033[37m1\033[0m                                        MT Manager\n"
  printf "  \033[37m2\033[0m                                        Smart Launcher 6\n"
  printf "  \033[37m3\033[0m                                        Kernel Adiutor\n"
  printf "  \033[37m4\033[0m                                        1.1.1.1 VPN\n"
  printf "  \033[37m5\033[0m                                        Install ALL\n"
  printf "  \033[37m6\033[0m                                        Back\n"
  printf "\033[90m  ─────────────────────────────────────────────────\033[0m\n\n"
  printf "  \033[36mSelect option:\033[0m "
  read ichoice

  print_header
  printf "  \033[36mInstalling Apps...\033[0m\n\n"
  print_section

  if [ "$ichoice" = "1" ]; then
    install_apk "MT Manager" "$BASE_URL/manager.apk"
  elif [ "$ichoice" = "2" ]; then
    install_apk "Smart Launcher 6" "$BASE_URL/launcher.apk"
  elif [ "$ichoice" = "3" ]; then
    install_apk "Kernel Adiutor" "$BASE_URL/kernel.apk"
  elif [ "$ichoice" = "4" ]; then
    install_apk "1.1.1.1 VPN" "$BASE_URL/vpn.apk"
  elif [ "$ichoice" = "5" ]; then
    install_apk "MT Manager"       "$BASE_URL/manager.apk"
    install_apk "Smart Launcher 6" "$BASE_URL/launcher.apk"
    install_apk "Kernel Adiutor"   "$BASE_URL/kernel.apk"
    install_apk "1.1.1.1 VPN"      "$BASE_URL/vpn.apk"
  elif [ "$ichoice" = "6" ]; then
    return
  else
    printf "  \033[31mInvalid choice!\033[0m\n"
  fi
}

show_done() {
  printf "\n\033[90m  ─────────────────────────────────────────────────\033[0m\n"
  printf "  \033[32mDone!\033[0m \033[37mReboot recommended.\033[0m\n\n"
}

# ---- MAIN MENU ----
print_header
printf "  \033[36m%-40s %s\033[0m\n" "OPTION" "ACTION"
printf "\033[90m  ─────────────────────────────────────────────────\033[0m\n"
printf "  \033[37m1\033[0m                                        Safe Bloatware\n"
printf "  \033[37m2\033[0m                                        Google Apps\n"
printf "  \033[37m3\033[0m                                        Theme & Icon Packs\n"
printf "  \033[37m4\033[0m                                        Uninstall ALL\n"
printf "  \033[37m5\033[0m                                        Install Apps\n"
printf "  \033[37m6\033[0m                                        Uninstall ALL + Install ALL\n"
printf "  \033[37m7\033[0m                                        Exit\n"
printf "\033[90m  ─────────────────────────────────────────────────\033[0m\n\n"
printf "  \033[36mSelect option:\033[0m "
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
  uninstall_bloat; uninstall_google; uninstall_themes; install_menu; show_done
elif [ "$choice" = "7" ]; then
  clear_screen; exit 0
else
  print_header
  printf "  \033[31mInvalid choice!\033[0m\n\n"
fi
