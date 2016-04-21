From: rootsr <shadowcat.arya@gmail.com>
Subject: Microsoft wireless usb mouse frequently fails to detect in ubuntu
 15.10/16.04
Date: Thu, 21 Apr 2016 10:23:01 +0530
Message-ID: <20160421045301.GC7267@grey>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:33464 "EHLO
	mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751172AbcDUExI (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 21 Apr 2016 00:53:08 -0400
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-usb@vger.kernel.org, linux-input@vger.kernel.org, kernelnewbies@kernelnewbies.org

Hello all,

I am using ubuntu 16.04 (upgraded yesterday from 15.10) on Dell inspiro=
n 15 3000 series (core i7). While using Microsoft wireless mouse, it fa=
ils to detect most of the time. The issue is not there when I use the s=
ame mouse in Windows / other linux distro / TV / PS4 etc.
Here is the Kernel log for the failure.=20
----------------------------------------------------
[   74.186391] usb 1-1.3: new full-speed USB device number 7 using ehci=
-pci
[   74.258396] usb 1-1.3: device descriptor read/64, error -32
[   74.434356] usb 1-1.3: device descriptor read/64, error -32
[   74.610315] usb 1-1.3: new full-speed USB device number 8 using ehci=
-pci
[   74.682322] usb 1-1.3: device descriptor read/64, error -32
[   74.858322] usb 1-1.3: device descriptor read/64, error -32
[   75.034320] usb 1-1.3: new full-speed USB device number 9 using ehci=
-pci
[   75.446330] usb 1-1.3: device not accepting address 9, error -32
[   75.518334] usb 1-1.3: new full-speed USB device number 10 using ehc=
i-pci
[   75.926331] usb 1-1.3: device not accepting address 10, error -32
[   75.926400] usb 1-1-port3: unable to enumerate USB device
[   93.835769] usb 1-1.3: new full-speed USB device number 11 using ehc=
i-pci
[   93.908028] usb 1-1.3: device descriptor read/64, error -32
[   94.084569] usb 1-1.3: device descriptor read/64, error -32
[   94.261110] usb 1-1.3: new full-speed USB device number 12 using ehc=
i-pci
[   94.333337] usb 1-1.3: device descriptor read/64, error -32
[   94.509893] usb 1-1.3: device descriptor read/64, error -32
[   94.686342] usb 1-1.3: new full-speed USB device number 13 using ehc=
i-pci
[   95.095548] usb 1-1.3: device not accepting address 13, error -32
[   95.167686] usb 1-1.3: new full-speed USB device number 14 using ehc=
i-pci
[   95.576740] usb 1-1.3: device not accepting address 14, error -32
[   95.576848] usb 1-1-port3: unable to enumerate USB device
-----------------------------------------------------------------

After multiple connect/disconnect of the wireless dongle, it finally de=
tects. Here is the detection log.
------------------------------------------------------
[  110.221269] usb 1-1.3: new full-speed USB device number 15 using ehc=
i-pci
[  110.319427] usb 1-1.3: New USB device found, idVendor=3D045e, idProd=
uct=3D0745
[  110.319431] usb 1-1.3: New USB device strings: Mfr=3D1, Product=3D2,=
 SerialNumber=3D0
[  110.319433] usb 1-1.3: Product: Microsoft=AE 2.4GHz Transceiver v8.0
[  110.319435] usb 1-1.3: Manufacturer: Microsoft
[  110.361146] usbcore: registered new interface driver usbhid
[  110.361151] usbhid: USB HID core driver
[  110.380274] input: Microsoft Microsoft=AE 2.4GHz Transceiver v8.0 as=
 /devices/pci0000:00/0000:00:1d.0/usb1/1-1/1-1.3/1-1.3:1.0/0003:045E:07=
45.0002/input/input14
[  110.433886] hid-generic 0003:045E:0745.0002: input,hidraw1: USB HID =
v1.11 Keyboard [Microsoft Microsoft=AE 2.4GHz Transceiver v8.0] on usb-=
0000:00:1d.0-1.3/input0
[  110.434274] input: Microsoft Microsoft=AE 2.4GHz Transceiver v8.0 as=
 /devices/pci0000:00/0000:00:1d.0/usb1/1-1/1-1.3/1-1.3:1.1/0003:045E:07=
45.0003/input/input15
[  110.489634] hid-generic 0003:045E:0745.0003: input,hidraw2: USB HID =
v1.11 Mouse [Microsoft Microsoft=AE 2.4GHz Transceiver v8.0] on usb-000=
0:00:1d.0-1.3/input1
[  110.500335] input: Microsoft Microsoft=AE 2.4GHz Transceiver v8.0 as=
 /devices/pci0000:00/0000:00:1d.0/usb1/1-1/1-1.3/1-1.3:1.2/0003:045E:07=
45.0004/input/input16
[  110.553640] hid-generic 0003:045E:0745.0004: input,hiddev0,hidraw3: =
USB HID v1.11 Device [Microsoft Microsoft=AE 2.4GHz Transceiver v8.0] o=
n usb-0000:00:1d.0-1.3/input2
-------------------------------------------------------------

I am not sure of this weird behaviour. Is there some issue with ubuntu =
kernel for input device? or is there a problem with microsoft mouse dri=
ver?


regards
 -Shekhar
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
