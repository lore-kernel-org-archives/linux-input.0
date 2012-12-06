From: Alberto Mattea <alberto@mattea.info>
Subject: Zowie Celeritas modifier keys not working in usb mode
Date: Thu, 06 Dec 2012 19:50:41 +0100
Message-ID: <2486236.OclY5vx5UC@alby>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from fep-mail-smtpout-l1e.virgilio.net ([212.48.21.145]:48984 "EHLO
	fep-mail-smtpout-l1e.virgilio.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752695Ab2LFTBX (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 6 Dec 2012 14:01:23 -0500
Received: from mattea.info (79.44.155.95) by fep-mail-smtpout-l1e.virgilio.net (8.6.031.01)
        id 507FD90E01A224AE for linux-input@vger.kernel.org; Thu, 6 Dec 2012 19:50:42 +0100
Received: from alby.localnet (unknown [192.168.0.35])
	by mattea.info (Postfix) with ESMTPS id DA0292CE0C5
	for <linux-input@vger.kernel.org>; Thu,  6 Dec 2012 19:50:41 +0100 (CET)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Hello,

this problem was first described in detail at
https://bugs.archlinux.org/task/24505. Basically it seems the usbhid driver is
not sending SYN events; with PS/2 everything is fine. Although what follows is
with Arch Linux, I reproduced exactly the same problem with Ubuntu, with 
kernel 3.6.2.

Quote from the link above:

Some keys do not work on the Zowie Celeritas Keyboard :
- LEFT SHIFT
- RIGHT SHIFT
- LEFT CTRL
- LEFT META
- LEFT ALT
- RIGHT ALT
- RIGHT CTRL

The keys do not work under ArchLinux, but work as expected under Windows
(Seven).

The keys do not work, NO MATTER if X is launched or not.


KEYMAP OUTPUT
-------------
# /lib/udev/keymap -i input/event19
Press ESC to finish, or Control-C if this device is not your primary keyboard
driver did not send SYN event in between key events; previous event:
scan code: 0x700E1 key code: leftshift

Note: each non working key returns the same "SYN" message


UDEVADM OUTPUT
--------------
UDEV_LOG=0
DEVPATH=/devices/pci0000:00/0000:00:1d.0/usb6/6-1/6-1:1.0/input/input19/event19
MAJOR=13
MINOR=83
DEVNAME=/dev/input/event19
SUBSYSTEM=input
ID_INPUT=1
ID_INPUT_KEY=1
ID_INPUT_KEYBOARD=1
ID_VENDOR=Zowie
ID_VENDOR_ENC=Zowie
ID_VENDOR_ID=2345
ID_MODEL=Zowie
ID_MODEL_ENC=Zowie
ID_MODEL_ID=0101
ID_REVISION=0001
ID_SERIAL=Zowie_Zowie
ID_TYPE=hid
ID_BUS=usb
ID_USB_INTERFACES=:030101:030000:
ID_USB_INTERFACE_NUM=00
ID_USB_DRIVER=usbhid
ID_PATH=pci-0000:00:1d.0-usb-0:1:1.0
DEVLINKS=/dev/input/by-id/usb-Zowie_Zowie-event-kbd
/dev/input/by-path/pci-0000:00:1d.0-usb-0:1:1.0-event-kbd


LSUSB OUTPUT
------------
Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
Bus 002 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
Bus 003 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub
Bus 004 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub
Bus 005 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub
Bus 006 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub
Bus 007 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub
Bus 008 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub
Bus 001 Device 004: ID 04b3:4485 IBM Corp. Serial Converter
Bus 003 Device 002: ID 046d:c526 Logitech, Inc. Nano Receiver
Bus 004 Device 002: ID 0a5c:2145 Broadcom Corp. Bluetooth with Enhanced Data
Rate II
Bus 001 Device 005: ID 046d:c512 Logitech, Inc. LX-700 Cordless Desktop
Receiver
Bus 001 Device 006: ID 1bcf:0c31 Sunplus Innovation Technology Inc.
Bus 006 Device 002: ID 2345:0101


XORG LOGs:
----------
[ 2032.140] (II) Loading /usr/lib/xorg/modules/input/evdev_drv.so
[ 2032.140] (**) Zowie Zowie: always reports core events
[ 2032.140] (**) Zowie Zowie: Device: "/dev/input/event19"
[ 2032.149] (--) Zowie Zowie: Found keys
[ 2032.149] (II) Zowie Zowie: Configuring as keyboard
[ 2032.149] (**) Option "config_info"
"udev:/sys/devices/pci0000:00/0000:00:1d.0/usb6/6-1/6-1:1.0/input/input19/event19"
[ 2032.149] (II) XINPUT: Adding extended input device "Zowie Zowie" (type:
KEYBOARD)
[ 2032.149] (**) Option "xkb_rules" "evdev"
[ 2032.149] (**) Option "xkb_model" "evdev"
[ 2032.149] (**) Option "xkb_layout" "fr"
