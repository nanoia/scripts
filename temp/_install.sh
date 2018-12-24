#!/bin/sh

mkdir -p /ddbr
chmod 777 /ddbr

VER=`uname -r`

IMAGE_KERNEL="/boot/zImage"
IMAGE_INITRD="/boot/initrd.img-$VER"
PART_ROOT="/dev/data"
DIR_INSTALL="/ddbr/install"
IMAGE_DTB="/boot/dtb.img"


if [ ! -f $IMAGE_KERNEL ] ; then
    echo "Not KERNEL.  STOP install !!!"
    return
fi

if [ ! -f $IMAGE_INITRD ] ; then
    echo "Not INITRD.  STOP install !!!"
    return
fi

#edit by achaoge, 
#disable 64bit and metadata_csum features for uboot compatibility
#ref: https://kshadeslayer.wordpress.com/2016/04/11/my-filesystem-has-too-many-bits/
e2fsck -f $PART_ROOT
/sbin/resize2fs -s /dev/data
/sbin/tune2fs -O ^metadata_csum /dev/data

if [ -d $DIR_INSTALL ] ; then
    rm -rf $DIR_INSTALL
fi

mkdir -p $DIR_INSTALL
mount -o rw $PART_ROOT $DIR_INSTALL


#add by achaoge 2018-06-22
export $(/usr/sbin/fw_printenv mac)
echo "Modify files for N1 emmc boot"
/bin/sed -e "/usb [23]/d" -e 's/fatload mmc 0 \([^ ]*\) \([^;]*\)/ext4load mmc 1:c \1 \/boot\/\2/g' -i $DIR_INSTALL/boot/s905_autoscript.cmd
/bin/sed -e 's/LABEL=ROOTFS/\/dev\/data/' -e "s/mac=.*/mac=${mac}/" -i $DIR_INSTALL/boot/uEnv.ini
/usr/bin/mkimage -C none -A arm -T script -d $DIR_INSTALL/boot/s905_autoscript.cmd $DIR_INSTALL/boot/s905_autoscript
/bin/umount $DIR_INSTALL
echo "Emmc boot fixed end"

echo "Write env bootargs"
#Edit by achaoge 2018-06-22, for Phicomm N1 boot from emmc
/usr/sbin/fw_setenv start_autoscript "if usb start ; then run start_usb_autoscript; fi; if ext4load mmc 1:c 1020000 /boot/s905_autoscript; then autoscr 1020000; fi;"


echo "*******************************************"
echo "Complete emmc boot fix"
echo "*******************************************"
