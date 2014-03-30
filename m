From: "jpp@jppozzi.dyndns.org" <jpp@jppozzi.dyndns.org>
Subject: Bug 72911 - switch "kvm" not detected/not working
Date: Mon, 31 Mar 2014 01:39:16 +0200
Message-ID: <1396222756.13781.4.camel@k2000>
Reply-To: jp.pozzi@izzop.net
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from delay-3y.bbox.fr ([194.158.98.73]:35931 "EHLO delay-3y.bbox.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754214AbaC3Xuu (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sun, 30 Mar 2014 19:50:50 -0400
Received: from mail-2y.bbox.fr (bt8sssoo.cs.dolmen.bouyguestelecom.fr [172.24.208.129])
	by delay-3y.bbox.fr (Postfix) with ESMTP id 1526D8E424
	for <linux-input@vger.kernel.org>; Mon, 31 Mar 2014 01:41:50 +0200 (CEST)
Received: from filtre.jpp.fr (89-93-161-78.hfc.dyn.abo.bbox.fr [89.93.161.78])
	by mail-2y.bbox.fr (Postfix) with ESMTP id 9C17F49
	for <linux-input@vger.kernel.org>; Mon, 31 Mar 2014 01:39:19 +0200 (CEST)
Received: from localhost (filtre1.jpp1.fr [192.168.1.2])
	by filtre.jpp.fr (Postfix) with ESMTP id 2C8312215ED
	for <linux-input@vger.kernel.org>; Mon, 31 Mar 2014 01:39:19 +0200 (CEST)
Received: from filtre.jpp.fr ([192.168.1.2])
	by localhost (filtre.jpp.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5awxt0AO575B for <linux-input@vger.kernel.org>;
	Mon, 31 Mar 2014 01:39:18 +0200 (CEST)
Received: from [192.168.2.8] (k2000.jpp.fr [192.168.2.8])
	by filtre.jpp.fr (Postfix) with ESMTPSA id 6D2D42215EC
	for <linux-input@vger.kernel.org>; Mon, 31 Mar 2014 01:39:18 +0200 (CEST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Hello,

I submit a bug on bugzilla.kernel.org and Greg Kroah-Hartman suggest to
send it to that mailbox.
The bug was registered as #72911 with the .config file ed.

I paste the details here :
================================================================================
Hello,

I am using a KVM switch between 3 machines, on 2 "old" machines all is
OK, mouse and keyboard are detected, on the "new" machine nothing is
detected. The keyboard is working but the mouse is KO.

I try to make some traces with dmesg concerning the usb port connected
to the KVM switch. I made the traces on 3 systems, the 2 which are
working, the 1 which is KO.

All machines were running 3.14.0-rc7 during the tests.

1) Machines where the KVM is working :
1.1) AMD 905e	16GB
DMI: MICRO-STAR INTERNATIONAL CO.,LTD MS-7577/790FX-GD70(MS-7577), BIOS
V1.17 02/18/2011

Output of "dmesg | grep usb | grep 3-1"

[    3.740906] usb 3-1: new low-speed USB device number 2 using ohci-pci
[    3.935144] usb 3-1: New USB device found, idVendor=10d5,
idProduct=5000
[    3.935442] usb 3-1: New USB device strings: Mfr=1, Product=2,
SerialNumber=0
[    3.935726] usb 3-1: Product: Combo Free KVM
[    3.936013] usb 3-1: Manufacturer: No brand
[    3.958344] usbcore: registered new interface driver usbhid
[    3.958636] usbhid: USB HID core driver
[    3.960367] input: No brand Combo Free KVM
as /devices/pci0000:00/0000:00:12.0/usb3/3-1/3-1:1.0/0003:10D5:5000.0001/input/input2
[    3.960744] hid-generic 0003:10D5:5000.0001: input,hidraw0: USB HID
v1.10 Keyboard [No brand Combo Free KVM] on usb-0000:00:12.0-1/input0
[    3.961316] input: No brand Combo Free KVM
as /devices/pci0000:00/0000:00:12.0/usb3/3-1/3-1:1.1/0003:10D5:5000.0002/input/input3
[    3.961688] hid-generic 0003:10D5:5000.0002: input,hidraw1: USB HID
v1.10 Mouse [No brand Combo Free KVM] on usb-0000:00:12.0-1/input1

Mouse and Keyboard are OK.

1.2) INTEL CoreI3 3130  8Gb
DMI: System manufacturer System Product Name/P8H77-I, BIOS 0809
08/01/2012

Output is 
[    4.106241] usblp 1-1.4:1.0: usblp0: USB Bidirectional printer dev 4
if 0 alt 0 proto 2 vid 0x04A9 pid 0x10CF
[    4.106274] usbcore: registered new interface driver usblp
[    4.125872] usbcore: registered new interface driver usbhid
[    4.125875] usbhid: USB HID core driver
[    4.137615] input: No brand Combo Free KVM
as /devices/pci0000:00/0000:00:1a.0/usb1/1-1/1-1.2/1-1.2:1.0/0003:10D5:5000.0001/input/input7
[    4.137766] hid-generic 0003:10D5:5000.0001: input,hidraw0: USB HID
v1.10 Keyboard [No brand Combo Free KVM] on usb-0000:00:1a.0-1.2/input0
[    4.138008] input: No brand Combo Free KVM
as /devices/pci0000:00/0000:00:1a.0/usb1/1-1/1-1.2/1-1.2:1.1/0003:10D5:5000.0002/input/input8
[    4.138134] hid-generic 0003:10D5:5000.0002: input,hidraw1: USB HID
v1.10 Mouse [No brand Combo Free KVM] on usb-0000:00:1a.0-1.2/input1

Mouse and Keyboard are OK.

2) Machine where the KVM is not recognized.
INTEL CoreI3 3130  8Gb
DMI: MSI MS-7851/B85I (MS-7851), BIOS V3.2 10/03/2013

Output of "dmesg | grep usb"

[    0.711224] usbcore: registered new interface driver usbfs
[    0.711235] usbcore: registered new interface driver hub
[    0.729923] usbcore: registered new device driver usb
[    0.747389] usb usb1: New USB device found, idVendor=1d6b,
idProduct=0002
[    0.747390] usb usb1: New USB device strings: Mfr=3, Product=2,
SerialNumber=1
[    0.747391] usb usb1: Product: EHCI Host Controller
[    0.747392] usb usb1: Manufacturer: Linux 3.14.0-rc7 ehci_hcd
[    0.747393] usb usb1: SerialNumber: 0000:00:1a.0
[    0.763400] usb usb2: New USB device found, idVendor=1d6b,
idProduct=0002
[    0.763402] usb usb2: New USB device strings: Mfr=3, Product=2,
SerialNumber=1
[    0.763403] usb usb2: Product: EHCI Host Controller
[    0.763404] usb usb2: Manufacturer: Linux 3.14.0-rc7 ehci_hcd
[    0.763404] usb usb2: SerialNumber: 0000:00:1d.0
[    0.763801] usb usb3: New USB device found, idVendor=1d6b,
idProduct=0002
[    0.763803] usb usb3: New USB device strings: Mfr=3, Product=2,
SerialNumber=1
[    0.763805] usb usb3: Product: xHCI Host Controller
[    0.763806] usb usb3: Manufacturer: Linux 3.14.0-rc7 xhci_hcd
[    0.763808] usb usb3: SerialNumber: 0000:00:14.0
[    0.766023] usb usb4: New USB device found, idVendor=1d6b,
idProduct=0003
[    0.766024] usb usb4: New USB device strings: Mfr=3, Product=2,
SerialNumber=1
[    0.766025] usb usb4: Product: xHCI Host Controller
[    0.766026] usb usb4: Manufacturer: Linux 3.14.0-rc7 xhci_hcd
[    0.766027] usb usb4: SerialNumber: 0000:00:14.0
[    1.059289] usb 1-1: new high-speed USB device number 2 using
ehci-pci
[    1.191442] usb 1-1: New USB device found, idVendor=8087,
idProduct=8008
[    1.191451] usb 1-1: New USB device strings: Mfr=0, Product=0,
SerialNumber=0
[    1.303108] usb 2-1: new high-speed USB device number 2 using
ehci-pci
[    1.439456] usb 2-1: New USB device found, idVendor=8087,
idProduct=8000
[    1.439463] usb 2-1: New USB device strings: Mfr=0, Product=0,
SerialNumber=0
[    1.606950] usb 3-6: new low-speed USB device number 2 using xhci_hcd
[    3.598720] usb 3-6: New USB device found, idVendor=0463,
idProduct=ffff
[    3.598728] usb 3-6: New USB device strings: Mfr=1, Product=2,
SerialNumber=4
[    3.598733] usb 3-6: Product: Ellipse ECO
[    3.598736] usb 3-6: Manufacturer: EATON
[    3.598740] usb 3-6: SerialNumber: 000000000
[    3.598968] usb 3-6: ep 0x81 - rounding interval to 128 microframes,
ep desc says 160 microframes
[    6.990035] usbcore: registered new interface driver usbhid
[    6.990042] usbhid: USB HID core driver
[    6.997940] hid-generic 0003:0463:FFFF.0001: hiddev0,hidraw0: USB HID
v10.10 Device [EATON Ellipse ECO] on usb-0000:00:14.0-6/input0

Thanks, the keyboard (connected on an USB port) is usable by another
mean :

dmesg | grep -i key
[    0.700591] input: AT Translated Set 2 keyboard
as /devices/platform/i8042/serio0/input/input0

And the keyboard works.
=============================================================================

Regards

JP P

PS :
The .config file is attached to the bug on bugzilla.


