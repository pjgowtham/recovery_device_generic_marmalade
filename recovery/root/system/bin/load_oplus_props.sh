#!/system/bin/sh
# This script is needed to load properties for oplus devices

oplus_project=$(getprop ro.boot.prjname)
DIR="/odm/etc/$oplus_project"
generic_device_prop=$(getprop ro.product.device)

if [ -d "$DIR" ]; then
  echo "load_oplus_props: ODM already mounted, proceeding to load" > /tmp/recovery.log
else
  # Sleep for 3s to fix mount issues on boot
  sleep 3
  mount /odm
fi

resetprop --file /odm/etc/build.prop
resetprop --file /odm/build.prop
resetprop --file $DIR/build.default.prop
umount /odm

# Custom device asserts
resetprop ro.twrp.target.devices $(getprop ro.product.odm.device),$(getprop ro.vendor.product.device.oem),$(getprop ro.vendor.product.oem)

# Fallback to hardcoded asserts to support known devices to mitigate cases where ROM flashing goes awry
case $oplus_project in
     "20664"|"20627") # Realme GT
          resetprop ro.twrp.target.devices RMX2202,RMX2202L1,RMX2202CN
          resetprop ro.product.device RMX2202
          ;;
     "20821") # Oneplus 9RT
          resetprop ro.twrp.target.devices OP5155,OP5155L1,MT2111
          resetprop ro.product.device OP5155
          ;;
     "21075") # Oppo K9S
          resetprop ro.twrp.target.devices OP524F,PERM10
          resetprop ro.product.device OP524F
          ;;
     "21643"|"21644"|"21695") # Realme Q3S
          resetprop ro.twrp.target.devices RMX3461,RE548B,RMX3461T2,RE548BL1,RE54BFL1
          resetprop ro.product.device RMX3461
          ;;
     "21675") # Realme GT Master Edition
          resetprop ro.twrp.target.devices RMX3360,RMX3360L1,RE54ABL1,RMX3363
          resetprop ro.product.device RMX3360
          ;;
     "216B2") # Realme GT Master Edition
          resetprop ro.twrp.target.devices RMX3312,,RE58B2L1
          resetprop ro.product.device RMX3312
          resetprop vendor.usb.product_string realmeGTMaster
          ;;          
esac

exit 0
