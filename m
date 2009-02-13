From: Jiri Slaby <jirislaby@gmail.com>
Subject: Re: dead USB devices after resume [mmotm 2009-02-10-16-35]
Date: Fri, 13 Feb 2009 11:40:04 +0100
Message-ID: <49954E04.6090008@gmail.com>
References: <Pine.LNX.4.44L0.0902111009260.3056-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bw0-f161.google.com ([209.85.218.161]:55521 "EHLO
	mail-bw0-f161.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751001AbZBMKkN (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 13 Feb 2009 05:40:13 -0500
In-Reply-To: <Pine.LNX.4.44L0.0902111009260.3056-100000@iolanthe.rowland.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-kernel@vger.kernel.org, mm-commits@vger.kernel.org, Greg KH <gregkh@suse.de>, USB list <linux-usb@vger.kernel.org>, linux-input@vger.kernel.org, Oliver Neukum <oliver@neukum.org>

On 02/11/2009 04:53 PM, Alan Stern wrote:
> On Wed, 11 Feb 2009, Jiri Slaby wrote:
>=20
>> On 02/11/2009 01:36 AM, akpm@linux-foundation.org wrote:
>>> The mm-of-the-moment snapshot 2009-02-10-16-35 has been uploaded
>> Hi,
>>
>> when I resume from suspend, USB mouse and kbd are not responding any=
more, no
>> LEDs, nothing. I need to unplug and replug to get it working. This i=
s a
>> regression since mmotm based on 2.6.29-rc2 which is fine.
>>
>> Any ideas before I start bisection?
>=20
> In theory the lack of S4 support shouldn't cause this to happen.
>=20
> You might want to build a kernel with CONFIG_USB_DEBUG enabled.  The=20
> extra debugging information should help find the problem.

Here comes the resume part (including unplug, replug). I suspect auto-s=
uspend?
usb usb1: usb resume
ehci_hcd 0000:00:1a.7: resume root hub
hub 1-0:1.0: hub_resume
usb usb2: usb resume
ehci_hcd 0000:00:1d.7: resume root hub
hub 2-0:1.0: hub_resume
usb usb6: usb resume
usb usb6: wakeup_rh
hub 6-0:1.0: hub_reset_resume
hub 6-0:1.0: trying to enable port power on non-switchable hub
uhci_hcd 0000:00:1d.0: port 1 portsc 009b,00
hub 6-0:1.0: port 1: status 0101 change 0003
usb 6-1: finish reset-resume
usb 6-1: reset full speed USB device using uhci_hcd and address 2
usb 6-1: ep0 maxpacket =3D 8
usb 6-1: manual set_interface for iface 0, alt 0
hub 6-1:1.0: hub_reset_resume
hub 6-1:1.0: enabling power on all ports
hub 6-1:1.0: port 1: status 0101 change 0001
hub 6-1:1.0: port 2: status 0301 change 0001
uhci_hcd 0000:00:1d.0: reserve dev 2 ep81-INT, period 128, phase 0, 12 =
us
usb 6-1.1: finish reset-resume
usb 6-1.1: reset full speed USB device using uhci_hcd and address 3
usb 6-1.1: ep0 maxpacket =3D 8
usb 6-1.1: manual set_interface for iface 0, alt 0
usb 6-1.1: manual set_interface for iface 1, alt 0
usb 6-1.2: finish reset-resume
usb 6-1.2: reset low speed USB device using uhci_hcd and address 4
usb 6-1.2: manual set_interface for iface 0, alt 0
Restarting tasks ... <7>hub 1-0:1.0: state 7 ports 6 chg 0000 evt 0000
hub 2-0:1.0: state 7 ports 6 chg 0000 evt 0000
hub 6-0:1.0: state 7 ports 2 chg 0002 evt 0002
hub 6-0:1.0: port 1, status 0103, change 0000, 12 Mb/s
hub 6-1:1.0: state 7 ports 3 chg 0006 evt 0004
done.
hub 6-1:1.0: port 1, status 0103, change 0000, 12 Mb/s
hub 6-1:1.0: port 2, status 0303, change 0000, 1.5 Mb/s
hub 1-0:1.0: hub_suspend
usb usb1: bus auto-suspend
ehci_hcd 0000:00:1a.7: suspend root hub
hub 2-0:1.0: hub_suspend
usb usb2: bus auto-suspend
ehci_hcd 0000:00:1d.7: suspend root hub
hub 6-0:1.0: state 7 ports 2 chg 0000 evt 0002
uhci_hcd 0000:00:1d.0: port 1 portsc 008a,00
hub 6-0:1.0: port 1, status 0100, change 0003, 12 Mb/s
usb 6-1: USB disconnect, address 2
usb 6-1.1: USB disconnect, address 3
usb 6-1.1: unregistering device
usb 6-1.1: usb_disable_device nuking all URBs
usb 6-1.1: unregistering interface 6-1.1:1.0
usb 6-1.1:1.0: uevent
usb 6-1.1: unregistering interface 6-1.1:1.1
usb 6-1.1:1.1: uevent
usb 6-1.1: uevent
usb 6-1.2: USB disconnect, address 4
usb 6-1.2: unregistering device
usb 6-1.2: usb_disable_device nuking all URBs
usb 6-1.2: unregistering interface 6-1.2:1.0
usb 6-1.2:1.0: uevent
usb 6-1.2: uevent
usb 6-1: unregistering device
usb 6-1: usb_disable_device nuking all URBs
uhci_hcd 0000:00:1d.0: shutdown urb ffff88007c8ca540 ep1in-intr
uhci_hcd 0000:00:1d.0: release dev 2 ep81-INT, period 128, phase 0, 12 =
us
usb 6-1: unregistering interface 6-1:1.0
usb 6-1:1.0: uevent
usb 6-1: uevent
hub 6-0:1.0: debounce: port 1: total 100ms stable 100ms status 0x100
usb usb2: usb resume
ehci_hcd 0000:00:1d.7: resume root hub
ehci_hcd 0000:00:1d.7: port 1 full speed --> companion
ehci_hcd 0000:00:1d.7: GetStatus port 1 status 003801 POWER OWNER sig=3D=
j CONNECT
hub 2-0:1.0: hub_resume
ehci_hcd 0000:00:1d.7: GetStatus port 1 status 003002 POWER OWNER sig=3D=
se0 CSC
hub 2-0:1.0: state 7 ports 6 chg 0000 evt 0000
hub 6-0:1.0: state 7 ports 2 chg 0000 evt 0002
uhci_hcd 0000:00:1d.0: port 1 portsc 0093,00
hub 6-0:1.0: port 1, status 0101, change 0001, 12 Mb/s
hub 6-0:1.0: debounce: port 1: total 100ms stable 100ms status 0x101
usb 6-1: new full speed USB device using uhci_hcd and address 5
usb 6-1: ep0 maxpacket =3D 8
usb 6-1: default language 0x0409
usb 6-1: New USB device found, idVendor=3D04b4, idProduct=3D2050
usb 6-1: New USB device strings: Mfr=3D1, Product=3D2, SerialNumber=3D0
usb 6-1: Product: GBella Corporation DV Keyboard
usb 6-1: Manufacturer: Bella Corporation
usb 6-1: uevent
usb 6-1: usb_probe_device
usb 6-1: configuration #1 chosen from 1 choice
usb 6-1: adding 6-1:1.0 (config #1, interface 0)
usb 6-1:1.0: uevent
hub 6-1:1.0: usb_probe_interface
hub 6-1:1.0: usb_probe_interface - got id
hub 6-1:1.0: USB hub found
hub 6-1:1.0: 3 ports detected
hub 6-1:1.0: compound device; port removable status: FRR
hub 6-1:1.0: individual port power switching
hub 6-1:1.0: individual port over-current protection
hub 6-1:1.0: power on to power good time: 100ms
hub 6-1:1.0: hub controller current requirement: 25mA
hub 6-1:1.0: 100mA bus power budget for each child
hub 6-1:1.0: local power source is good
hub 6-1:1.0: enabling power on all ports
/home/l/latest/xxx/drivers/usb/core/inode.c: creating file '005'
hub 6-0:1.0: state 7 ports 2 chg 0000 evt 0002
hub 6-1:1.0: port 1: status 0101 change 0001
hub 6-1:1.0: port 2: status 0301 change 0001
uhci_hcd 0000:00:1d.0: reserve dev 5 ep81-INT, period 128, phase 0, 12 =
us
hub 6-1:1.0: state 7 ports 3 chg 0006 evt 0000
hub 6-1:1.0: port 1, status 0101, change 0000, 12 Mb/s
usb 6-1.1: new full speed USB device using uhci_hcd and address 6
usb 6-1.1: ep0 maxpacket =3D 8
usb 6-1.1: skipped 1 descriptor after interface
usb 6-1.1: skipped 1 descriptor after interface
usb 6-1.1: default language 0x0409
usb 6-1.1: New USB device found, idVendor=3D0458, idProduct=3D004c
usb 6-1.1: New USB device strings: Mfr=3D1, Product=3D2, SerialNumber=3D=
0
usb 6-1.1: Product: USB Keyboard
usb 6-1.1: Manufacturer: ABBHOME
usb 6-1.1: uevent
usb 6-1.1: usb_probe_device
usb 6-1.1: configuration #1 chosen from 1 choice
usb 6-1.1: adding 6-1.1:1.0 (config #1, interface 0)
usb 6-1.1:1.0: uevent
usbhid 6-1.1:1.0: usb_probe_interface
usbhid 6-1.1:1.0: usb_probe_interface - got id
input: ABBHOME USB Keyboard as
/devices/pci0000:00/0000:00:1d.0/usb6/6-1/6-1.1/6-1.1:1.0/input/input13
uhci_hcd 0000:00:1d.0: reserve dev 6 ep81-INT, period 8, phase 4, 17 us
generic-usb 0003:0458:004C.0004: input: USB HID v1.10 Keyboard [ABBHOME=
 USB
Keyboard] on usb-0000:00:1d.0-1.1/input0
usb 6-1.1: adding 6-1.1:1.1 (config #1, interface 1)
usb 6-1.1:1.1: uevent
usbhid 6-1.1:1.1: usb_probe_interface
usbhid 6-1.1:1.1: usb_probe_interface - got id
input: ABBHOME USB Keyboard as
/devices/pci0000:00/0000:00:1d.0/usb6/6-1/6-1.1/6-1.1:1.1/input/input14
uhci_hcd 0000:00:1d.0: reserve dev 6 ep82-INT, period 8, phase 4, 17 us
generic-usb 0003:0458:004C.0005: input: USB HID v1.10 Mouse [ABBHOME US=
B
Keyboard] on usb-0000:00:1d.0-1.1/input1
/home/l/latest/xxx/drivers/usb/core/inode.c: creating file '006'
hub 6-1:1.0: 425mA power budget left
hub 6-1:1.0: port 2, status 0301, change 0000, 1.5 Mb/s
usb 6-1.2: new low speed USB device using uhci_hcd and address 7
usb 6-1.2: skipped 1 descriptor after interface
usb 6-1.2: default language 0x0409
usb 6-1.2: New USB device found, idVendor=3D045e, idProduct=3D00f0
usb 6-1.2: New USB device strings: Mfr=3D1, Product=3D2, SerialNumber=3D=
0
usb 6-1.2: Product: Microsoft =EF=BF=BD Laser Mouse 6000
usb 6-1.2: Manufacturer: Microsoft Corporation
usb 6-1.2: uevent
usb 6-1.2: usb_probe_device
usb 6-1.2: configuration #1 chosen from 1 choice
usb 6-1.2: adding 6-1.2:1.0 (config #1, interface 0)
usb 6-1.2:1.0: uevent
usbhid 6-1.2:1.0: usb_probe_interface
usbhid 6-1.2:1.0: usb_probe_interface - got id
input: Microsoft Corporation Microsoft =EF=BF=BD Laser Mouse 6000 as
/devices/pci0000:00/0000:00:1d.0/usb6/6-1/6-1.2/6-1.2:1.0/input/input15
uhci_hcd 0000:00:1d.0: reserve dev 7 ep81-INT, period 8, phase 4, 93 us
generic-usb 0003:045E:00F0.0006: input: USB HID v1.11 Mouse [Microsoft
Corporation Microsoft =EF=BF=BD Laser Mouse 6000] on usb-0000:00:1d.0-1=
=2E2/input0
/home/l/latest/xxx/drivers/usb/core/inode.c: creating file '007'
hub 6-1:1.0: 325mA power budget left
hub 6-1:1.0: state 7 ports 3 chg 0000 evt 0004
hub 2-0:1.0: hub_suspend
usb usb2: bus auto-suspend
ehci_hcd 0000:00:1d.7: suspend root hub
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
