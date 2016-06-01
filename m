From: Ville Ranki <ville.ranki@iki.fi>
Subject: Device file not created for TRC rudder
Date: Wed, 1 Jun 2016 19:00:32 +0300
Message-ID: <574F06A0.5020904@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.cs.tut.fi ([130.230.4.42]:41709 "HELO mail.cs.tut.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751727AbcFAQHJ (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 1 Jun 2016 12:07:09 -0400
Received: from amavis1.cs.tut.fi (amavis1.cs.tut.fi [130.230.4.69])
	by mail.cs.tut.fi (Postfix) with ESMTP id E9B3B137
	for <linux-input@vger.kernel.org>; Wed,  1 Jun 2016 19:00:36 +0300 (EEST)
Received: from mail.cs.tut.fi ([130.230.4.42])
 by amavis1.cs.tut.fi (amavis1.cs.tut.fi [130.230.4.69]) (amavisd-maia, port 10024)
 with ESMTP id 05656-25 for <linux-input@vger.kernel.org>;
 Wed,  1 Jun 2016 19:00:36 +0300 (EEST)
Received: from modeemi.modeemi.fi (modeemi.modeemi.fi [130.230.72.134])
	by mail.cs.tut.fi (Postfix) with SMTP id ECAE0136
	for <linux-input@vger.kernel.org>; Wed,  1 Jun 2016 19:00:35 +0300 (EEST)
Received: from [IPv6:2001:708:310:3430::140] (unknown [IPv6:2001:708:310:3430::140])
	by modeemi.modeemi.fi (Postfix) with ESMTP id F1A293A916
	for <linux-input@vger.kernel.org>; Wed,  1 Jun 2016 19:00:33 +0300 (EEST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


Hello,

I have a USB HID joystick (professional grade rudder pedals) which
are not properly recognized as joystick. Event device is created,
but no /dev/input/jsX device node file. Other USB joysticks are
recognized and proper node files are created, so I suppose this
is a kernel issue. If not, could you point me to right direction?


Here's all info i could dig out of the device. Tested on kernel
4.4.0-22-generic on Ubuntu 16.04. The pedals output sane events
when testing with evtest, but are not found by applications as
the jsX file is missing.


Kernel output:
[27824.110672] usb 3-2.1.4: new low-speed USB device number 10 using
xhci_hcd
[27824.203250] usb 3-2.1.4: New USB device found, idVendor=0d59,
idProduct=0145
[27824.203255] usb 3-2.1.4: New USB device strings: Mfr=1, Product=2,
SerialNumber=0
[27824.203257] usb 3-2.1.4: Product: TRC RUDDER v2
[27824.203259] usb 3-2.1.4: Manufacturer: TRC
[27824.207307] input: TRC TRC RUDDER v2 as
/devices/pci0000:00/0000:00:14.0/usb3/3-2/3-2.1/3-2.1.4/3-2.1.4:1.0/0003:0D59:0145.0003/input/input17
[27824.207468] hid-generic 0003:0D59:0145.0003: input,hidraw2: USB HID
v1.00 Joystick [TRC TRC RUDDER v2] on usb-0000:00:14.0-2.1.4/input0

lsinput:
/dev/input/event16
   bustype : BUS_USB
   vendor  : 0xd59
   product : 0x145
   version : 256
   name    : "TRC TRC RUDDER v2"
   phys    : "usb-0000:00:14.0-2.1.4/input0"
   uniq    : ""
   bits ev : EV_SYN EV_ABS


udevadm:
P:
/devices/pci0000:00/0000:00:14.0/usb3/3-2/3-2.1/3-2.1.4/3-2.1.4:1.0/0003:0D59:0145.0003/input/input17/event16
N: input/event16
S: input/by-id/usb-TRC_TRC_RUDDER_v2-event-if00
S: input/by-path/pci-0000:00:14.0-usb-0:2.1.4:1.0-event
E: DEVLINKS=/dev/input/by-path/pci-0000:00:14.0-usb-0:2.1.4:1.0-event
/dev/input/by-id/usb-TRC_TRC_RUDDER_v2-event-if00
E: DEVNAME=/dev/input/event16
E:
DEVPATH=/devices/pci0000:00/0000:00:14.0/usb3/3-2/3-2.1/3-2.1.4/3-2.1.4:1.0/0003:0D59:0145.0003/input/input17/event16
E: ID_BUS=usb
E: ID_INPUT=1
E: ID_MODEL=TRC_RUDDER_v2
E: ID_MODEL_ENC=TRC\x20RUDDER\x20v2
E: ID_MODEL_ID=0145
E: ID_PATH=pci-0000:00:14.0-usb-0:2.1.4:1.0
E: ID_PATH_TAG=pci-0000_00_14_0-usb-0_2_1_4_1_0
E: ID_REVISION=0001
E: ID_SERIAL=TRC_TRC_RUDDER_v2
E: ID_TYPE=hid
E: ID_USB_DRIVER=usbhid
E: ID_USB_INTERFACES=:030000:
E: ID_USB_INTERFACE_NUM=00
E: ID_VENDOR=TRC
E: ID_VENDOR_ENC=TRC
E: ID_VENDOR_ID=0d59
E: MAJOR=13
E: MINOR=80
E: SUBSYSTEM=input
E: USEC_INITIALIZED=27821308664

udevadm test-builtin:
calling: test-builtin
=== trie on-disk ===
tool version:          229
file size:         7058303 bytes
header size             80 bytes
strings            1762191 bytes
nodes              5296032 bytes
Load module index
timestamp of '/etc/systemd/network' changed
timestamp of '/lib/systemd/network' changed
Parsed configuration file /lib/systemd/network/99-default.link
Created link configuration context.
ID_INPUT=1
capabilities/ev raw kernel attribute: 9
capabilities/ev decoded bit map:
  bit    0: 0000000000000009
capabilities/abs raw kernel attribute: 1c
capabilities/abs decoded bit map:
  bit    0: 000000000000001C
capabilities/rel raw kernel attribute: 0
capabilities/rel decoded bit map:
capabilities/key raw kernel attribute: 0
capabilities/key decoded bit map:
properties raw kernel attribute: 0
properties decoded bit map:
test_key: no EV_KEY capability
Unload module index
Unloaded link configuration context.


- -- 
Ville Ranki <ville.ranki@iki.fi>
http://www.iki.fi/~cos
PGP public key: http://www.iki.fi/~cos/vranki_pub.asc
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAldPBp8ACgkQVm11nqR7UVymsQCfVY4GGAYHXYta2B17diX8iTze
LzEAniA0cUMcgRThVXVQLd1/XE4nY8Hl
=qAoi
-----END PGP SIGNATURE-----
