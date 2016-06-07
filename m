From: singu.b@gmail.com
Subject: Bug in hid sony driver while connecting two pieces of same hardware
Date: Tue, 7 Jun 2016 23:53:42 +0200
Message-ID: <CAJ05J9fFa26Y3ZyOOYaTMehTXp9+S55q7XoownaSOqtmX8Zetg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-it0-f46.google.com ([209.85.214.46]:37802 "EHLO
	mail-it0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932806AbcFGWBT (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 7 Jun 2016 18:01:19 -0400
Received: by mail-it0-f46.google.com with SMTP id z123so110860116itg.0
        for <linux-input@vger.kernel.org>; Tue, 07 Jun 2016 15:01:18 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

The patch [1] [2] was intended to prevent duplicate connection of one
piece of hardware via bluetooth and usb at the same time. But the code
is too restrictive and forbids the connection of two identical pieces
of hardware (Future Max Dance Mat) on different usb ports too. The
second device is fully setup and then dropped by the sony driver.

Below is my dmesg output from a current 4.4.0 kernel and from the last
working 3.14.56 from here [3]

dmesg output with kernel 4.4.0
[12125.194368] usb 2-1.2: new full-speed USB device number 3 using ehci-pci
[12125.290910] usb 2-1.2: New USB device found, idVendor=22ba, idProduct=0109
[12125.290917] usb 2-1.2: New USB device strings: Mfr=1, Product=2,
SerialNumber=0
[12125.290922] usb 2-1.2: Product: Generic USB Hub
[12125.290925] usb 2-1.2: Manufacturer: Rui Da
[12125.291508] hub 2-1.2:1.0: USB hub found
[12125.291768] hub 2-1.2:1.0: 3 ports detected
[12125.562392] usb 2-1.2.1: new full-speed USB device number 4 using ehci-pci
[12125.657451] usb 2-1.2.1: New USB device found, idVendor=054c, idProduct=0268
[12125.657458] usb 2-1.2.1: New USB device strings: Mfr=0, Product=2,
SerialNumber=0
[12125.657463] usb 2-1.2.1: Product: FutureMax Dance Mat
[12126.341649] hidraw: raw HID events driver (C) Jiri Kosina
[12126.348524] usbcore: registered new interface driver usbhid
[12126.348528] usbhid: USB HID core driver
[12126.360569] input: FutureMax Dance Mat as
/devices/pci0000:00/0000:00:1d.0/usb2/2-1/2-1.2/2-1.2.1/2-1.2.1:1.0/0003:054C:0268.0001/input/input16
[12126.416043] sony 0003:054C:0268.0001: input,hiddev0,hidraw0: USB
HID v1.11 Joystick [FutureMax Dance Mat] on
usb-0000:00:1d.0-1.2.1/input0
[12138.967099] usb 2-1.5: new full-speed USB device number 5 using ehci-pci
[12139.063843] usb 2-1.5: New USB device found, idVendor=22ba, idProduct=0109
[12139.063851] usb 2-1.5: New USB device strings: Mfr=1, Product=2,
SerialNumber=0
[12139.063855] usb 2-1.5: Product: Generic USB Hub
[12139.063859] usb 2-1.5: Manufacturer: Rui Da
[12139.064433] hub 2-1.5:1.0: USB hub found
[12139.064686] hub 2-1.5:1.0: 3 ports detected
[12139.335121] usb 2-1.5.1: new full-speed USB device number 6 using ehci-pci
[12139.430400] usb 2-1.5.1: New USB device found, idVendor=054c, idProduct=0268
[12139.430407] usb 2-1.5.1: New USB device strings: Mfr=0, Product=2,
SerialNumber=0
[12139.430412] usb 2-1.5.1: Product: FutureMax Dance Mat
[12139.434055] input: FutureMax Dance Mat as
/devices/pci0000:00/0000:00:1d.0/usb2/2-1/2-1.5/2-1.5.1/2-1.5.1:1.0/0003:054C:0268.0002/input/input17
[12139.434496] sony 0003:054C:0268.0002: input,hiddev0,hidraw1: USB
HID v1.11 Joystick [FutureMax Dance Mat] on
usb-0000:00:1d.0-1.5.1/input0
[12139.437030] sony 0003:054C:0268.0002: controller with MAC address
00:1b:fb:00:00:00 already connected
[12139.519506] sony: probe of 0003:054C:0268.0002 failed with error -17

dmesg output with kernel 3.14.56
[  196.032269] usb 2-1.1: new full-speed USB device number 3 using ehci-pci
[  196.129199] usb 2-1.1: New USB device found, idVendor=22ba, idProduct=0109
[  196.129205] usb 2-1.1: New USB device strings: Mfr=1, Product=2,
SerialNumber=0
[  196.129209] usb 2-1.1: Product: Generic USB Hub
[  196.129214] usb 2-1.1: Manufacturer: Rui Da
[  196.130461] hub 2-1.1:1.0: USB hub found
[  196.131299] hub 2-1.1:1.0: 3 ports detected
[  196.404621] usb 2-1.1.1: new full-speed USB device number 4 using ehci-pci
[  196.499645] usb 2-1.1.1: New USB device found, idVendor=054c, idProduct=0268
[  196.499652] usb 2-1.1.1: New USB device strings: Mfr=0, Product=2,
SerialNumber=0
[  196.499656] usb 2-1.1.1: Product: FutureMax Dance Mat
[  197.179980] hidraw: raw HID events driver (C) Jiri Kosina
[  197.185726] usbcore: registered new interface driver usbhid
[  197.185732] usbhid: USB HID core driver
[  197.197779] input: FutureMax Dance Mat as
/devices/pci0000:00/0000:00:1d.0/usb2/2-1/2-1.1/2-1.1.1/2-1.1.1:1.0/0003:054C:0268.0001/input/input16
[  197.198194] sony 0003:054C:0268.0001: input,hiddev0,hidraw0: USB
HID v1.11 Joystick [FutureMax Dance Mat] on
usb-0000:00:1d.0-1.1.1/input0
[  231.062851] usb 2-1.2: new full-speed USB device number 5 using ehci-pci
[  231.160153] usb 2-1.2: New USB device found, idVendor=22ba, idProduct=0109
[  231.160159] usb 2-1.2: New USB device strings: Mfr=1, Product=2,
SerialNumber=0
[  231.160163] usb 2-1.2: Product: Generic USB Hub
[  231.160167] usb 2-1.2: Manufacturer: Rui Da
[  231.160782] hub 2-1.2:1.0: USB hub found
[  231.161087] hub 2-1.2:1.0: 3 ports detected
[  231.431179] usb 2-1.2.1: new full-speed USB device number 6 using ehci-pci
[  231.526072] usb 2-1.2.1: New USB device found, idVendor=054c, idProduct=0268
[  231.526078] usb 2-1.2.1: New USB device strings: Mfr=0, Product=2,
SerialNumber=0
[  231.526083] usb 2-1.2.1: Product: FutureMax Dance Mat
[  231.528057] input: FutureMax Dance Mat as
/devices/pci0000:00/0000:00:1d.0/usb2/2-1/2-1.2/2-1.2.1/2-1.2.1:1.0/0003:054C:0268.0002/input/input17
[  231.528452] sony 0003:054C:0268.0002: input,hiddev0,hidraw1: USB
HID v1.11 Joystick [FutureMax Dance Mat] on
usb-0000:00:1d.0-1.2.1/input0


Please send answers and requests also directly to me: singu.b@gmail.com

[1] https://www.spinics.net/lists/linux-input/msg29895.html
[2] https://github.com/torvalds/linux/commit/d2d782fccee4f699a35e2d0cdbb2b19bdaec95a4
[3] http://kernel.ubuntu.com/~kernel-ppa/mainline/v3.14.56-utopic/
