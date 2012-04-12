From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: Baantoo multi-touch screen trouble
Date: Thu, 12 Apr 2012 18:05:34 +0200
Message-ID: <CAN+gG=GzVSzQpEV0bFMTn0H_vj+yKHHSZpyL4dBCFTE7To0=-A@mail.gmail.com>
References: <201204111629.59916.tvrtko.ursulin@onelan.co.uk>
	<201204121547.29206.tvrtko.ursulin@onelan.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:43352 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757746Ab2DLQFf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 12 Apr 2012 12:05:35 -0400
Received: by iagz16 with SMTP id z16so2970302iag.19
        for <linux-input@vger.kernel.org>; Thu, 12 Apr 2012 09:05:34 -0700 (PDT)
In-Reply-To: <201204121547.29206.tvrtko.ursulin@onelan.co.uk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Tvrtko Ursulin <tvrtko.ursulin@onelan.co.uk>
Cc: linux-input@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>

Hi Tvrtko,

I misread your first mail, sorry for that. I did not saw that your
device was a Hid one detected as a multitouch one. Under 3.3, just do:
$ sudo modprobe hid-multitouch

And the device should be handled by hid-multitouch.

The 3.3 kernel, detects that your device should be handled by
hid-multitouch, but it does not load it automatically. You may add
this module in the configuration file.

Cheers,
Benjamin

On Thu, Apr 12, 2012 at 16:47, Tvrtko Ursulin
<tvrtko.ursulin@onelan.co.uk> wrote:
>
> [Jiri, I copied you as per get_maintainers.pl having trouble debuggin=
g
> this issue in case linux-input mailing list is dead (can't find recen=
t
> archives). My original post plus some debug info is below.]
>
> On Wednesday 11 Apr 2012 16:29:59 Tvrtko Ursulin wrote:
>> Hi all,
>>
>> I am playing with a multi-touch capable touch screen from the
>> above mentioned vendor and are experiencing some problems here.
>> On a 3.1.0 derivative kernel it kind of works, looks like this:
>>
>> [5523460.737596] usb 1-1.6.1.2: new full speed USB device number 18 =
using
>> ehci_hcd [5523460.824952] usb 1-1.6.1.2: New USB device found,
>> idVendor=3D2453, idProduct=3D0100 [5523460.824959] usb 1-1.6.1.2: Ne=
w USB
>> device strings: Mfr=3D1, Product=3D2, SerialNumber=3D3 [5523460.8249=
64] usb
>> 1-1.6.1.2: Product: SDW-190W2-M5T-XXX-XX-PRD
>> [5523460.824968] usb 1-1.6.1.2: Manufacturer: Baanto
>> [5523460.824971] usb 1-1.6.1.2: SerialNumber: SDW190W2M5T
>> [5523460.833233] input: Baanto SDW-190W2-M5T-XXX-XX-PRD =A0 =A0as
>> /devices/pci0000:00/0000:00:1a.0/usb1/1-1/1-1.6/1-1.6.1/1-1.6.1.2/1-=
1.6.1.2
>> :1.0/input/input159 [5523460.833926] generic-usb 0003:2453:0100.00A3=
:
>> input,hiddev0,hidraw3: USB HID v1.10 Mouse [Baanto SDW-190W2-M5T-
>> XXX-XX-PRD =A0 ] on usb-0000:00:1a.0-1.6.1.2/input0
>>
>>
>> On 3.3.0 it doesn't think it is an input device at all:
>>
>> [ =A0 73.776660] usb 3-1: new full-speed USB device number 3 using x=
hci_hcd
>> [ =A0 73.817163] usb 3-1: New USB device found, idVendor=3D2453, idP=
roduct=3D0100
>> [ =A0 73.817167] usb 3-1: New USB device strings: Mfr=3D1, Product=3D=
2,
>> SerialNumber=3D3 [ =A0 73.817169] usb 3-1: Product: SDW-190W2-M5T-XX=
X-XX-PRD
>> [ =A0 73.817171] usb 3-1: Manufacturer: Baanto
>> [ =A0 73.817173] usb 3-1: SerialNumber: SDW190W2M5T
>>
>> On 3.0 on the other hand it actually registered multiple HID devices=
, which
>> is what I think should happen with this device, because it's datashe=
et
>> says this:
>>
>> """
>> The mid-size family of touch screens, when enumerated on the OS, exp=
ose 5
>> top level USB HID collections. The following table describes these i=
n
>> detail: following table describes these in detail:
>>
>> Collection Description
>> ----------------------
>> Win 7 Touch Collection
>> Microsoft Device Configuration Collection
>> Generic Mouse Collection
>> Generic Pointer Collection
>> Baanto Touch (Custom HID) Collection
>>
>> Report Data
>> -----------
>> Multi Touch Packets
>> Control Packets
>> N\A =96 Future Use
>> Single Touch Packet
>> Multi Touch Packets\Control Packets
>> """
>>
>> Any ideas who is at fault here?
>>
>> Thanks,
>>
>> Tvrtko
>>
>>
>> Bus 003 Device 003: ID 2453:0100
>> Device Descriptor:
>> =A0 bLength =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A018
>> =A0 bDescriptorType =A0 =A0 =A0 =A0 1
>> =A0 bcdUSB =A0 =A0 =A0 =A0 =A0 =A0 =A0 2.00
>> =A0 bDeviceClass =A0 =A0 =A0 =A0 =A0 =A00 (Defined at Interface leve=
l)
>> =A0 bDeviceSubClass =A0 =A0 =A0 =A0 0
>> =A0 bDeviceProtocol =A0 =A0 =A0 =A0 0
>> =A0 bMaxPacketSize0 =A0 =A0 =A0 =A064
>> =A0 idVendor =A0 =A0 =A0 =A0 =A0 0x2453
>> =A0 idProduct =A0 =A0 =A0 =A0 =A00x0100
>> =A0 bcdDevice =A0 =A0 =A0 =A0 =A0 =A04.0c
>> =A0 iManufacturer =A0 =A0 =A0 =A0 =A0 1 Baanto
>> =A0 iProduct =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A02 SDW-190W2-M5T-XXX-XX-P=
RD
>> =A0 iSerial =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 3 SDW190W2M5T
>> =A0 bNumConfigurations =A0 =A0 =A01
>> =A0 Configuration Descriptor:
>> =A0 =A0 bLength =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 9
>> =A0 =A0 bDescriptorType =A0 =A0 =A0 =A0 2
>> =A0 =A0 wTotalLength =A0 =A0 =A0 =A0 =A0 34
>> =A0 =A0 bNumInterfaces =A0 =A0 =A0 =A0 =A01
>> =A0 =A0 bConfigurationValue =A0 =A0 1
>> =A0 =A0 iConfiguration =A0 =A0 =A0 =A0 =A00
>> =A0 =A0 bmAttributes =A0 =A0 =A0 =A0 0xc0
>> =A0 =A0 =A0 Self Powered
>> =A0 =A0 MaxPower =A0 =A0 =A0 =A0 =A0 =A0 =A0500mA
>> =A0 =A0 Interface Descriptor:
>> =A0 =A0 =A0 bLength =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 9
>> =A0 =A0 =A0 bDescriptorType =A0 =A0 =A0 =A0 4
>> =A0 =A0 =A0 bInterfaceNumber =A0 =A0 =A0 =A00
>> =A0 =A0 =A0 bAlternateSetting =A0 =A0 =A0 0
>> =A0 =A0 =A0 bNumEndpoints =A0 =A0 =A0 =A0 =A0 1
>> =A0 =A0 =A0 bInterfaceClass =A0 =A0 =A0 =A0 3 Human Interface Device
>> =A0 =A0 =A0 bInterfaceSubClass =A0 =A0 =A00 No Subclass
>> =A0 =A0 =A0 bInterfaceProtocol =A0 =A0 =A00 None
>> =A0 =A0 =A0 iInterface =A0 =A0 =A0 =A0 =A0 =A0 =A00
>> =A0 =A0 =A0 =A0 HID Device Descriptor:
>> =A0 =A0 =A0 =A0 =A0 bLength =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 9
>> =A0 =A0 =A0 =A0 =A0 bDescriptorType =A0 =A0 =A0 =A033
>> =A0 =A0 =A0 =A0 =A0 bcdHID =A0 =A0 =A0 =A0 =A0 =A0 =A0 1.10
>> =A0 =A0 =A0 =A0 =A0 bCountryCode =A0 =A0 =A0 =A0 =A0 33 US
>> =A0 =A0 =A0 =A0 =A0 bNumDescriptors =A0 =A0 =A0 =A0 1
>> =A0 =A0 =A0 =A0 =A0 bDescriptorType =A0 =A0 =A0 =A034 Report
>> =A0 =A0 =A0 =A0 =A0 wDescriptorLength =A0 =A0 759
>> =A0 =A0 =A0 =A0 =A0Report Descriptors:
>> =A0 =A0 =A0 =A0 =A0 =A0** UNAVAILABLE **
>> =A0 =A0 =A0 Endpoint Descriptor:
>> =A0 =A0 =A0 =A0 bLength =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 7
>> =A0 =A0 =A0 =A0 bDescriptorType =A0 =A0 =A0 =A0 5
>> =A0 =A0 =A0 =A0 bEndpointAddress =A0 =A0 0x81 =A0EP 1 IN
>> =A0 =A0 =A0 =A0 bmAttributes =A0 =A0 =A0 =A0 =A0 =A03
>> =A0 =A0 =A0 =A0 =A0 Transfer Type =A0 =A0 =A0 =A0 =A0 =A0Interrupt
>> =A0 =A0 =A0 =A0 =A0 Synch Type =A0 =A0 =A0 =A0 =A0 =A0 =A0 None
>> =A0 =A0 =A0 =A0 =A0 Usage Type =A0 =A0 =A0 =A0 =A0 =A0 =A0 Data
>> =A0 =A0 =A0 =A0 wMaxPacketSize =A0 =A0 0x0040 =A01x 64 bytes
>> =A0 =A0 =A0 =A0 bInterval =A0 =A0 =A0 =A0 =A0 =A0 =A0 1
>> Device Status: =A0 =A0 0x0001
>> =A0 Self Powered
>
> This is all I see with HID debugging turned on (3.3.0) after plugging=
 in the device:
>
> [85409.156718] drivers/hid/usbhid/hid-core.c: HID probe called for if=
num 0
> [85409.176184] drivers/hid/usbhid/hid-core.c: submitting ctrl urb: Ge=
t_Report wValue=3D0x0123 wIndex=3D0x0000 wLength=3D56
> [85409.177652] drivers/hid/usbhid/hid-core.c: submitting ctrl urb: Ge=
t_Report wValue=3D0x0125 wIndex=3D0x0000 wLength=3D6
> [85409.179649] drivers/hid/usbhid/hid-core.c: submitting ctrl urb: Ge=
t_Report wValue=3D0x0110 wIndex=3D0x0000 wLength=3D6
> [85409.181639] drivers/hid/usbhid/hid-core.c: submitting ctrl urb: Ge=
t_Report wValue=3D0x0109 wIndex=3D0x0000 wLength=3D64
> [85409.183636] drivers/hid/usbhid/hid-core.c: submitting ctrl urb: Ge=
t_Report wValue=3D0x010f wIndex=3D0x0000 wLength=3D64
> [85409.185634] drivers/hid/usbhid/hid-core.c: submitting ctrl urb: Ge=
t_Report wValue=3D0x010b wIndex=3D0x0000 wLength=3D64
> [85409.187639] drivers/hid/usbhid/hid-core.c: submitting ctrl urb: Ge=
t_Report wValue=3D0x010c wIndex=3D0x0000 wLength=3D64
> [85409.189633] drivers/hid/usbhid/hid-core.c: submitting ctrl urb: Ge=
t_Report wValue=3D0x010d wIndex=3D0x0000 wLength=3D64
> [85409.191628] drivers/hid/usbhid/hid-core.c: submitting ctrl urb: Ge=
t_Report wValue=3D0x0324 wIndex=3D0x0000 wLength=3D2
> [85409.194619] drivers/hid/usbhid/hid-core.c: submitting ctrl urb: Ge=
t_Report wValue=3D0x0327 wIndex=3D0x0000 wLength=3D3
> [85409.196621] drivers/hid/usbhid/hid-core.c: submitting ctrl urb: Ge=
t_Report wValue=3D0x0302 wIndex=3D0x0000 wLength=3D4
> [85409.199617] drivers/hid/usbhid/hid-core.c: submitting ctrl urb: Ge=
t_Report wValue=3D0x0303 wIndex=3D0x0000 wLength=3D13
> [85409.202615] drivers/hid/usbhid/hid-core.c: submitting ctrl urb: Ge=
t_Report wValue=3D0x0304 wIndex=3D0x0000 wLength=3D13
> [85409.205606] drivers/hid/usbhid/hid-core.c: submitting ctrl urb: Ge=
t_Report wValue=3D0x0305 wIndex=3D0x0000 wLength=3D3
> [85409.208601] drivers/hid/usbhid/hid-core.c: submitting ctrl urb: Ge=
t_Report wValue=3D0x0355 wIndex=3D0x0000 wLength=3D2
> [85409.210603] drivers/hid/usbhid/hid-core.c: submitting ctrl urb: Ge=
t_Report wValue=3D0x0377 wIndex=3D0x0000 wLength=3D2
> [85409.212604] drivers/hid/usbhid/hid-core.c: submitting ctrl urb: Ge=
t_Report wValue=3D0x0366 wIndex=3D0x0000 wLength=3D2
> [85409.214597] drivers/hid/usbhid/hid-core.c: submitting ctrl urb: Ge=
t_Report wValue=3D0x0388 wIndex=3D0x0000 wLength=3D2
> [85409.216593] drivers/hid/usbhid/hid-core.c: submitting ctrl urb: Ge=
t_Report wValue=3D0x0344 wIndex=3D0x0000 wLength=3D2
>
> No input device of any kind registered after this point.
>
> Hints about what is going wrong?
>
> Tvrtko
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input=
" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
