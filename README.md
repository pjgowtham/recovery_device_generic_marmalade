# Generic recovery device tree for device that use boot header v3/v4
Device that use boot header version v4 supports modular ramdisks, hence we are able to flash vendor_boot:$(ramdisk_name_that's_not_default) without touching OEM specific blobs like that of fstab or kernel modules. The goal is to support all methods of stock ROM asssertion and simulate the same methods that their OEM uses for the purpose of custom rom.

## Setting Up your Environment for TWRP
First Download and setup required items:
```
sudo -E apt-get -qq install bc build-essential zip curl libstdc++6 git wget python gcc clang libssl-dev repo rsync flex curl bison aria2
sudo curl --create-dirs -L -o /usr/local/bin/repo -O -L https://storage.googleapis.com/git-repo-downloads/repo
sudo chmod a+rx /usr/local/bin/repo
```
The Above code snippet is from "https://unofficialtwrp.com/build-compile-twrp-recovery/"

Then Make the directory and enter it at your desired location might be external disk or your personal folder/drive wherever exeute this and setup space for TWRP:
```
mkdir twrp && cd twrp
```
Seup TWRP repo to download source code for Android 12.1:
```
repo init --depth=1 -u https://github.com/minimal-manifest-twrp/platform_manifest_twrp_aosp.git -b twrp-12.1
```
Note : Remove --depth=1 if you are not intrested in saving space or want every content to be downloaded!

## Sync the Code
Do,
```
repo sync j$(nproc) --force-sync --no-clone-bundles --no-tags
```
And Have patience it can take upto an hour or more depending upon your internet speed

## Put the Device Tree to Correct Location
Download this repository in .zip and then unzip it to `twrp/device/marmalade`
Remember to remove Readme.md as it may cause problems in some very niche cases

## Compile guide
Setup Build Environment from the twrp base folder where `.repo` folder is located
```
source build/envsetup.sh
```

For Lineage recovery
```
breakfast lineage_marmalade-eng
```
For TWRP recovery
```
breakfast twrp_marmalade-eng
```
For creating vendor_boot ramdisk for devices that use header v4
```
mka vendorbootimage
```

## Flashing method :
So, we'd be flashing the modular recovery ramdisk alone and it can be performed with the following command

### if boot header v4 and if target vendor_boot ramdisk uses gz compression
```
fastboot flash vendor_boot:recovery recovery.cpio.gz
```
### if boot header v4 and if target vendor_boot ramdisk uses lz4 compression
```
fastboot flash vendor_boot:recovery recovery.cpio.lz4
```

## References :
https://source.android.com/devices/bootloader/partitions/vendor-boot-partitions
https://source.android.com/devices/bootloader/fastbootd
