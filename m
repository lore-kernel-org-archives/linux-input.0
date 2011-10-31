From: Alon Bar-Lev <alon.barlev@gmail.com>
Subject: Sony DualShock3 - Detected but no events
Date: Tue, 1 Nov 2011 01:04:37 +0200
Message-ID: <CAOazyz0GNJKFWNsaFiwheMjhBVJrcP-p8QBcsSvS3V97iuZFtQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:46214 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934704Ab1JaXEi (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 31 Oct 2011 19:04:38 -0400
Received: by qabj40 with SMTP id j40so5424245qab.19
        for <linux-input@vger.kernel.org>; Mon, 31 Oct 2011 16:04:37 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Hello,

I feel uncomfortable, as people reports that it does work...
Bluetooth pairing is not working and almost no documentation of
bluez-4 success....
So I thought starting in USB will be easier....

I am using linux-3.1.0
When doing cat /dev/input/js0 or cat /dev/input/event15 or usbhid-dump
I get no activity.

Can anyone please help? or acknowledge that it actually work?
Can I provide more information?
Thanks,
Alon.

lsusb
---
Bus 006 Device 002: ID 054c:0268 Sony Corp. Batoh Device / PlayStation
3 Controller
---

When plugged, I get:
---
usb 6-1: new full speed USB device number 2 using uhci_hcd
sony 0003:054C:0268.000A: Fixing up Sony Sixaxis report descriptor
input: Gasia Co.,Ltd PS(R) Gamepad as
/devices/pci0000:00/0000:00:1d.0/usb6/6-1/6-1:1.0/input/input23
sony 0003:054C:0268.000A: input: USB HID v1.11 Joystick [Gasia Co.,Ltd
PS(R) Gamepad] on usb-0000:00:1d.0-1/input0
---

/proc/bus/input/devices
---
I: Bus=0003 Vendor=054c Product=0268 Version=0111
N: Name="Gasia Co.,Ltd PS(R) Gamepad"
P: Phys=usb-0000:00:1d.0-1/input0
S: Sysfs=/devices/pci0000:00/0000:00:1d.0/usb6/6-1/6-1:1.0/input/input23
U: Uniq=
H: Handlers=event15 js0
B: PROP=0
B: EV=1b
B: KEY=70000 0 0 0 0 0 0 ffff00000000 0 0 0 0
B: ABS=7fffff0000000027
B: MSC=10
---

# usbhid-dump -f --entity="both" 6 2
---
000:DESCRIPTOR                 1320102071.430309
 05 01 09 04 A1 01 A1 02 85 01 75 08 95 01 15 00
 26 FF 00 81 03 75 01 95 13 15 00 25 01 35 00 45
 01 05 09 19 01 29 13 81 02 75 01 95 0D 06 00 FF
 81 03 15 00 26 FF 00 05 01 09 01 A1 00 75 08 95
 04 35 00 46 FF 00 09 30 09 31 09 32 09 35 81 02
 C0 05 01 75 08 95 27 09 01 81 02 75 08 95 30 09
 01 91 02 75 08 95 30 09 01 B1 02 C0 A1 02 85 02
 75 08 95 30 09 01 B1 02 C0 A1 02 85 EE 75 08 95
 30 09 01 B1 02 C0 A1 02 85 EF 75 08 95 30 09 01
 B1 02 C0 C0
---
