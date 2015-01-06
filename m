From: vichy <vichy.kuo@gmail.com>
Subject: no response when capture hid events
Date: Tue, 6 Jan 2015 13:48:13 +0800
Message-ID: <CAOVJa8Ga0V4avvRfK+YTnvJ1t=dxxzrisjpDCh1d60qzGG=49w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ob0-f178.google.com ([209.85.214.178]:58430 "EHLO
	mail-ob0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751316AbbAFFsN (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 6 Jan 2015 00:48:13 -0500
Received: by mail-ob0-f178.google.com with SMTP id gq1so64324777obb.9
        for <linux-input@vger.kernel.org>; Mon, 05 Jan 2015 21:48:13 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

hi all:
I try to cat hid events through debugfs but in vain.
My environment is:
1. kernel 3.10.30
2. insert below kos
usbhid
hid_generic
hid
evdev
usb_storage
ehci_hcd
xhci_hcd
usbcore
usb_common

3. mount debugfs as below
#mount
rootfs on / type rootfs (rw)
/dev/root on / type squashfs (ro,relatime)
devtmpfs on /dev type devtmpfs
(rw,relatime,size=533324k,used_memory=0k,nr_inodes=96679,mode=755)
proc on /proc type proc (rw,relatime)
sysfs on /sys type sysfs (rw,relatime)
tmpfs on /dtv type tmpfs (rw,relatime,size=40960k,used_memory=0k)
tmpfs on /tmp type tmpfs (rw,relatime,size=40960k,used_memory=0k)
tmpfs on /freesia type tmpfs (rw,relatime,size=4096k,used_memory=0k)
tmpfs on /core type tmpfs (rw,relatime,size=51200k,used_memory=0k)
none on /sys/fs/cgroup type cgroup (rw,relatime,cpu)
none on /sys/kernel/debug type debugfs (rw,relatime,mode=777)
#

4. then I plug in mouse   and cat events but get nothing.
did I miss any steps to do so?
appreciate your kind help in advance,

[0-367.5207] usb 6-1: New USB device found, idVendor=0461, idProduct=4e2a
[0-367.5272] usb 6-1: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[0-367.5342] usb 6-1: Product: USB Optical Mouse
[0-367.5386] usb 6-1: Manufacturer: PixArt
[1-367.5520] input: PixArt USB Optical Mouse as
/devices/fc1a0000.ehci/usb6/6-1/6-1:1.0/input/input2
[3-367.5625] hid-generic 0003:0461:4E2A.0003: input: USB HID v1.11
Mouse [PixArt USB Optical Mouse] on usb-NT72668-1/input0
#>
#>
#> cat /sys/kernel/debug/hid/0003\:0461\:4E2A.0003/events
