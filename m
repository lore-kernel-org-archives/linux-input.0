From: Bruno =?UTF-8?B?UHLDqW1vbnQ=?= <bonbons@linux-vserver.org>
Subject: Re: S2R resume crash in 2.6.33-rc7 - NULL pointer dereference in
 dev_get_drvdata() for usbhid
Date: Mon, 8 Feb 2010 19:47:45 +0100
Message-ID: <20100208194745.3aab6d1a@neptune.home>
References: <20100208175145.606ca761@neptune.home>
	<Pine.LNX.4.44L0.1002081313260.1316-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ppp-156-198.adsl.restena.lu ([158.64.156.198]:39260 "EHLO
	bonbons.gotdns.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753408Ab0BHSsP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 8 Feb 2010 13:48:15 -0500
In-Reply-To: <Pine.LNX.4.44L0.1002081313260.1316-100000@iolanthe.rowland.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Jiri Kosina <jkosina@suse.cz>, Oliver Neukum <oliver@neukum.org>, Stephen Rothwell <sfr@canb.auug.org.au>, Marcel Holtmann <marcel@holtmann.org>, H Hartley Sweeten <hsweeten@visionengravers.com>, linux-usb@vger.kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, 8 Feb 2010, Bruno [UTF-8] Pr=C3=A9mont wrote:
> 2.6.33-rc7 (don't know if any previous version resumes properly)
> crashes during resume from S2Ram when my USB keyboard is connected
> but resumes properly (viafb corruption put apart) when the USB
> keyboard is not connected.
>
> Keyboard detection:
> [    3.070054] usb 2-2: new full speed USB device using uhci_hcd and =
address 2
> [    3.220179] kbd_mode used greatest stack depth: 2228 bytes left
> [    3.276403] usb 2-2: New USB device found, idVendor=3D058f, idProd=
uct=3D9462
> [    3.276514] usb 2-2: New USB device strings: Mfr=3D1, Product=3D2,=
 SerialNumber=3D0
> [    3.276619] usb 2-2: Product: Multimedia USB Keyboard
> [    3.276711] usb 2-2: Manufacturer: Multimedia USB Keyboard
> [    3.278056] loadkeys used greatest stack depth: 1904 bytes left
> [    3.278791] init-early.sh used greatest stack depth: 1700 bytes le=
ft
> [    3.282561] hub 2-2:1.0: USB hub found
> [    3.286387] hub 2-2:1.0: 3 ports detected
> [    3.571454] usb 2-2.1: new full speed USB device using uhci_hcd an=
d address 3
> [    3.761474] usb 2-2.1: New USB device found, idVendor=3D058f, idPr=
oduct=3D9462
> [    3.761584] usb 2-2.1: New USB device strings: Mfr=3D1, Product=3D=
2, SerialNumber=3D3
> [    3.761719] usb 2-2.1: Product: Multimedia USB Keyboard
> [    3.762518] usb 2-2.1: Manufacturer: Multimedia USB Keyboard
> [    3.762612] usb 2-2.1: SerialNumber: Multimedia USB Keyboard
> [    3.789221] input: Multimedia USB Keyboard Multimedia USB Keyboard=
 as /devices/pci0000:00/0000:00:10.0/usb2/2-2/2-2.1/2-2.1:1.0/input/inp=
ut4
> [    3.789585] generic-usb 0003:058F:9462.0001: input: USB HID v1.10 =
Keyboard [Multimedia USB Keyboard Multimedia USB Keyboard] on usb-0000:=
00:10.0-2.1/input0
> [    3.818001] generic-usb: probe of 0003:058F:9462.0002 failed with =
error -22 =20


On Mon, 08 February 2010 Alan Stern <stern@rowland.harvard.edu> wrote:
> > Could the crash be related to the generic-usb probe error?
>=20
> Yes, it could.  Can you post the contents of=20
> /sys/kernel/debug/usb/devices (after mounting a debugfs filesystem on=
=20
> /sys/kernel/debug), with the keyboard plugged in?

Here it is:

T:  Bus=3D04 Lev=3D00 Prnt=3D00 Port=3D00 Cnt=3D00 Dev#=3D  1 Spd=3D12 =
 MxCh=3D 2
B:  Alloc=3D  0/900 us ( 0%), #Int=3D  0, #Iso=3D  0
D:  Ver=3D 1.10 Cls=3D09(hub  ) Sub=3D00 Prot=3D00 MxPS=3D64 #Cfgs=3D  =
1
P:  Vendor=3D1d6b ProdID=3D0001 Rev=3D 2.06
S:  Manufacturer=3DLinux 2.6.33-rc7-venus uhci_hcd
S:  Product=3DUHCI Host Controller
S:  SerialNumber=3D0000:00:10.2
C:* #Ifs=3D 1 Cfg#=3D 1 Atr=3De0 MxPwr=3D  0mA
I:* If#=3D 0 Alt=3D 0 #EPs=3D 1 Cls=3D09(hub  ) Sub=3D00 Prot=3D00 Driv=
er=3Dhub
E:  Ad=3D81(I) Atr=3D03(Int.) MxPS=3D   2 Ivl=3D255ms

T:  Bus=3D03 Lev=3D00 Prnt=3D00 Port=3D00 Cnt=3D00 Dev#=3D  1 Spd=3D12 =
 MxCh=3D 2
B:  Alloc=3D  0/900 us ( 0%), #Int=3D  0, #Iso=3D  0
D:  Ver=3D 1.10 Cls=3D09(hub  ) Sub=3D00 Prot=3D00 MxPS=3D64 #Cfgs=3D  =
1
P:  Vendor=3D1d6b ProdID=3D0001 Rev=3D 2.06
S:  Manufacturer=3DLinux 2.6.33-rc7-venus uhci_hcd
S:  Product=3DUHCI Host Controller
S:  SerialNumber=3D0000:00:10.1
C:* #Ifs=3D 1 Cfg#=3D 1 Atr=3De0 MxPwr=3D  0mA
I:* If#=3D 0 Alt=3D 0 #EPs=3D 1 Cls=3D09(hub  ) Sub=3D00 Prot=3D00 Driv=
er=3Dhub
E:  Ad=3D81(I) Atr=3D03(Int.) MxPS=3D   2 Ivl=3D255ms

T:  Bus=3D02 Lev=3D00 Prnt=3D00 Port=3D00 Cnt=3D00 Dev#=3D  1 Spd=3D12 =
 MxCh=3D 2
B:  Alloc=3D  2/900 us ( 0%), #Int=3D  2, #Iso=3D  0
D:  Ver=3D 1.10 Cls=3D09(hub  ) Sub=3D00 Prot=3D00 MxPS=3D64 #Cfgs=3D  =
1
P:  Vendor=3D1d6b ProdID=3D0001 Rev=3D 2.06
S:  Manufacturer=3DLinux 2.6.33-rc7-venus uhci_hcd
S:  Product=3DUHCI Host Controller
S:  SerialNumber=3D0000:00:10.0
C:* #Ifs=3D 1 Cfg#=3D 1 Atr=3De0 MxPwr=3D  0mA
I:* If#=3D 0 Alt=3D 0 #EPs=3D 1 Cls=3D09(hub  ) Sub=3D00 Prot=3D00 Driv=
er=3Dhub
E:  Ad=3D81(I) Atr=3D03(Int.) MxPS=3D   2 Ivl=3D255ms

T:  Bus=3D02 Lev=3D01 Prnt=3D01 Port=3D01 Cnt=3D01 Dev#=3D  2 Spd=3D12 =
 MxCh=3D 3
D:  Ver=3D 1.10 Cls=3D09(hub  ) Sub=3D00 Prot=3D00 MxPS=3D 8 #Cfgs=3D  =
1
P:  Vendor=3D058f ProdID=3D9462 Rev=3D 1.58
S:  Manufacturer=3DMultimedia USB Keyboard
S:  Product=3DMultimedia USB Keyboard
C:* #Ifs=3D 1 Cfg#=3D 1 Atr=3Da0 MxPwr=3D 50mA
I:* If#=3D 0 Alt=3D 0 #EPs=3D 1 Cls=3D09(hub  ) Sub=3D00 Prot=3D00 Driv=
er=3Dhub
E:  Ad=3D81(I) Atr=3D03(Int.) MxPS=3D   1 Ivl=3D255ms

T:  Bus=3D02 Lev=3D02 Prnt=3D02 Port=3D00 Cnt=3D01 Dev#=3D  3 Spd=3D12 =
 MxCh=3D 0
D:  Ver=3D 1.10 Cls=3D00(>ifc ) Sub=3D00 Prot=3D00 MxPS=3D 8 #Cfgs=3D  =
1
P:  Vendor=3D058f ProdID=3D9462 Rev=3D 4.10
S:  Manufacturer=3DMultimedia USB Keyboard
S:  Product=3DMultimedia USB Keyboard
S:  SerialNumber=3DMultimedia USB Keyboard
C:* #Ifs=3D 2 Cfg#=3D 1 Atr=3Da0 MxPwr=3D 50mA
I:* If#=3D 0 Alt=3D 0 #EPs=3D 1 Cls=3D03(HID  ) Sub=3D01 Prot=3D01 Driv=
er=3Dusbhid
E:  Ad=3D81(I) Atr=3D03(Int.) MxPS=3D   8 Ivl=3D10ms
I:* If#=3D 1 Alt=3D 0 #EPs=3D 1 Cls=3D03(HID  ) Sub=3D00 Prot=3D00 Driv=
er=3Dusbhid
E:  Ad=3D82(I) Atr=3D03(Int.) MxPS=3D   4 Ivl=3D255ms

T:  Bus=3D01 Lev=3D00 Prnt=3D00 Port=3D00 Cnt=3D00 Dev#=3D  1 Spd=3D480=
 MxCh=3D 6
B:  Alloc=3D  0/800 us ( 0%), #Int=3D  0, #Iso=3D  0
D:  Ver=3D 2.00 Cls=3D09(hub  ) Sub=3D00 Prot=3D00 MxPS=3D64 #Cfgs=3D  =
1
P:  Vendor=3D1d6b ProdID=3D0002 Rev=3D 2.06
S:  Manufacturer=3DLinux 2.6.33-rc7-venus ehci_hcd
S:  Product=3DEHCI Host Controller
S:  SerialNumber=3D0000:00:10.4
C:* #Ifs=3D 1 Cfg#=3D 1 Atr=3De0 MxPwr=3D  0mA
I:* If#=3D 0 Alt=3D 0 #EPs=3D 1 Cls=3D09(hub  ) Sub=3D00 Prot=3D00 Driv=
er=3Dhub
E:  Ad=3D81(I) Atr=3D03(Int.) MxPS=3D   4 Ivl=3D256ms


Thanks,
Bruno
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
