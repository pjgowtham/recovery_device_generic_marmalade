#
#	This file is part of the OrangeFox Recovery Project
# 	Copyright (C) 2021-2022 The OrangeFox Recovery Project
#
#	OrangeFox is free software: you can redistribute it and/or modify
#	it under the terms of the GNU General Public License as published by
#	the Free Software Foundation, either version 3 of the License, or
#	any later version.
#
#	OrangeFox is distributed in the hope that it will be useful,
#	but WITHOUT ANY WARRANTY; without even the implied warranty of
#	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#	GNU General Public License for more details.
#
# 	This software is released under GPL version 3 or any later version.
#	See <http://www.gnu.org/licenses/>.
#
# 	Please maintain this if you use this script or any part of it
#

export ALLOW_MISSING_DEPENDENCIES=true

FDEVICE="RMX3360"
#set -o xtrace

fox_get_target_device() {
local chkdev=$(echo "$BASH_SOURCE" | grep -w $FDEVICE)
   if [ -n "$chkdev" ]; then 
      FOX_BUILD_DEVICE="$FDEVICE"
   else
      chkdev=$(set | grep BASH_ARGV | grep -w $FDEVICE)
      [ -n "$chkdev" ] && FOX_BUILD_DEVICE="$FDEVICE"
   fi
}

if [ -z "$1" -a -z "$FOX_BUILD_DEVICE" ]; then
   fox_get_target_device
fi

if [ "$1" = "$FDEVICE" -o "$FOX_BUILD_DEVICE" = "$FDEVICE" ]; then
    export OF_AB_DEVICE=1
    export FOX_REPLACE_BUSYBOX_PS=1
    export FOX_REPLACE_TOOLBOX_GETPROP=1
    export OF_DISABLE_MIUI_SPECIFIC_FEATURES=1
    export FOX_DELETE_AROMAFM=1
    export OF_SCREEN_H=2340
    export OF_STATUS_H=100
    export OF_STATUS_INDENT_LEFT=48
    export OF_STATUS_INDENT_RIGHT=48
    export OF_ALLOW_DISABLE_NAVBAR=0
    export OF_USE_LOCKSCREEN_BUTTON=1
    export FOX_BUGGED_AOSP_ARB_WORKAROUND="1616300800"
    export FOX_USE_SPECIFIC_MAGISK_ZIP="~/magisk_canary_200122.zip"
    export TW_DEVICE_VERSION="R11.1"
    export FOX_VERSION=R11.1_0
    export OF_USE_TWRP_SAR_DETECT=1

    # let's see what are our build VARs
    if [ -n "$FOX_BUILD_LOG_FILE" -a -f "$FOX_BUILD_LOG_FILE" ]; then
       export | grep "FOX" >> $FOX_BUILD_LOG_FILE
       export | grep "OF_" >> $FOX_BUILD_LOG_FILE
       export | grep "TARGET_" >> $FOX_BUILD_LOG_FILE
       export | grep "TW_" >> $FOX_BUILD_LOG_FILE
    fi
fi
