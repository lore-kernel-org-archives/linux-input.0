From: Antonio Ospite <ospite@studenti.unina.it>
Subject: Re: [PATCH] HID: add support for Sony RF receiver with USB product
 id 0x0374
Date: Tue, 15 Jan 2013 10:36:38 +0100
Message-ID: <20130115103638.be566e39f0f5ad7186362dd8@studenti.unina.it>
References: <1358221428.9926.1.camel@nexus.lab.ntt.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp208.alice.it ([82.57.200.104]:42618 "EHLO smtp208.alice.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751162Ab3AOJhm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 15 Jan 2013 04:37:42 -0500
In-Reply-To: <1358221428.9926.1.camel@nexus.lab.ntt.co.jp>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Fernando Luis =?ISO-8859-1?Q?V=E1zquez?= Cao <fernando_b1@lab.ntt.co.jp>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, 15 Jan 2013 12:43:48 +0900
=46ernando Luis V=E1zquez Cao  <fernando_b1@lab.ntt.co.jp> wrote:

Hi Fernando,

> Some Vaio desktop computers, among them the VGC-LN51JGB multimedia PC=
, have
> a RF receiver, multi-interface USB device 054c:0374, that is used to =
connect
> a wireless keyboard and a wireless mouse.
>=20
> The keyboard works flawlessly, but the mouse (VGP-WMS3 in my case) do=
es not
> seem to be generating any pointer events. The problem is that the mou=
se pointer
> is wrongly declared as a constant non-data variable in the report des=
criptor
> (see lsusb and usbhid-dump output below), with the consenquence that =
it is

typo: consequence

> ignored by the HID code.
>=20
> Add this device to the have-special-driver list and fix up the report
> descriptor in the Sony-specific driver which happens to already have =
a fixup
> for a similar firmware bug.
>=20
> # lsusb -vd 054C:0374
> Bus 003 Device 002: ID 054c:0374 Sony Corp.
> Device Descriptor:
>   bLength                18
>   bDescriptorType         1
>   bcdUSB               2.00
>   bDeviceClass            0 (Defined at Interface level)
>   bDeviceSubClass         0
>   bDeviceProtocol         0
>   bMaxPacketSize0         8
>   idVendor           0x054c Sony Corp.
>   idProduct          0x0374
>   iSerial                 0
> [...]
>     Interface Descriptor:
>       bLength                 9
>       bDescriptorType         4
>       bInterfaceNumber        1
>       bAlternateSetting       0
>       bNumEndpoints           1
>       bInterfaceClass         3 Human Interface Device
>       bInterfaceSubClass      1 Boot Interface Subclass
>       bInterfaceProtocol      2 Mouse
>       iInterface              2 RF Receiver
> [...]
>           Report Descriptor: (length is 100)
>             Item(Global): Usage Page, data=3D [ 0x01 ] 1
>                             Generic Desktop Controls
>             Item(Local ): Usage, data=3D [ 0x30 ] 48
>                             Direction-X
>             Item(Local ): Usage, data=3D [ 0x31 ] 49
>                             Direction-Y
>             Item(Global): Report Count, data=3D [ 0x02 ] 2
>             Item(Global): Report Size, data=3D [ 0x08 ] 8
>             Item(Global): Logical Minimum, data=3D [ 0x81 ] 129
>             Item(Global): Logical Maximum, data=3D [ 0x7f ] 127
>             Item(Main  ): Input, data=3D [ 0x07 ] 7
>                             Constant Variable Relative No_Wrap Linear
>                             Preferred_State No_Null_Position Non_Vola=
tile Bitfield
>=20
> # sudo usbhid-dump
>=20
> 003:002:001:DESCRIPTOR         1357910009.758544
>  05 01 09 02 A1 01 05 01 09 02 A1 02 85 01 09 01
>  A1 00 05 09 19 01 29 05 95 05 75 01 15 00 25 01
>  81 02 75 03 95 01 81 01 05 01 09 30 09 31 95 02
>  75 08 15 81 25 7F 81 07 A1 02 85 01 09 38 35 00
>  45 00 15 81 25 7F 95 01 75 08 81 06 C0 A1 02 85
>  01 05 0C 15 81 25 7F 95 01 75 08 0A 38 02 81 06
>  C0 C0 C0 C0
>=20
> Cc: linux-input@vger.kernel.org
> Cc: linux-usb@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Fernando Luis Vazquez Cao <fernando@oss.ntt.co.jp>
> ---
>=20
> diff -urNp linux-3.8-rc3-orig/drivers/hid/hid-core.c linux-3.8-rc3/dr=
ivers/hid/hid-core.c
> --- linux-3.8-rc3-orig/drivers/hid/hid-core.c	2013-01-13 20:54:36.846=
952518 +0900
> +++ linux-3.8-rc3/drivers/hid/hid-core.c	2013-01-13 18:21:19.90134732=
7 +0900
> @@ -1697,6 +1697,7 @@ static const struct hid_device_id hid_ha
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_NAVIGATION_=
CONTROLLER) },
>  	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_PS3_C=
ONTROLLER) },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_VAIO_VGX_MO=
USE) },
> +	{ HID_USB_DEVICE(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_VAIO_VGP_MO=
USE) },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_SUNPLUS, USB_DEVICE_ID_SUNPLUS_WDESK=
TOP) },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_THRUSTMASTER, 0xb300) },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_THRUSTMASTER, 0xb304) },
> diff -urNp linux-3.8-rc3-orig/drivers/hid/hid-ids.h linux-3.8-rc3/dri=
vers/hid/hid-ids.h
> --- linux-3.8-rc3-orig/drivers/hid/hid-ids.h	2013-01-13 20:54:36.8509=
52537 +0900
> +++ linux-3.8-rc3/drivers/hid/hid-ids.h	2013-01-13 18:21:19.901347327=
 +0900
> @@ -706,6 +706,7 @@
> =20
>  #define USB_VENDOR_ID_SONY			0x054c
>  #define USB_DEVICE_ID_SONY_VAIO_VGX_MOUSE	0x024b
> +#define USB_DEVICE_ID_SONY_VAIO_VGP_MOUSE	0x0374
>  #define USB_DEVICE_ID_SONY_PS3_BDREMOTE		0x0306
>  #define USB_DEVICE_ID_SONY_PS3_CONTROLLER	0x0268
>  #define USB_DEVICE_ID_SONY_NAVIGATION_CONTROLLER	0x042f
> diff -urNp linux-3.8-rc3-orig/drivers/hid/hid-sony.c linux-3.8-rc3/dr=
ivers/hid/hid-sony.c
> --- linux-3.8-rc3-orig/drivers/hid/hid-sony.c	2012-12-11 12:30:57.000=
000000 +0900
> +++ linux-3.8-rc3/drivers/hid/hid-sony.c	2013-01-13 18:21:19.90134732=
7 +0900
> @@ -44,19 +44,21 @@ static __u8 *sony_report_fixup(struct hi
>  	struct sony_sc *sc =3D hid_get_drvdata(hdev);
> =20
>  	if ((sc->quirks & VAIO_RDESC_CONSTANT) &&
> -			*rsize >=3D 56 && rdesc[54] =3D=3D 0x81 && rdesc[55] =3D=3D 0x07)=
 {
> -		hid_info(hdev, "Fixing up Sony Vaio VGX report descriptor\n");
> +	    *rsize >=3D 56 && rdesc[54] =3D=3D 0x81 && rdesc[55] =3D=3D 0x0=
7) {
> +		hid_info(hdev,
> +		         "Fixing up Sony RF Receiver report descriptor\n");

Changing the message does make sense, but try to avoid mixing
functional changes with style changes (I am referring to the change of
indentation here).

If you _really_ want to change the style send a separate patch stating
clearly in the commit message that there are no functionality changes.

This makes the review easier for both kind of patches.

>  		rdesc[55] =3D 0x06;
>  	}
> =20
>  	/* The HID descriptor exposed over BT has a trailing zero byte */
>  	if ((((sc->quirks & SIXAXIS_CONTROLLER_USB) && *rsize =3D=3D 148) |=
|
> -			((sc->quirks & SIXAXIS_CONTROLLER_BT) && *rsize =3D=3D 149)) &&
> -			rdesc[83] =3D=3D 0x75) {
> +	        ((sc->quirks & SIXAXIS_CONTROLLER_BT) && *rsize =3D=3D 149)=
) &&
> +	    rdesc[83] =3D=3D 0x75) {

Ditto, style changes.

>  		hid_info(hdev, "Fixing up Sony Sixaxis report descriptor\n");
>  		memcpy((void *)&rdesc[83], (void *)&sixaxis_rdesc_fixup,
>  			sizeof(sixaxis_rdesc_fixup));
>  	}
> +

Ditto.

>  	return rdesc;
>  }
> =20
> @@ -217,6 +219,8 @@ static const struct hid_device_id sony_d
>  		.driver_data =3D SIXAXIS_CONTROLLER_BT },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_VAIO_VGX_MO=
USE),
>  		.driver_data =3D VAIO_RDESC_CONSTANT },
> +	{ HID_USB_DEVICE(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_VAIO_VGP_MO=
USE),
> +		.driver_data =3D VAIO_RDESC_CONSTANT },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(hid, sony_devices);
>=20
>=20

Thanks,
   Antonio

--=20
Antonio Ospite
http://ao2.it

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
