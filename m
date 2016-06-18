From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH v2] HID: multitouch: add support for Type Cover Pro 3
Date: Sat, 18 Jun 2016 21:47:18 +0200
Message-ID: <20160618194718.GJ24234@mail.corp.redhat.com>
References: <1466277551.2669.13.camel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:49530 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750813AbcFRTrX (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sat, 18 Jun 2016 15:47:23 -0400
Content-Disposition: inline
In-Reply-To: <1466277551.2669.13.camel@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dennis Chen <barracks510@gmail.com>
Cc: Jiri Kosina <jikos@kernel.org>, linux-input <linux-input@vger.kernel.org>

On Jun 18 2016 or thereabouts, Dennis Chen wrote:
> Include Microsoft Type Cover 3 support into hid-multitouch.c
> Allow touchpad device to have multitouch functionality.
> Drop Type Cover 3 support in hid-microsoft.c
>=20
> Signed-off-by: Dennis Chen <barracks510@gmail.com>
> ---
> =C2=A0drivers/hid/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0|=C2=A0=C2=A01 +
> =C2=A0drivers/hid/hid-core.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
| 10 +---------
> =C2=A0drivers/hid/hid-microsoft.c=C2=A0=C2=A0|=C2=A0=C2=A08 --------
> =C2=A0drivers/hid/hid-multitouch.c | 14 ++++++++++++++
> =C2=A04 files changed, 16 insertions(+), 17 deletions(-)
>=20
> diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
> index 5646ca4..5af0603 100644
> --- a/drivers/hid/Kconfig
> +++ b/drivers/hid/Kconfig
> @@ -530,6 +530,7 @@ config HID_MULTITOUCH
> =C2=A0	=C2=A0=C2=A0- IrTouch Infrared USB panels
> =C2=A0	=C2=A0=C2=A0- LG Display panels (Dell ST2220Tc)
> =C2=A0	=C2=A0=C2=A0- Lumio CrystalTouch panels
> +	=C2=A0=C2=A0- Microsoft Type Cover 3 touchpad
> =C2=A0	=C2=A0=C2=A0- MosArt dual-touch panels
> =C2=A0	=C2=A0=C2=A0- Panasonic multitouch panels
> =C2=A0	=C2=A0=C2=A0- PenMount dual touch panels
> diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
> index 8ea3a26..ddeadd9 100644
> --- a/drivers/hid/hid-core.c
> +++ b/drivers/hid/hid-core.c
> @@ -724,11 +724,7 @@ static void hid_scan_collection(struct hid_parse=
r *parser, unsigned type)
> =C2=A0		hid->group =3D HID_GROUP_SENSOR_HUB;
> =C2=A0
> =C2=A0	if (hid->vendor =3D=3D USB_VENDOR_ID_MICROSOFT &&
> -	=C2=A0=C2=A0=C2=A0=C2=A0(hid->product =3D=3D USB_DEVICE_ID_MS_TYPE_=
COVER_PRO_3 ||
> -	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0hid->product =3D=3D USB_DEVICE_ID_MS_=
TYPE_COVER_PRO_3_2 ||
> -	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0hid->product =3D=3D USB_DEVICE_ID_MS_=
TYPE_COVER_PRO_3_JP ||
> -	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0hid->product =3D=3D USB_DEVICE_ID_MS_=
TYPE_COVER_3 ||
> -	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0hid->product =3D=3D USB_DEVICE_ID_MS_=
POWER_COVER) &&
> +	=C2=A0=C2=A0=C2=A0=C2=A0hid->product =3D=3D USB_DEVICE_ID_MS_POWER_=
COVER &&
> =C2=A0	=C2=A0=C2=A0=C2=A0=C2=A0hid->group =3D=3D HID_GROUP_MULTITOUCH=
)
> =C2=A0		hid->group =3D HID_GROUP_GENERIC;
> =C2=A0
> @@ -1973,10 +1969,6 @@ static const struct hid_device_id hid_have_spe=
cial_driver[] =3D {
> =C2=A0	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_DIG=
ITAL_MEDIA_3K) },
> =C2=A0	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_WIRELE=
SS_OPTICAL_DESKTOP_3_0) },
> =C2=A0	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_OFF=
ICE_KB) },
> -	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_TYPE_COV=
ER_PRO_3) },
> -	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_TYPE_COV=
ER_PRO_3_2) },
> -	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_TYPE_COV=
ER_PRO_3_JP) },
> -	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_TYPE_COV=
ER_3) },
> =C2=A0	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_DIG=
ITAL_MEDIA_7K) },
> =C2=A0	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_DIG=
ITAL_MEDIA_600) },
> =C2=A0	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_DIG=
ITAL_MEDIA_3KV1) },
> diff --git a/drivers/hid/hid-microsoft.c b/drivers/hid/hid-microsoft.=
c
> index e924d55..b88a429 100644
> --- a/drivers/hid/hid-microsoft.c
> +++ b/drivers/hid/hid-microsoft.c
> @@ -282,14 +282,6 @@ static const struct hid_device_id ms_devices[] =3D=
 {
> =C2=A0		.driver_data =3D MS_NOGET },
> =C2=A0	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_COM=
=46ORT_MOUSE_4500),
> =C2=A0		.driver_data =3D MS_DUPLICATE_USAGES },
> -	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_TYPE_COV=
ER_PRO_3),
> -		.driver_data =3D MS_HIDINPUT },
> -	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_TYPE_COV=
ER_PRO_3_2),
> -		.driver_data =3D MS_HIDINPUT },
> -	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_TYPE_COV=
ER_PRO_3_JP),
> -		.driver_data =3D MS_HIDINPUT },
> -	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_TYPE_COV=
ER_3),
> -		.driver_data =3D MS_HIDINPUT },
> =C2=A0	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_POW=
ER_COVER),
> =C2=A0		.driver_data =3D MS_HIDINPUT },
> =C2=A0	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_COM=
=46ORT_KEYBOARD),
> diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouc=
h.c
> index 95b7d61..1bf002f 100644
> --- a/drivers/hid/hid-multitouch.c
> +++ b/drivers/hid/hid-multitouch.c
> @@ -1377,6 +1377,20 @@ static const struct hid_device_id mt_devices[]=
 =3D {
> =C2=A0		MT_USB_DEVICE(USB_VENDOR_ID_ILITEK,
> =C2=A0			USB_DEVICE_ID_ILITEK_MULTITOUCH) },
> =C2=A0
> +	/* Microsoft Type Cover 3 touchpad */
> +	{ .driver_data =3D MT_CLS_EXPORT_ALL_INPUTS,
> +		MT_USB_DEVICE(USB_VENDOR_ID_MICROSOFT,
> +			USB_DEVICE_ID_MS_TYPE_COVER_PRO_3) },
> +	{ .driver_data =3D MT_CLS_EXPORT_ALL_INPUTS,
> +		MT_USB_DEVICE(USB_VENDOR_ID_MICROSOFT,
> +			USB_DEVICE_ID_MS_TYPE_COVER_PRO_3_2) },
> +	{ .driver_data =3D MT_CLS_EXPORT_ALL_INPUTS,
> +		MT_USB_DEVICE(USB_VENDOR_ID_MICROSOFT,
> +			USB_DEVICE_ID_MS_TYPE_COVER_PRO_3_JP) },
> +	{ .driver_data =3D MT_CLS_EXPORT_ALL_INPUTS,
> +		MT_USB_DEVICE(USB_VENDOR_ID_MICROSOFT,
> +			USB_DEVICE_ID_MS_TYPE_COVER_3) },
> +

Hopefully, this hunk is not required with the 2 pending patches I
mentioned in v1.

Cheers,
Benjamin

> =C2=A0	/* MosArt panels */
> =C2=A0	{ .driver_data =3D MT_CLS_CONFIDENCE_MINUS_ONE,
> =C2=A0		MT_USB_DEVICE(USB_VENDOR_ID_ASUS,
> --=C2=A0
> 2.5.5




--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
