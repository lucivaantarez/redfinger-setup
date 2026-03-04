#!/bin/bash
# ============================================
#  Redfinger Debloat Tool
#  by lanavienrose
# ============================================

GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

uninstall_pkg() {
  local pkg=$1
  result=$(su -c "pm uninstall -k --user 0 $pkg" 2>&1)
  if echo "$result" | grep -q "Success"; then
    echo -e "${GREEN}✅ Uninstalled: $pkg${NC}"
  else
    echo -e "${RED}❌ Failed: $pkg${NC}"
  fi
}

echo -e "${CYAN}"
echo "╔════════════════════════════════════╗"
echo "║     REDFINGER DEBLOAT TOOL         ║"
echo "║        by lanavienrose             ║"
echo "╚════════════════════════════════════╝"
echo -e "${NC}"
echo -e "${YELLOW}Select what to uninstall:${NC}"
echo "  1) Safe Bloatware (calendar, email, music etc)"
echo "  2) Google Apps (Play Store, Play Games, GSF)"
echo "  3) Theme & Icon Packs"
echo "  4) ALL of the above"
echo "  5) Exit"
echo ""
read -p "Enter choice [1-5]: " choice

case $choice in
  1)
    echo -e "\n${CYAN}Uninstalling safe bloatware...${NC}"
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
      com.cpuid.cpu_z com.grarak.kerneladiutor com.android.protips \
      com.android.hotspot2 com.baidu.cloud.service com.android.wallpapercropper \
      com.android.wallpaperbackup com.android.traceur com.android.smspush \
      com.android.simappdialog com.android.htmlviewer com.android.carrierconfig \
      com.android.carrierdefaultapp com.android.cellbroadcastreceiver \
      com.android.ons com.android.mtp ginlemon.flowerfree
    do
      uninstall_pkg $pkg
    done
    ;;
  2)
    echo -e "\n${CYAN}Uninstalling Google apps...${NC}"
    for pkg in \
      com.android.vending com.google.android.play.games \
      com.google.android.gsf com.google.android.gsf.login \
      android.ext.services android.ext.shared
    do
      uninstall_pkg $pkg
    done
    ;;
  3)
    echo -e "\n${CYAN}Uninstalling theme & icon packs...${NC}"
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
      uninstall_pkg $pkg
    done
    ;;
  4)
    echo -e "\n${CYAN}Uninstalling everything...${NC}"
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
      com.cpuid.cpu_z com.grarak.kerneladiutor com.android.protips \
      com.android.hotspot2 com.baidu.cloud.service com.android.wallpapercropper \
      com.android.wallpaperbackup com.android.traceur com.android.smspush \
      com.android.simappdialog com.android.htmlviewer com.android.carrierconfig \
      com.android.carrierdefaultapp com.android.cellbroadcastreceiver \
      com.android.ons com.android.mtp ginlemon.flowerfree \
      com.android.vending com.google.android.play.games \
      com.google.android.gsf com.google.android.gsf.login \
      android.ext.services android.ext.shared \
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
      uninstall_pkg $pkg
    done
    ;;
  5)
    echo -e "${YELLOW}Exiting...${NC}"
    exit 0
    ;;
  *)
    echo -e "${RED}Invalid choice!${NC}"
    exit 1
    ;;
esac

echo -e "\n${GREEN}╔════════════════════════════════════╗"
echo "║        Done! Reboot recommended    ║"
echo -e "╚════════════════════════════════════╝${NC}"
