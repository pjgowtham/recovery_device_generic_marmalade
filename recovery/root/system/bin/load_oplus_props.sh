#!/system/bin/sh
# This script is needed to load properties for oplus devices

oplus_project=$(getprop ro.boot.prjname)
DIR="/odm/etc/$oplus_project"

if [ -d "$DIR" ]; then
  echo "load_oplus_props: ODM already mounted, proceeding to load" > /tmp/recovery.log
else
  # Sleep for 3s to fix mount issues on boot
  sleep 3
  mount /odm
fi

resetprop --file $DIR/build.default.prop
umount /odm

exit 0
