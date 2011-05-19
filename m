From: Benjamin Tissoires <benjamin.tissoires@enac.fr>
Subject: Re: [PATCH] hid-multitouch: Add support for Lumio panels
Date: Fri, 20 May 2011 00:37:05 +0200
Message-ID: <BANLkTikPXHswWQqQHqd8fegotqoZPLErsQ@mail.gmail.com>
References: <1305725244-5327-1-git-send-email-benjamin.tissoires@enac.fr>
	<87boyyo0gr.fsf@macbook.be.48ers.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:44095 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754538Ab1ESWhH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 19 May 2011 18:37:07 -0400
In-Reply-To: <87boyyo0gr.fsf@macbook.be.48ers.dk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Peter Korsgaard <jacmet@sunsite.dk>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Henrik Rydberg <rydberg@euromail.se>, Jiri Kosina <jkosina@suse.cz>, Stephane Chatty <chatty@lii-enac.fr>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Peter,

your device presents Contact ID, Tip Switch, In Range and Confidence.
I would say that Win 7 would treat it as a multitouch screen, so this
might work with hid-multitouch. Please note that's the first time I
see a report descriptor with only one touch reported for a multitouch
screen.

=46or the configuration, the device may emulate a mouse by default, and
hid-multitouch is able to switch to the multitouch mode. You will
loose the right click, but it can be enabled in gnome at least
(accessibility settings).

Can you just replace in hid-ids.h:
- #define USB_DEVICE_ID_CRYSTALTOUCH  0x0006
+ #define USB_DEVICE_ID_CRYSTALTOUCH  0x0005

and see if it's working?
If you prefer, I can make a new patch, but I'll need to know which
kernel you are running (tree and branch). A 2.6.39 and above would be
great.

Cheers,
Benjamin

On Thu, May 19, 2011 at 23:16, Peter Korsgaard <jacmet@sunsite.dk> wrot=
e:
>>>>>> "Benjamin" =3D=3D Benjamin Tissoires <benjamin.tissoires@enac.fr=
> writes:
>
> =A0Benjamin> This patch enables support for Lumio optical devices.
> =A0Benjamin> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@en=
ac.fr>
>
> =A0Benjamin> diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids=
=2Eh
> =A0Benjamin> index 2e46eb2..a8c46b0 100644
> =A0Benjamin> --- a/drivers/hid/hid-ids.h
> =A0Benjamin> +++ b/drivers/hid/hid-ids.h
> =A0Benjamin> @@ -411,6 +411,9 @@
> =A0Benjamin> =A0#define USB_DEVICE_ID_DINOVO_MINI =A0 0xc71f
> =A0Benjamin> =A0#define USB_DEVICE_ID_LOGITECH_MOMO_WHEEL2 =A00xca03
>
> =A0Benjamin> +#define USB_VENDOR_ID_LUMIO =A0 =A0 =A0 =A0 0x202e
> =A0Benjamin> +#define USB_DEVICE_ID_CRYSTALTOUCH =A00x0006
> =A0Benjamin> +
>
> Does this require any special configuration of the touchscreen
> controller? I have a 202e:0005 device which afaik normally doesn't se=
nd
> any multi touch events.
>
> HID descriptors:
>
> Bus 001 Device 021: ID 202e:0005
> Device Descriptor:
> =A0bLength =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A018
> =A0bDescriptorType =A0 =A0 =A0 =A0 1
> =A0bcdUSB =A0 =A0 =A0 =A0 =A0 =A0 =A0 2.00
> =A0bDeviceClass =A0 =A0 =A0 =A0 =A0 =A00 (Defined at Interface level)
> =A0bDeviceSubClass =A0 =A0 =A0 =A0 0
> =A0bDeviceProtocol =A0 =A0 =A0 =A0 0
> =A0bMaxPacketSize0 =A0 =A0 =A0 =A064
> =A0idVendor =A0 =A0 =A0 =A0 =A0 0x202e
> =A0idProduct =A0 =A0 =A0 =A0 =A00x0005
> =A0bcdDevice =A0 =A0 =A0 =A0 =A0 =A02.00
> =A0iManufacturer =A0 =A0 =A0 =A0 =A0 1 LUMIO Inc
> =A0iProduct =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A02 LUMIO CrystalTouch ver 1=
=2E1C
> =A0iSerial =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0
> =A0bNumConfigurations =A0 =A0 =A01
> =A0Configuration Descriptor:
> =A0 =A0bLength =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 9
> =A0 =A0bDescriptorType =A0 =A0 =A0 =A0 2
> =A0 =A0wTotalLength =A0 =A0 =A0 =A0 =A0116
> =A0 =A0bNumInterfaces =A0 =A0 =A0 =A0 =A04
> =A0 =A0bConfigurationValue =A0 =A0 1
> =A0 =A0iConfiguration =A0 =A0 =A0 =A0 =A00
> =A0 =A0bmAttributes =A0 =A0 =A0 =A0 0x80
> =A0 =A0 =A0(Bus Powered)
> =A0 =A0MaxPower =A0 =A0 =A0 =A0 =A0 =A0 =A0500mA
> =A0 =A0Interface Descriptor:
> =A0 =A0 =A0bLength =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 9
> =A0 =A0 =A0bDescriptorType =A0 =A0 =A0 =A0 4
> =A0 =A0 =A0bInterfaceNumber =A0 =A0 =A0 =A00
> =A0 =A0 =A0bAlternateSetting =A0 =A0 =A0 0
> =A0 =A0 =A0bNumEndpoints =A0 =A0 =A0 =A0 =A0 2
> =A0 =A0 =A0bInterfaceClass =A0 =A0 =A0 =A0 3 Human Interface Device
> =A0 =A0 =A0bInterfaceSubClass =A0 =A0 =A00 No Subclass
> =A0 =A0 =A0bInterfaceProtocol =A0 =A0 =A00 None
> =A0 =A0 =A0iInterface =A0 =A0 =A0 =A0 =A0 =A0 =A00
> =A0 =A0 =A0 =A0HID Device Descriptor:
> =A0 =A0 =A0 =A0 =A0bLength =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 9
> =A0 =A0 =A0 =A0 =A0bDescriptorType =A0 =A0 =A0 =A033
> =A0 =A0 =A0 =A0 =A0bcdHID =A0 =A0 =A0 =A0 =A0 =A0 =A0 1.10
> =A0 =A0 =A0 =A0 =A0bCountryCode =A0 =A0 =A0 =A0 =A0 =A00 Not supporte=
d
> =A0 =A0 =A0 =A0 =A0bNumDescriptors =A0 =A0 =A0 =A0 1
> =A0 =A0 =A0 =A0 =A0bDescriptorType =A0 =A0 =A0 =A034 Report
> =A0 =A0 =A0 =A0 =A0wDescriptorLength =A0 =A0 =A038
> =A0 =A0 =A0 =A0 =A0Report Descriptor: (length is 38)
> =A0 =A0 =A0 =A0 =A0 =A0Item(Global): Usage Page, data=3D [ 0xa0 0xff =
] 65440
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(null)
> =A0 =A0 =A0 =A0 =A0 =A0Item(Local ): Usage, data=3D [ 0x05 ] 5
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(null)
> =A0 =A0 =A0 =A0 =A0 =A0Item(Main =A0): Collection, data=3D [ 0x01 ] 1
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Application
> =A0 =A0 =A0 =A0 =A0 =A0Item(Local ): Usage, data=3D [ 0xa6 ] 166
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(null)
> =A0 =A0 =A0 =A0 =A0 =A0Item(Local ): Usage, data=3D [ 0xa7 ] 167
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(null)
> =A0 =A0 =A0 =A0 =A0 =A0Item(Global): Logical Minimum, data=3D [ 0x80 =
] 128
> =A0 =A0 =A0 =A0 =A0 =A0Item(Global): Logical Maximum, data=3D [ 0x7f =
] 127
> =A0 =A0 =A0 =A0 =A0 =A0Item(Global): Report Size, data=3D [ 0x08 ] 8
> =A0 =A0 =A0 =A0 =A0 =A0Item(Global): Report Count, data=3D [ 0x40 ] 6=
4
> =A0 =A0 =A0 =A0 =A0 =A0Item(Main =A0): Input, data=3D [ 0x02 ] 2
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Data Variable =
Absolute No_Wrap Linear
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Preferred_Stat=
e No_Null_Position Non_Volatile Bitfield
> =A0 =A0 =A0 =A0 =A0 =A0Item(Local ): Usage, data=3D [ 0x33 ] 51
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(null)
> =A0 =A0 =A0 =A0 =A0 =A0Item(Global): Report Size, data=3D [ 0x08 ] 8
> =A0 =A0 =A0 =A0 =A0 =A0Item(Global): Report Count, data=3D [ 0x40 ] 6=
4
> =A0 =A0 =A0 =A0 =A0 =A0Item(Main =A0): Output, data=3D [ 0x00 ] 0
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Data Array Abs=
olute No_Wrap Linear
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Preferred_Stat=
e No_Null_Position Non_Volatile Bitfield
> =A0 =A0 =A0 =A0 =A0 =A0Item(Local ): Usage, data=3D [ 0x33 ] 51
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(null)
> =A0 =A0 =A0 =A0 =A0 =A0Item(Global): Report Size, data=3D [ 0x08 ] 8
> =A0 =A0 =A0 =A0 =A0 =A0Item(Global): Report Count, data=3D [ 0x08 ] 8
> =A0 =A0 =A0 =A0 =A0 =A0Item(Main =A0): Feature, data=3D [ 0x00 ] 0
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Data Array Abs=
olute No_Wrap Linear
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Preferred_Stat=
e No_Null_Position Non_Volatile Bitfield
> =A0 =A0 =A0 =A0 =A0 =A0Item(Main =A0): End Collection, data=3Dnone
> =A0 =A0 =A0Endpoint Descriptor:
> =A0 =A0 =A0 =A0bLength =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 7
> =A0 =A0 =A0 =A0bDescriptorType =A0 =A0 =A0 =A0 5
> =A0 =A0 =A0 =A0bEndpointAddress =A0 =A0 0x81 =A0EP 1 IN
> =A0 =A0 =A0 =A0bmAttributes =A0 =A0 =A0 =A0 =A0 =A03
> =A0 =A0 =A0 =A0 =A0Transfer Type =A0 =A0 =A0 =A0 =A0 =A0Interrupt
> =A0 =A0 =A0 =A0 =A0Synch Type =A0 =A0 =A0 =A0 =A0 =A0 =A0 None
> =A0 =A0 =A0 =A0 =A0Usage Type =A0 =A0 =A0 =A0 =A0 =A0 =A0 Data
> =A0 =A0 =A0 =A0wMaxPacketSize =A0 =A0 0x0040 =A01x 64 bytes
> =A0 =A0 =A0 =A0bInterval =A0 =A0 =A0 =A0 =A0 =A0 =A0 2
> =A0 =A0 =A0Endpoint Descriptor:
> =A0 =A0 =A0 =A0bLength =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 7
> =A0 =A0 =A0 =A0bDescriptorType =A0 =A0 =A0 =A0 5
> =A0 =A0 =A0 =A0bEndpointAddress =A0 =A0 0x02 =A0EP 2 OUT
> =A0 =A0 =A0 =A0bmAttributes =A0 =A0 =A0 =A0 =A0 =A03
> =A0 =A0 =A0 =A0 =A0Transfer Type =A0 =A0 =A0 =A0 =A0 =A0Interrupt
> =A0 =A0 =A0 =A0 =A0Synch Type =A0 =A0 =A0 =A0 =A0 =A0 =A0 None
> =A0 =A0 =A0 =A0 =A0Usage Type =A0 =A0 =A0 =A0 =A0 =A0 =A0 Data
> =A0 =A0 =A0 =A0wMaxPacketSize =A0 =A0 0x0040 =A01x 64 bytes
> =A0 =A0 =A0 =A0bInterval =A0 =A0 =A0 =A0 =A0 =A0 =A0 2
> =A0 =A0Interface Descriptor:
> =A0 =A0 =A0bLength =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 9
> =A0 =A0 =A0bDescriptorType =A0 =A0 =A0 =A0 4
> =A0 =A0 =A0bInterfaceNumber =A0 =A0 =A0 =A01
> =A0 =A0 =A0bAlternateSetting =A0 =A0 =A0 0
> =A0 =A0 =A0bNumEndpoints =A0 =A0 =A0 =A0 =A0 1
> =A0 =A0 =A0bInterfaceClass =A0 =A0 =A0 =A0 3 Human Interface Device
> =A0 =A0 =A0bInterfaceSubClass =A0 =A0 =A00 No Subclass
> =A0 =A0 =A0bInterfaceProtocol =A0 =A0 =A00 None
> =A0 =A0 =A0iInterface =A0 =A0 =A0 =A0 =A0 =A0 =A00
> =A0 =A0 =A0 =A0HID Device Descriptor:
> =A0 =A0 =A0 =A0 =A0bLength =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 9
> =A0 =A0 =A0 =A0 =A0bDescriptorType =A0 =A0 =A0 =A033
> =A0 =A0 =A0 =A0 =A0bcdHID =A0 =A0 =A0 =A0 =A0 =A0 =A0 1.11
> =A0 =A0 =A0 =A0 =A0bCountryCode =A0 =A0 =A0 =A0 =A0 =A00 Not supporte=
d
> =A0 =A0 =A0 =A0 =A0bNumDescriptors =A0 =A0 =A0 =A0 1
> =A0 =A0 =A0 =A0 =A0bDescriptorType =A0 =A0 =A0 =A034 Report
> =A0 =A0 =A0 =A0 =A0wDescriptorLength =A0 =A0 =A064
> =A0 =A0 =A0 =A0 =A0Report Descriptor: (length is 64)
> =A0 =A0 =A0 =A0 =A0 =A0Item(Global): Usage Page, data=3D [ 0x01 ] 1
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Generic Deskto=
p Controls
> =A0 =A0 =A0 =A0 =A0 =A0Item(Local ): Usage, data=3D [ 0x06 ] 6
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Keyboard
> =A0 =A0 =A0 =A0 =A0 =A0Item(Main =A0): Collection, data=3D [ 0x01 ] 1
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Application
> =A0 =A0 =A0 =A0 =A0 =A0Item(Global): Usage Page, data=3D [ 0x07 ] 7
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Keyboard
> =A0 =A0 =A0 =A0 =A0 =A0Item(Local ): Usage Minimum, data=3D [ 0xe0 ] =
224
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Control Left
> =A0 =A0 =A0 =A0 =A0 =A0Item(Local ): Usage Maximum, data=3D [ 0xe7 ] =
231
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0GUI Right
> =A0 =A0 =A0 =A0 =A0 =A0Item(Global): Logical Minimum, data=3D [ 0x00 =
] 0
> =A0 =A0 =A0 =A0 =A0 =A0Item(Global): Logical Maximum, data=3D [ 0x01 =
] 1
> =A0 =A0 =A0 =A0 =A0 =A0Item(Global): Report Size, data=3D [ 0x01 ] 1
> =A0 =A0 =A0 =A0 =A0 =A0Item(Global): Report Count, data=3D [ 0x08 ] 8
> =A0 =A0 =A0 =A0 =A0 =A0Item(Main =A0): Input, data=3D [ 0x02 ] 2
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Data Variable =
Absolute No_Wrap Linear
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Preferred_Stat=
e No_Null_Position Non_Volatile Bitfield
> =A0 =A0 =A0 =A0 =A0 =A0Item(Global): Report Count, data=3D [ 0x01 ] 1
> =A0 =A0 =A0 =A0 =A0 =A0Item(Global): Report Size, data=3D [ 0x08 ] 8
> =A0 =A0 =A0 =A0 =A0 =A0Item(Main =A0): Input, data=3D [ 0x03 ] 3
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Constant Varia=
ble Absolute No_Wrap Linear
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Preferred_Stat=
e No_Null_Position Non_Volatile Bitfield
> =A0 =A0 =A0 =A0 =A0 =A0Item(Global): Report Count, data=3D [ 0x05 ] 5
> =A0 =A0 =A0 =A0 =A0 =A0Item(Global): Report Size, data=3D [ 0x01 ] 1
> =A0 =A0 =A0 =A0 =A0 =A0Item(Global): Report Count, data=3D [ 0x06 ] 6
> =A0 =A0 =A0 =A0 =A0 =A0Item(Global): Report Size, data=3D [ 0x08 ] 8
> =A0 =A0 =A0 =A0 =A0 =A0Item(Global): Logical Minimum, data=3D [ 0x00 =
] 0
> =A0 =A0 =A0 =A0 =A0 =A0Item(Global): Logical Maximum, data=3D [ 0x65 =
] 101
> =A0 =A0 =A0 =A0 =A0 =A0Item(Global): Usage Page, data=3D [ 0x07 ] 7
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Keyboard
> =A0 =A0 =A0 =A0 =A0 =A0Item(Local ): Usage Minimum, data=3D [ 0x00 ] =
0
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0No Event
> =A0 =A0 =A0 =A0 =A0 =A0Item(Local ): Usage Maximum, data=3D [ 0x65 ] =
101
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Keyboard Appli=
cation (Windows Key for Win95 or Compose)
> =A0 =A0 =A0 =A0 =A0 =A0Item(Main =A0): Input, data=3D [ 0x00 ] 0
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Data Array Abs=
olute No_Wrap Linear
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Preferred_Stat=
e No_Null_Position Non_Volatile Bitfield
> =A0 =A0 =A0 =A0 =A0 =A0Item(Global): Usage Page, data=3D [ 0xa0 0xff =
] 65440
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(null)
> =A0 =A0 =A0 =A0 =A0 =A0Item(Local ): Usage, data=3D [ 0xa5 ] 165
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(null)
> =A0 =A0 =A0 =A0 =A0 =A0Item(Global): Logical Minimum, data=3D [ 0x80 =
] 128
> =A0 =A0 =A0 =A0 =A0 =A0Item(Global): Logical Maximum, data=3D [ 0x7f =
] 127
> =A0 =A0 =A0 =A0 =A0 =A0Item(Global): Report Size, data=3D [ 0x08 ] 8
> =A0 =A0 =A0 =A0 =A0 =A0Item(Global): Report Count, data=3D [ 0x08 ] 8
> =A0 =A0 =A0 =A0 =A0 =A0Item(Main =A0): Feature, data=3D [ 0x02 ] 2
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Data Variable =
Absolute No_Wrap Linear
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Preferred_Stat=
e No_Null_Position Non_Volatile Bitfield
> =A0 =A0 =A0 =A0 =A0 =A0Item(Main =A0): End Collection, data=3Dnone
> =A0 =A0 =A0Endpoint Descriptor:
> =A0 =A0 =A0 =A0bLength =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 7
> =A0 =A0 =A0 =A0bDescriptorType =A0 =A0 =A0 =A0 5
> =A0 =A0 =A0 =A0bEndpointAddress =A0 =A0 0x86 =A0EP 6 IN
> =A0 =A0 =A0 =A0bmAttributes =A0 =A0 =A0 =A0 =A0 =A03
> =A0 =A0 =A0 =A0 =A0Transfer Type =A0 =A0 =A0 =A0 =A0 =A0Interrupt
> =A0 =A0 =A0 =A0 =A0Synch Type =A0 =A0 =A0 =A0 =A0 =A0 =A0 None
> =A0 =A0 =A0 =A0 =A0Usage Type =A0 =A0 =A0 =A0 =A0 =A0 =A0 Data
> =A0 =A0 =A0 =A0wMaxPacketSize =A0 =A0 0x0008 =A01x 8 bytes
> =A0 =A0 =A0 =A0bInterval =A0 =A0 =A0 =A0 =A0 =A0 =A0 1
> =A0 =A0Interface Descriptor:
> =A0 =A0 =A0bLength =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 9
> =A0 =A0 =A0bDescriptorType =A0 =A0 =A0 =A0 4
> =A0 =A0 =A0bInterfaceNumber =A0 =A0 =A0 =A02
> =A0 =A0 =A0bAlternateSetting =A0 =A0 =A0 0
> =A0 =A0 =A0bNumEndpoints =A0 =A0 =A0 =A0 =A0 1
> =A0 =A0 =A0bInterfaceClass =A0 =A0 =A0 =A0 3 Human Interface Device
> =A0 =A0 =A0bInterfaceSubClass =A0 =A0 =A00 No Subclass
> =A0 =A0 =A0bInterfaceProtocol =A0 =A0 =A00 None
> =A0 =A0 =A0iInterface =A0 =A0 =A0 =A0 =A0 =A0 =A00
> =A0 =A0 =A0 =A0HID Device Descriptor:
> =A0 =A0 =A0 =A0 =A0bLength =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 9
> =A0 =A0 =A0 =A0 =A0bDescriptorType =A0 =A0 =A0 =A033
> =A0 =A0 =A0 =A0 =A0bcdHID =A0 =A0 =A0 =A0 =A0 =A0 =A0 1.11
> =A0 =A0 =A0 =A0 =A0bCountryCode =A0 =A0 =A0 =A0 =A0 =A00 Not supporte=
d
> =A0 =A0 =A0 =A0 =A0bNumDescriptors =A0 =A0 =A0 =A0 1
> =A0 =A0 =A0 =A0 =A0bDescriptorType =A0 =A0 =A0 =A034 Report
> =A0 =A0 =A0 =A0 =A0wDescriptorLength =A0 =A0 =A085
> =A0 =A0 =A0 =A0 =A0Report Descriptor: (length is 85)
> =A0 =A0 =A0 =A0 =A0 =A0Item(Global): Usage Page, data=3D [ 0x01 ] 1
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Generic Deskto=
p Controls
> =A0 =A0 =A0 =A0 =A0 =A0Item(Local ): Usage, data=3D [ 0x02 ] 2
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Mouse
> =A0 =A0 =A0 =A0 =A0 =A0Item(Main =A0): Collection, data=3D [ 0x01 ] 1
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Application
> =A0 =A0 =A0 =A0 =A0 =A0Item(Local ): Usage, data=3D [ 0x01 ] 1
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Pointer
> =A0 =A0 =A0 =A0 =A0 =A0Item(Main =A0): Collection, data=3D [ 0x00 ] 0
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Physical
> =A0 =A0 =A0 =A0 =A0 =A0Item(Global): Usage Page, data=3D [ 0x09 ] 9
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Buttons
> =A0 =A0 =A0 =A0 =A0 =A0Item(Local ): Usage Minimum, data=3D [ 0x01 ] =
1
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Button 1 (Prim=
ary)
> =A0 =A0 =A0 =A0 =A0 =A0Item(Local ): Usage Maximum, data=3D [ 0x03 ] =
3
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Button 3 (Tert=
iary)
> =A0 =A0 =A0 =A0 =A0 =A0Item(Global): Logical Minimum, data=3D [ 0x00 =
] 0
> =A0 =A0 =A0 =A0 =A0 =A0Item(Global): Logical Maximum, data=3D [ 0x01 =
] 1
> =A0 =A0 =A0 =A0 =A0 =A0Item(Global): Report Count, data=3D [ 0x03 ] 3
> =A0 =A0 =A0 =A0 =A0 =A0Item(Global): Report Size, data=3D [ 0x01 ] 1
> =A0 =A0 =A0 =A0 =A0 =A0Item(Main =A0): Input, data=3D [ 0x02 ] 2
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Data Variable =
Absolute No_Wrap Linear
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Preferred_Stat=
e No_Null_Position Non_Volatile Bitfield
> =A0 =A0 =A0 =A0 =A0 =A0Item(Global): Report Count, data=3D [ 0x01 ] 1
> =A0 =A0 =A0 =A0 =A0 =A0Item(Global): Report Size, data=3D [ 0x05 ] 5
> =A0 =A0 =A0 =A0 =A0 =A0Item(Main =A0): Input, data=3D [ 0x01 ] 1
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Constant Array=
 Absolute No_Wrap Linear
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Preferred_Stat=
e No_Null_Position Non_Volatile Bitfield
> =A0 =A0 =A0 =A0 =A0 =A0Item(Global): Usage Page, data=3D [ 0x01 ] 1
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Generic Deskto=
p Controls
> =A0 =A0 =A0 =A0 =A0 =A0Item(Local ): Usage, data=3D [ 0x30 ] 48
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Direction-X
> =A0 =A0 =A0 =A0 =A0 =A0Item(Local ): Usage, data=3D [ 0x31 ] 49
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Direction-Y
> =A0 =A0 =A0 =A0 =A0 =A0Item(Global): Logical Minimum, data=3D [ 0x00 =
0x00 ] 0
> =A0 =A0 =A0 =A0 =A0 =A0Item(Global): Logical Maximum, data=3D [ 0xff =
0x0f ] 4095
> =A0 =A0 =A0 =A0 =A0 =A0Item(Global): Physical Minimum, data=3D [ 0x00=
 0x00 ] 0
> =A0 =A0 =A0 =A0 =A0 =A0Item(Global): Physical Maximum, data=3D [ 0xff=
 0x7f ] 32767
> =A0 =A0 =A0 =A0 =A0 =A0Item(Global): Unit, data=3D [ 0x00 0x00 ] 0
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0System: None, =
Unit: (None)
> =A0 =A0 =A0 =A0 =A0 =A0Item(Global): Report Size, data=3D [ 0x10 ] 16
> =A0 =A0 =A0 =A0 =A0 =A0Item(Global): Report Count, data=3D [ 0x02 ] 2
> =A0 =A0 =A0 =A0 =A0 =A0Item(Main =A0): Input, data=3D [ 0x62 ] 98
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Data Variable =
Absolute No_Wrap Linear
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0No_Preferred_S=
tate Null_State Non_Volatile Bitfield
> =A0 =A0 =A0 =A0 =A0 =A0Item(Global): Usage Page, data=3D [ 0x01 ] 1
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Generic Deskto=
p Controls
> =A0 =A0 =A0 =A0 =A0 =A0Item(Local ): Usage, data=3D [ 0x88 ] 136
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0System Menu Ex=
it
> =A0 =A0 =A0 =A0 =A0 =A0Item(Global): Logical Minimum, data=3D [ 0x81 =
] 129
> =A0 =A0 =A0 =A0 =A0 =A0Item(Global): Logical Maximum, data=3D [ 0x7f =
] 127
> =A0 =A0 =A0 =A0 =A0 =A0Item(Global): Report Size, data=3D [ 0x08 ] 8
> =A0 =A0 =A0 =A0 =A0 =A0Item(Global): Report Count, data=3D [ 0x01 ] 1
> =A0 =A0 =A0 =A0 =A0 =A0Item(Main =A0): Input, data=3D [ 0x06 ] 6
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Data Variable =
Relative No_Wrap Linear
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Preferred_Stat=
e No_Null_Position Non_Volatile Bitfield
> =A0 =A0 =A0 =A0 =A0 =A0Item(Global): Usage Page, data=3D [ 0xff ] 255
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Vendor Specifi=
c
> =A0 =A0 =A0 =A0 =A0 =A0Item(Local ): Usage, data=3D [ 0x02 ] 2
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(null)
> =A0 =A0 =A0 =A0 =A0 =A0Item(Global): Report Count, data=3D [ 0x02 ] 2
> =A0 =A0 =A0 =A0 =A0 =A0Item(Global): Report Size, data=3D [ 0x08 ] 8
> =A0 =A0 =A0 =A0 =A0 =A0Item(Main =A0): Input, data=3D [ 0x01 ] 1
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Constant Array=
 Absolute No_Wrap Linear
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Preferred_Stat=
e No_Null_Position Non_Volatile Bitfield
> =A0 =A0 =A0 =A0 =A0 =A0Item(Main =A0): End Collection, data=3Dnone
> =A0 =A0 =A0 =A0 =A0 =A0Item(Main =A0): End Collection, data=3Dnone
> =A0 =A0 =A0Endpoint Descriptor:
> =A0 =A0 =A0 =A0bLength =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 7
> =A0 =A0 =A0 =A0bDescriptorType =A0 =A0 =A0 =A0 5
> =A0 =A0 =A0 =A0bEndpointAddress =A0 =A0 0x85 =A0EP 5 IN
> =A0 =A0 =A0 =A0bmAttributes =A0 =A0 =A0 =A0 =A0 =A03
> =A0 =A0 =A0 =A0 =A0Transfer Type =A0 =A0 =A0 =A0 =A0 =A0Interrupt
> =A0 =A0 =A0 =A0 =A0Synch Type =A0 =A0 =A0 =A0 =A0 =A0 =A0 None
> =A0 =A0 =A0 =A0 =A0Usage Type =A0 =A0 =A0 =A0 =A0 =A0 =A0 Data
> =A0 =A0 =A0 =A0wMaxPacketSize =A0 =A0 0x0008 =A01x 8 bytes
> =A0 =A0 =A0 =A0bInterval =A0 =A0 =A0 =A0 =A0 =A0 =A0 1
> =A0 =A0Interface Descriptor:
> =A0 =A0 =A0bLength =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 9
> =A0 =A0 =A0bDescriptorType =A0 =A0 =A0 =A0 4
> =A0 =A0 =A0bInterfaceNumber =A0 =A0 =A0 =A03
> =A0 =A0 =A0bAlternateSetting =A0 =A0 =A0 0
> =A0 =A0 =A0bNumEndpoints =A0 =A0 =A0 =A0 =A0 1
> =A0 =A0 =A0bInterfaceClass =A0 =A0 =A0 =A0 3 Human Interface Device
> =A0 =A0 =A0bInterfaceSubClass =A0 =A0 =A00 No Subclass
> =A0 =A0 =A0bInterfaceProtocol =A0 =A0 =A00 None
> =A0 =A0 =A0iInterface =A0 =A0 =A0 =A0 =A0 =A0 =A00
> =A0 =A0 =A0 =A0HID Device Descriptor:
> =A0 =A0 =A0 =A0 =A0bLength =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 9
> =A0 =A0 =A0 =A0 =A0bDescriptorType =A0 =A0 =A0 =A033
> =A0 =A0 =A0 =A0 =A0bcdHID =A0 =A0 =A0 =A0 =A0 =A0 =A0 1.11
> =A0 =A0 =A0 =A0 =A0bCountryCode =A0 =A0 =A0 =A0 =A0 =A00 Not supporte=
d
> =A0 =A0 =A0 =A0 =A0bNumDescriptors =A0 =A0 =A0 =A0 1
> =A0 =A0 =A0 =A0 =A0bDescriptorType =A0 =A0 =A0 =A034 Report
> =A0 =A0 =A0 =A0 =A0wDescriptorLength =A0 =A0 =A089
> =A0 =A0 =A0 =A0 =A0Report Descriptor: (length is 89)
> =A0 =A0 =A0 =A0 =A0 =A0Item(Global): Usage Page, data=3D [ 0x0d ] 13
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Digitizer
> =A0 =A0 =A0 =A0 =A0 =A0Item(Local ): Usage, data=3D [ 0x04 ] 4
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Touch Screen
> =A0 =A0 =A0 =A0 =A0 =A0Item(Main =A0): Collection, data=3D [ 0x01 ] 1
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Application
> =A0 =A0 =A0 =A0 =A0 =A0Item(Local ): Usage, data=3D [ 0x22 ] 34
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Finger
> =A0 =A0 =A0 =A0 =A0 =A0Item(Main =A0): Collection, data=3D [ 0x00 ] 0
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Physical
> =A0 =A0 =A0 =A0 =A0 =A0Item(Local ): Usage, data=3D [ 0x42 ] 66
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Tip Switch
> =A0 =A0 =A0 =A0 =A0 =A0Item(Global): Logical Minimum, data=3D [ 0x00 =
] 0
> =A0 =A0 =A0 =A0 =A0 =A0Item(Global): Logical Maximum, data=3D [ 0x01 =
] 1
> =A0 =A0 =A0 =A0 =A0 =A0Item(Global): Report Size, data=3D [ 0x01 ] 1
> =A0 =A0 =A0 =A0 =A0 =A0Item(Global): Report Count, data=3D [ 0x01 ] 1
> =A0 =A0 =A0 =A0 =A0 =A0Item(Main =A0): Input, data=3D [ 0x02 ] 2
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Data Variable =
Absolute No_Wrap Linear
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Preferred_Stat=
e No_Null_Position Non_Volatile Bitfield
> =A0 =A0 =A0 =A0 =A0 =A0Item(Global): Report Count, data=3D [ 0x03 ] 3
> =A0 =A0 =A0 =A0 =A0 =A0Item(Main =A0): Input, data=3D [ 0x03 ] 3
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Constant Varia=
ble Absolute No_Wrap Linear
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Preferred_Stat=
e No_Null_Position Non_Volatile Bitfield
> =A0 =A0 =A0 =A0 =A0 =A0Item(Local ): Usage, data=3D [ 0x32 ] 50
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0In Range
> =A0 =A0 =A0 =A0 =A0 =A0Item(Local ): Usage, data=3D [ 0x47 ] 71
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Confidence
> =A0 =A0 =A0 =A0 =A0 =A0Item(Global): Report Count, data=3D [ 0x02 ] 2
> =A0 =A0 =A0 =A0 =A0 =A0Item(Main =A0): Input, data=3D [ 0x02 ] 2
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Data Variable =
Absolute No_Wrap Linear
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Preferred_Stat=
e No_Null_Position Non_Volatile Bitfield
> =A0 =A0 =A0 =A0 =A0 =A0Item(Global): Report Count, data=3D [ 0x0a ] 1=
0
> =A0 =A0 =A0 =A0 =A0 =A0Item(Main =A0): Input, data=3D [ 0x03 ] 3
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Constant Varia=
ble Absolute No_Wrap Linear
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Preferred_Stat=
e No_Null_Position Non_Volatile Bitfield
> =A0 =A0 =A0 =A0 =A0 =A0Item(Global): Usage Page, data=3D [ 0x01 ] 1
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Generic Deskto=
p Controls
> =A0 =A0 =A0 =A0 =A0 =A0Item(Global): Logical Maximum, data=3D [ 0xff =
0x7f ] 32767
> =A0 =A0 =A0 =A0 =A0 =A0Item(Global): Unit, data=3D [ 0x11 ] 17
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0System: SI Lin=
ear, Unit: Centimeter
> =A0 =A0 =A0 =A0 =A0 =A0Item(Global): Unit Exponent, data=3D [ 0x0e ] =
14
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Unit Exponent:=
 14
> =A0 =A0 =A0 =A0 =A0 =A0Item(Global): Physical Maximum, data=3D [ 0x5d=
 0x14 ] 5213
> =A0 =A0 =A0 =A0 =A0 =A0Item(Global): Report Size, data=3D [ 0x10 ] 16
> =A0 =A0 =A0 =A0 =A0 =A0Item(Global): Report Count, data=3D [ 0x01 ] 1
> =A0 =A0 =A0 =A0 =A0 =A0Item(Local ): Usage, data=3D [ 0x30 ] 48
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Direction-X
> =A0 =A0 =A0 =A0 =A0 =A0Item(Main =A0): Input, data=3D [ 0x02 ] 2
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Data Variable =
Absolute No_Wrap Linear
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Preferred_Stat=
e No_Null_Position Non_Volatile Bitfield
> =A0 =A0 =A0 =A0 =A0 =A0Item(Local ): Usage, data=3D [ 0x31 ] 49
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Direction-Y
> =A0 =A0 =A0 =A0 =A0 =A0Item(Global): Physical Maximum, data=3D [ 0x75=
 0x0b ] 2933
> =A0 =A0 =A0 =A0 =A0 =A0Item(Main =A0): Input, data=3D [ 0x02 ] 2
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Data Variable =
Absolute No_Wrap Linear
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Preferred_Stat=
e No_Null_Position Non_Volatile Bitfield
> =A0 =A0 =A0 =A0 =A0 =A0Item(Global): Usage Page, data=3D [ 0x0d ] 13
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Digitizer
> =A0 =A0 =A0 =A0 =A0 =A0Item(Local ): Usage, data=3D [ 0x51 ] 81
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Contact ID
> =A0 =A0 =A0 =A0 =A0 =A0Item(Global): Report Size, data=3D [ 0x10 ] 16
> =A0 =A0 =A0 =A0 =A0 =A0Item(Global): Report Count, data=3D [ 0x01 ] 1
> =A0 =A0 =A0 =A0 =A0 =A0Item(Main =A0): Input, data=3D [ 0x02 ] 2
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Data Variable =
Absolute No_Wrap Linear
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Preferred_Stat=
e No_Null_Position Non_Volatile Bitfield
> =A0 =A0 =A0 =A0 =A0 =A0Item(Local ): Usage, data=3D [ 0x55 ] 85
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Maximum Contac=
t Number
> =A0 =A0 =A0 =A0 =A0 =A0Item(Global): Logical Minimum, data=3D [ 0x00 =
] 0
> =A0 =A0 =A0 =A0 =A0 =A0Item(Global): Logical Maximum, data=3D [ 0x08 =
] 8
> =A0 =A0 =A0 =A0 =A0 =A0Item(Global): Report Size, data=3D [ 0x08 ] 8
> =A0 =A0 =A0 =A0 =A0 =A0Item(Global): Report Count, data=3D [ 0x01 ] 1
> =A0 =A0 =A0 =A0 =A0 =A0Item(Main =A0): Feature, data=3D [ 0x02 ] 2
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Data Variable =
Absolute No_Wrap Linear
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Preferred_Stat=
e No_Null_Position Non_Volatile Bitfield
> =A0 =A0 =A0 =A0 =A0 =A0Item(Main =A0): End Collection, data=3Dnone
> =A0 =A0 =A0 =A0 =A0 =A0Item(Main =A0): End Collection, data=3Dnone
> =A0 =A0 =A0Endpoint Descriptor:
> =A0 =A0 =A0 =A0bLength =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 7
> =A0 =A0 =A0 =A0bDescriptorType =A0 =A0 =A0 =A0 5
> =A0 =A0 =A0 =A0bEndpointAddress =A0 =A0 0x87 =A0EP 7 IN
> =A0 =A0 =A0 =A0bmAttributes =A0 =A0 =A0 =A0 =A0 =A03
> =A0 =A0 =A0 =A0 =A0Transfer Type =A0 =A0 =A0 =A0 =A0 =A0Interrupt
> =A0 =A0 =A0 =A0 =A0Synch Type =A0 =A0 =A0 =A0 =A0 =A0 =A0 None
> =A0 =A0 =A0 =A0 =A0Usage Type =A0 =A0 =A0 =A0 =A0 =A0 =A0 Data
> =A0 =A0 =A0 =A0wMaxPacketSize =A0 =A0 0x0008 =A01x 8 bytes
> =A0 =A0 =A0 =A0bInterval =A0 =A0 =A0 =A0 =A0 =A0 =A0 1
> Device Status: =A0 =A0 0x0001
> =A0Self Powered
>
> --
> Bye, Peter Korsgaard
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input=
" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
