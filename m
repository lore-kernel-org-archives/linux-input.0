From: Tvrtko Ursulin <tvrtko.ursulin@onelan.co.uk>
Subject: Re: Baantoo multi-touch screen trouble
Date: Thu, 12 Apr 2012 15:47:28 +0100
Message-ID: <201204121547.29206.tvrtko.ursulin@onelan.co.uk>
References: <201204111629.59916.tvrtko.ursulin@onelan.co.uk>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from claranet-outbound-smtp04.uk.clara.net ([195.8.89.37]:40794 "EHLO
	claranet-outbound-smtp04.uk.clara.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757619Ab2DLOrd convert rfc822-to-8bit
	(ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 12 Apr 2012 10:47:33 -0400
In-Reply-To: <201204111629.59916.tvrtko.ursulin@onelan.co.uk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Jiri Kosina <jkosina@suse.cz>


[Jiri, I copied you as per get_maintainers.pl having trouble debugging
this issue in case linux-input mailing list is dead (can't find recent
archives). My original post plus some debug info is below.]

On Wednesday 11 Apr 2012 16:29:59 Tvrtko Ursulin wrote:
> Hi all,
>=20
> I am playing with a multi-touch capable touch screen from the
> above mentioned vendor and are experiencing some problems here.
> On a 3.1.0 derivative kernel it kind of works, looks like this:
>=20
> [5523460.737596] usb 1-1.6.1.2: new full speed USB device number 18 u=
sing
> ehci_hcd [5523460.824952] usb 1-1.6.1.2: New USB device found,
> idVendor=3D2453, idProduct=3D0100 [5523460.824959] usb 1-1.6.1.2: New=
 USB
> device strings: Mfr=3D1, Product=3D2, SerialNumber=3D3 [5523460.82496=
4] usb
> 1-1.6.1.2: Product: SDW-190W2-M5T-XXX-XX-PRD
> [5523460.824968] usb 1-1.6.1.2: Manufacturer: Baanto
> [5523460.824971] usb 1-1.6.1.2: SerialNumber: SDW190W2M5T
> [5523460.833233] input: Baanto SDW-190W2-M5T-XXX-XX-PRD    as
> /devices/pci0000:00/0000:00:1a.0/usb1/1-1/1-1.6/1-1.6.1/1-1.6.1.2/1-1=
=2E6.1.2
> :1.0/input/input159 [5523460.833926] generic-usb 0003:2453:0100.00A3:
> input,hiddev0,hidraw3: USB HID v1.10 Mouse [Baanto SDW-190W2-M5T-
> XXX-XX-PRD   ] on usb-0000:00:1a.0-1.6.1.2/input0
>=20
>=20
> On 3.3.0 it doesn't think it is an input device at all:
>=20
> [   73.776660] usb 3-1: new full-speed USB device number 3 using xhci=
_hcd
> [   73.817163] usb 3-1: New USB device found, idVendor=3D2453, idProd=
uct=3D0100
> [   73.817167] usb 3-1: New USB device strings: Mfr=3D1, Product=3D2,
> SerialNumber=3D3 [   73.817169] usb 3-1: Product: SDW-190W2-M5T-XXX-X=
X-PRD
> [   73.817171] usb 3-1: Manufacturer: Baanto
> [   73.817173] usb 3-1: SerialNumber: SDW190W2M5T
>=20
> On 3.0 on the other hand it actually registered multiple HID devices,=
 which
> is what I think should happen with this device, because it's datashee=
t
> says this:
>=20
> """
> The mid-size family of touch screens, when enumerated on the OS, expo=
se 5
> top level USB HID collections. The following table describes these in
> detail: following table describes these in detail:
>=20
> Collection Description
> ----------------------
> Win 7 Touch Collection
> Microsoft Device Configuration Collection
> Generic Mouse Collection
> Generic Pointer Collection
> Baanto Touch (Custom HID) Collection
>=20
> Report Data
> -----------
> Multi Touch Packets
> Control Packets
> N\A =E2=80=93 Future Use
> Single Touch Packet
> Multi Touch Packets\Control Packets
> """
>=20
> Any ideas who is at fault here?
>=20
> Thanks,
>=20
> Tvrtko
>=20
>=20
> Bus 003 Device 003: ID 2453:0100
> Device Descriptor:
>   bLength                18
>   bDescriptorType         1
>   bcdUSB               2.00
>   bDeviceClass            0 (Defined at Interface level)
>   bDeviceSubClass         0
>   bDeviceProtocol         0
>   bMaxPacketSize0        64
>   idVendor           0x2453
>   idProduct          0x0100
>   bcdDevice            4.0c
>   iManufacturer           1 Baanto
>   iProduct                2 SDW-190W2-M5T-XXX-XX-PRD
>   iSerial                 3 SDW190W2M5T
>   bNumConfigurations      1
>   Configuration Descriptor:
>     bLength                 9
>     bDescriptorType         2
>     wTotalLength           34
>     bNumInterfaces          1
>     bConfigurationValue     1
>     iConfiguration          0
>     bmAttributes         0xc0
>       Self Powered
>     MaxPower              500mA
>     Interface Descriptor:
>       bLength                 9
>       bDescriptorType         4
>       bInterfaceNumber        0
>       bAlternateSetting       0
>       bNumEndpoints           1
>       bInterfaceClass         3 Human Interface Device
>       bInterfaceSubClass      0 No Subclass
>       bInterfaceProtocol      0 None
>       iInterface              0
>         HID Device Descriptor:
>           bLength                 9
>           bDescriptorType        33
>           bcdHID               1.10
>           bCountryCode           33 US
>           bNumDescriptors         1
>           bDescriptorType        34 Report
>           wDescriptorLength     759
>          Report Descriptors:
>            ** UNAVAILABLE **
>       Endpoint Descriptor:
>         bLength                 7
>         bDescriptorType         5
>         bEndpointAddress     0x81  EP 1 IN
>         bmAttributes            3
>           Transfer Type            Interrupt
>           Synch Type               None
>           Usage Type               Data
>         wMaxPacketSize     0x0040  1x 64 bytes
>         bInterval               1
> Device Status:     0x0001
>   Self Powered

This is all I see with HID debugging turned on (3.3.0) after plugging i=
n the device:

[85409.156718] drivers/hid/usbhid/hid-core.c: HID probe called for ifnu=
m 0
[85409.176184] drivers/hid/usbhid/hid-core.c: submitting ctrl urb: Get_=
Report wValue=3D0x0123 wIndex=3D0x0000 wLength=3D56
[85409.177652] drivers/hid/usbhid/hid-core.c: submitting ctrl urb: Get_=
Report wValue=3D0x0125 wIndex=3D0x0000 wLength=3D6
[85409.179649] drivers/hid/usbhid/hid-core.c: submitting ctrl urb: Get_=
Report wValue=3D0x0110 wIndex=3D0x0000 wLength=3D6
[85409.181639] drivers/hid/usbhid/hid-core.c: submitting ctrl urb: Get_=
Report wValue=3D0x0109 wIndex=3D0x0000 wLength=3D64
[85409.183636] drivers/hid/usbhid/hid-core.c: submitting ctrl urb: Get_=
Report wValue=3D0x010f wIndex=3D0x0000 wLength=3D64
[85409.185634] drivers/hid/usbhid/hid-core.c: submitting ctrl urb: Get_=
Report wValue=3D0x010b wIndex=3D0x0000 wLength=3D64
[85409.187639] drivers/hid/usbhid/hid-core.c: submitting ctrl urb: Get_=
Report wValue=3D0x010c wIndex=3D0x0000 wLength=3D64
[85409.189633] drivers/hid/usbhid/hid-core.c: submitting ctrl urb: Get_=
Report wValue=3D0x010d wIndex=3D0x0000 wLength=3D64
[85409.191628] drivers/hid/usbhid/hid-core.c: submitting ctrl urb: Get_=
Report wValue=3D0x0324 wIndex=3D0x0000 wLength=3D2
[85409.194619] drivers/hid/usbhid/hid-core.c: submitting ctrl urb: Get_=
Report wValue=3D0x0327 wIndex=3D0x0000 wLength=3D3
[85409.196621] drivers/hid/usbhid/hid-core.c: submitting ctrl urb: Get_=
Report wValue=3D0x0302 wIndex=3D0x0000 wLength=3D4
[85409.199617] drivers/hid/usbhid/hid-core.c: submitting ctrl urb: Get_=
Report wValue=3D0x0303 wIndex=3D0x0000 wLength=3D13
[85409.202615] drivers/hid/usbhid/hid-core.c: submitting ctrl urb: Get_=
Report wValue=3D0x0304 wIndex=3D0x0000 wLength=3D13
[85409.205606] drivers/hid/usbhid/hid-core.c: submitting ctrl urb: Get_=
Report wValue=3D0x0305 wIndex=3D0x0000 wLength=3D3
[85409.208601] drivers/hid/usbhid/hid-core.c: submitting ctrl urb: Get_=
Report wValue=3D0x0355 wIndex=3D0x0000 wLength=3D2
[85409.210603] drivers/hid/usbhid/hid-core.c: submitting ctrl urb: Get_=
Report wValue=3D0x0377 wIndex=3D0x0000 wLength=3D2
[85409.212604] drivers/hid/usbhid/hid-core.c: submitting ctrl urb: Get_=
Report wValue=3D0x0366 wIndex=3D0x0000 wLength=3D2
[85409.214597] drivers/hid/usbhid/hid-core.c: submitting ctrl urb: Get_=
Report wValue=3D0x0388 wIndex=3D0x0000 wLength=3D2
[85409.216593] drivers/hid/usbhid/hid-core.c: submitting ctrl urb: Get_=
Report wValue=3D0x0344 wIndex=3D0x0000 wLength=3D2

No input device of any kind registered after this point.

Hints about what is going wrong?

Tvrtko

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
