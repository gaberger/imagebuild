#!/bin/bash
set -x

echo "update-iso.sh <source iso> <dest iso>"
isofile=$1
newiso=$2

rm -rf /vagrant/tmp/linux

mkdir -p /mnt/linux
mkdir -p /vagrant/tmp/linux

mount -o loop ${isofile} /mnt/linux
cp -r /mnt/linux/* /vagrant/tmp/linux
umount /mnt/linux && rmdir /mnt/linux
chmod -R u+w /vagrant/tmp/linux
cp *.cfg /vagrant/tmp/linux/isolinux

# sed -i 's/append initrd\=initrd.img$/append initrd=initrd.img ks\=cdrom:\/ks.cfg/' /vagrant/tmp/linux/isolinux/isolinux.cfg
mkisofs -r -T -J -V "RHEL-7.3 Server.x86_64" -b isolinux/isolinux.bin -c isolinux/boot.cat -no-emul-boot -boot-load-size 4 -boot-info-table -o linuxboot.iso /vagrant/tmp/linux
implantisomd5 --force linuxboot.iso