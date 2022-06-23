# Generic recovery device tree for device that use boot header v3/v4
Device that use boot header version v4 supports modular ramdisks, hence we are able to flash vendor_boot:$(ramdisk_name_that's_not_default) without touching OEM specific blobs like that of fstab or kernel modules. The goal is to support all methods of stock ROM asssertion and simulate the same methods that their OEM uses for the purpose of custom rom.


## Compile guide
For Lineage recovery
```
breakfast lineage_marmalade-eng
```
For TWRP recovery
```
breakfast twrp_marmalade-eng
```
For creating boot ramdisk for devices that use header v3
```
mka bootimage
```
For creating vendor_boot ramdisk for devices that use header v4
```
mka vendorbootimage
```

## Flashing method :
So, we'd be flashing the modular recovery ramdisk alone and it can be performed with the following command

### if boot header v3
```
fastboot flash boot:boot boot.cpio.lz4
```
### if boot header v4 and if target vendor_boot ramdisk uses gz compression
```
fastboot flash vendor_boot:recovery recovery.cpio.gz
```
### if boot header v4 and if target vendor_boot ramdisk uses lz4 compression
```
fastboot flash vendor_boot:recovery recovery.cpio.lz4
```

# OEM specific instructions when compiling custom ROM to add TWRP support
For oplus devices, refer https://github.com/pjgowtham/android_device_oplus_RMX3360/commit/4cab12da4c641be5757e1f56fac56a136cbf0bb5

## References :
https://source.android.com/devices/bootloader/partitions/vendor-boot-partitions
https://source.android.com/devices/bootloader/fastbootd
