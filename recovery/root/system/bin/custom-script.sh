#!/system/bin/sh
# This script is needed to set some device props

# Oneplus 9RT
load_OP5155()
{
      resetprop "ro.product.device" "OP5155,OP5155L1,MT2111"
      resetprop "ro.twrp.target.devices" "OP5155,OP5155L1,MT2111"
      resetprop "vendor.usb.product_string" "martini"
}

# Oppo K9S
load_OP524F()
{
      resetprop "ro.product.device" "OP524F,PERM10"
      resetprop "ro.twrp.target.devices" "OP524F,PERM10"
      resetprop "vendor.usb.product_string" "OppoK9S"
}

# Realme GT Master edition
load_RMX3360()
{
      resetprop "ro.product.device" "RMX3360,RMX3360L1,RE54ABL1,RMX3363"
      resetprop "ro.twrp.target.devices" "RMX3360,RMX3360L1,RE54ABL1,RMX3363"
      resetprop "vendor.usb.product_string" "RealmeGTMaster"
}

# Realme GT 5G
load_RMX2202()
{
      resetprop "ro.product.device" "RMX2202,RMX2202L1,RMX2202CN"
      resetprop "ro.twrp.target.devices" "RMX2202,RMX2202L1,RMX2202CN"
      resetprop "vendor.usb.product_string" "RealmeGT"
}

# Realme Q3S
load_RMX3461()
{
      resetprop "ro.product.device" "RMX3461,RE548B,RMX3461T2,RE548BL1,RE54BFL1"
      resetprop "ro.twrp.target.devices" "RMX3461,RE548B,RMX3461T2,RE548BL1,RE54BFL1"
      resetprop "vendor.usb.product_string" "RealmeQ3S"
}

project=$(getprop ro.boot.prjname)
echo "Running Custom Script for $(getprop ro.product.device) , prjname $(getprop ro.boot.prjname)" >> /tmp/recovery.log

case $project in
     "20664")
          load_RMX2202
          ;;
     "20627")
          load_RMX2202
          ;;
     "20821")
          load_OP5155
          ;;
     "21075")
          load_OP524F
          ;;
     "21643"|"21644"|"21695")
          load_RMX3461
          ;;
     "21675")
          load_RMX3360
          ;;
esac
exit 0
