#!/system/bin/sh
# ============================================
#  Redfinger Debloat Tool
#  by lanavienrose
# ============================================

uninstall_pkg() {
  result=$(su -c "pm uninstall -k --user 0 $1" 2>&1)
  if echo "$result" | grep -q "Success"; then
    echo "✅ Uninstalled: $1"
  else
    echo "❌ Failed: $1"
  fi
}

uninstall_bloat() {
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
    uninstall_pkg "$pkg"
  done
}

uninstall_google() {
  for pkg in \
    com.android.vending com.google.android.play.games \
    com.google.android.gsf com.google.android.gsf.login \
    android.ext.services android.ext.shared
  do
    uninstall_pkg "$pkg"
  done
}

uninstall_themes() {
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

echo ""
echo "====================================="
echo "     REDFINGER DEBLOAT TOOL"
echo "        by lanavienrose"
echo "====================================="
echo ""
echo "Select what to uninstall:"
echo "  1) Safe Bloatware (calendar, email, music etc)"
echo "  2) Google Apps (Play Store, Play Games, GSF)"
echo "  3) Theme & Icon Packs"
echo "  4) ALL of the above"
echo "  5) Exit"
echo ""
printf "Enter choice [1-5]: "
read choice

if [ "$choice" = "1" ]; then
  echo "Uninstalling safe bloatware..."
  uninstall_bloat
elif [ "$choice" = "2" ]; then
  echo "Uninstalling Google apps..."
  uninstall_google
elif [ "$choice" = "3" ]; then
  echo "Uninstalling theme & icon packs..."
  uninstall_themes
elif [ "$choice" = "4" ]; then
  echo "Uninstalling everything..."
  uninstall_bloat
  uninstall_google
  uninstall_themes
elif [ "$choice" = "5" ]; then
  echo "Exiting..."
  exit 0
else
  echo "Invalid choice!"
  exit 1
fi

echo ""
echo "====================================="
echo "   Done! Reboot recommended"
echo "====================================="
