From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] HID: multitouch: add support for Type Cover Pro 3
Date: Fri, 17 Jun 2016 23:00:34 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1606172259110.6874@cbobk.fhfr.pm>
References: <1466196443.21223.1.camel@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:49959 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750725AbcFQVAg (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 17 Jun 2016 17:00:36 -0400
In-Reply-To: <1466196443.21223.1.camel@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dennis Chen <barracks510@gmail.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org

On Fri, 17 Jun 2016, Dennis Chen wrote:

> Include Microsoft Type Cover 3 support into hid-multitouch.c
> Allow touchpad device to have multitouch functionality.
>=20
> Signed-off-by: Dennis Chen <barracks510@gmail.com>
> ---
> =C2=A0drivers/hid/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0|=C2=A0=C2=A01 +
> =C2=A0drivers/hid/hid-multitouch.c | 14 ++++++++++++++
> =C2=A02 files changed, 15 insertions(+)
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
> diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouc=
h.c
> index c741f5e..f052ed2 100644
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
> =C2=A0	/* MosArt panels */
> =C2=A0	{ .driver_data =3D MT_CLS_CONFIDENCE_MINUS_ONE,

This would mean that both hid-multitouch and hid-microsoft would claim=20
support for this device, which isn't really going to provide consistent=
=20
user experience. Is MT_CLS_EXPORT_ALL_INPUTS sufficient to provide=20
complete functionality by hid-multitouch? If so, the support from=20
hid-microsoft should be dropped.

Thanks,

--=20
Jiri Kosina
SUSE Labs

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
