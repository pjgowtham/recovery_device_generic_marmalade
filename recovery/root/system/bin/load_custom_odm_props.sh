#!/system/bin/sh
# This script is needed to load properties for oplus devices

# Sleep for 3s to fix mount issues on boot
sleep 3
mount /odm

resetprop --file /odm/etc/build.prop
umount /odm

# Custom device asserts
resetprop ro.twrp.target.devices $(getprop ro.product.odm.device),$(getprop ro.vendor.product.device.oem),$(getprop ro.vendor.product.oem)
resetprop ro.product.device $(ro.product.odm.device)
exit 0
