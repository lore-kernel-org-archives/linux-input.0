From: jono <lejono@gmail.com>
Subject: keyboard not working with Thinkpad Helix (2nd gen) (also stylus)
Date: Sun, 26 Apr 2015 19:16:37 +0100
Message-ID: <CAJXMp+qGdtEh59U33FKx+7CSyKbARRbAs30u8=fFR1c492eK4A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ob0-f179.google.com ([209.85.214.179]:35584 "EHLO
	mail-ob0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750779AbbDZSQi (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 26 Apr 2015 14:16:38 -0400
Received: by obcux3 with SMTP id ux3so69123560obc.2
        for <linux-input@vger.kernel.org>; Sun, 26 Apr 2015 11:16:38 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

The keyboard that this machine comes works fine under grub and windows
but not linux.  The keyboard is a Lenovo Thinkpad Helix Ultrabook Pro
which also has a touchpad, extra battery, usb port etc. The touchpad,
battery, ports are all detected, but the keyboard doesn't work. A usb
and bluetooth keyboard work fine.

I currently have kernel 4.0.0- 040000- generic. It has been reported
in a number of other forums, e.g.

https:/ /bugs.launchpad .net/ubuntu/ +source/ xorg/+bug/ 1437051
https://forums.lenovo.com/t5/Linux-Discussion/ThinkPad-Helix-keyboard-not-detected-in-Linux/td-p/2051477

which all contain useful information and log files. I'm currently
running on a fresh install of Ubuntu 15.04 with their "upstream
kernel", but the problem exists in previous Ubuntu and kernel
versions.

"cat /proc/bus/input/devices" lists:

I: Bus=0011 Vendor=0001 Product=0001 Version=ab54
N: Name="AT Translated Set 2 keyboard"
P: Phys=isa0060/serio0/input0
S: Sysfs=/devices/platform/i8042/serio0/input/input3
U: Uniq=
H: Handlers=sysrq kbd event3
B: PROP=0
B: EV=120013
B: KEY=402000000 3803078f800d001 feffffdfffefffff fffffffffffffffe
B: MSC=10
B: LED=7

which appears to be it, The Xorg log lists

[     4.815] (II) config/udev: Adding input device AT Translated Set 2
keyboard (/dev/input/event3)
[     4.815] (**) AT Translated Set 2 keyboard: Applying InputClass
"evdev keyboard catchall"
[     4.815] (II) Using input driver 'evdev' for 'AT Translated Set 2 keyboard'
[     4.815] (**) AT Translated Set 2 keyboard: always reports core events
[     4.815] (**) evdev: AT Translated Set 2 keyboard: Device:
"/dev/input/event3"
[     4.815] (--) evdev: AT Translated Set 2 keyboard: Vendor 0x1 Product 0x1
[     4.815] (--) evdev: AT Translated Set 2 keyboard: Found keys
[     4.815] (II) evdev: AT Translated Set 2 keyboard: Configuring as keyboard
[     4.815] (**) Option "config_info"
"udev:/sys/devices/platform/i8042/serio0/input/input3/event3"
[     4.815] (II) XINPUT: Adding extended input device "AT Translated
Set 2 keyboard" (type: KEYBOARD, id 14)
[     4.815] (**) Option "xkb_rules" "evdev"
[     4.815] (**) Option "xkb_model" "pc105"
[     4.815] (**) Option "xkb_layout" "us"



As an aside, the stylus is properly not recognized in this kernel, but
works fine in previous kernels with "cat /proc/bus/input/devices"
listing

I: Bus=0018 Vendor=056a Product=0114 Version=0100
N: Name="WCOM0009:00 056A:0114"
P: Phys=
S: Sysfs=/devices/pci0000:00/INT3433:00/i2c-8/i2c-WCOM0009:00/0018:056A:0114.0004/input/input9
U: Uniq=
H: Handlers=mouse2 event8
B: PROP=0
B: EV=1f
B: KEY=c03 30001 0 0 0 0
B: REL=3
B: ABS=1000003
B: MSC=10

in kernel 3.12 for example, but the device is not listed in 3.16 or
later (although possibly it is detected in earlier kernels).

Happy to help test.
Best,
Jonathan
