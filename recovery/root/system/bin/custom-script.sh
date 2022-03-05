#!/system/bin/sh
# This script is needed to set some device props


echo "Running Custom Script for $(getprop ro.product.device) , prjname $(getprop ro.boot.prjname)" >> /tmp/recovery.log

# Set vendor.usb.product_string ( Obtained from init.qcom.usb.sh)
msm_serial=`cat /sys/devices/soc0/serial_number`
msm_serial_hex=`printf %08X $msm_serial`
machine_type=`cat /sys/devices/soc0/machine`

setprop vendor.usb.product_string "$machine_type-$soc_hwplatform _SN:$msm_serial_hex"

echo "Custom Script : vendor.usb.product_string is $(getprop vendor.usb.product_string)" >> /tmp/recovery.log
exit 0
