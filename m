From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH] HID: multitouch: add support for Type Cover Pro 3
Date: Fri, 17 Jun 2016 23:11:42 +0200
Message-ID: <20160617211142.GH24234@mail.corp.redhat.com>
References: <1466196443.21223.1.camel@gmail.com>
 <alpine.LNX.2.00.1606172259110.6874@cbobk.fhfr.pm>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:51040 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964858AbcFQVLq (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 17 Jun 2016 17:11:46 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.00.1606172259110.6874@cbobk.fhfr.pm>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>
Cc: Dennis Chen <barracks510@gmail.com>, linux-input@vger.kernel.org

On Jun 17 2016 or thereabouts, Jiri Kosina wrote:
> On Fri, 17 Jun 2016, Dennis Chen wrote:
>=20
> > Include Microsoft Type Cover 3 support into hid-multitouch.c
> > Allow touchpad device to have multitouch functionality.
> >=20
> > Signed-off-by: Dennis Chen <barracks510@gmail.com>
> > ---
> > =C2=A0drivers/hid/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0|=C2=A0=C2=A01 +
> > =C2=A0drivers/hid/hid-multitouch.c | 14 ++++++++++++++
> > =C2=A02 files changed, 15 insertions(+)
> >=20
> > diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
> > index 5646ca4..5af0603 100644
> > --- a/drivers/hid/Kconfig
> > +++ b/drivers/hid/Kconfig
> > @@ -530,6 +530,7 @@ config HID_MULTITOUCH
> > =C2=A0	=C2=A0=C2=A0- IrTouch Infrared USB panels
> > =C2=A0	=C2=A0=C2=A0- LG Display panels (Dell ST2220Tc)
> > =C2=A0	=C2=A0=C2=A0- Lumio CrystalTouch panels
> > +	=C2=A0=C2=A0- Microsoft Type Cover 3 touchpad
> > =C2=A0	=C2=A0=C2=A0- MosArt dual-touch panels
> > =C2=A0	=C2=A0=C2=A0- Panasonic multitouch panels
> > =C2=A0	=C2=A0=C2=A0- PenMount dual touch panels
> > diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multito=
uch.c
> > index c741f5e..f052ed2 100644
> > --- a/drivers/hid/hid-multitouch.c
> > +++ b/drivers/hid/hid-multitouch.c
> > @@ -1377,6 +1377,20 @@ static const struct hid_device_id mt_devices=
[] =3D {
> > =C2=A0		MT_USB_DEVICE(USB_VENDOR_ID_ILITEK,
> > =C2=A0			USB_DEVICE_ID_ILITEK_MULTITOUCH) },
> > =C2=A0
> > +	/* Microsoft Type Cover 3 touchpad */
> > +	{ .driver_data =3D MT_CLS_EXPORT_ALL_INPUTS,
> > +		MT_USB_DEVICE(USB_VENDOR_ID_MICROSOFT,
> > +			USB_DEVICE_ID_MS_TYPE_COVER_PRO_3) },
> > +	{ .driver_data =3D MT_CLS_EXPORT_ALL_INPUTS,
> > +		MT_USB_DEVICE(USB_VENDOR_ID_MICROSOFT,
> > +			USB_DEVICE_ID_MS_TYPE_COVER_PRO_3_2) },
> > +	{ .driver_data =3D MT_CLS_EXPORT_ALL_INPUTS,
> > +		MT_USB_DEVICE(USB_VENDOR_ID_MICROSOFT,
> > +			USB_DEVICE_ID_MS_TYPE_COVER_PRO_3_JP) },
> > +	{ .driver_data =3D MT_CLS_EXPORT_ALL_INPUTS,
> > +		MT_USB_DEVICE(USB_VENDOR_ID_MICROSOFT,
> > +			USB_DEVICE_ID_MS_TYPE_COVER_3) },
> > +
> > =C2=A0	/* MosArt panels */
> > =C2=A0	{ .driver_data =3D MT_CLS_CONFIDENCE_MINUS_ONE,
>=20
> This would mean that both hid-multitouch and hid-microsoft would clai=
m=20
> support for this device, which isn't really going to provide consiste=
nt=20
> user experience. Is MT_CLS_EXPORT_ALL_INPUTS sufficient to provide=20
> complete functionality by hid-multitouch? If so, the support from=20
> hid-microsoft should be dropped.

Also, please see if the series with the 2 following patches is not
sufficient enough:
http://www.spinics.net/lists/linux-input/msg44576.html
http://www.spinics.net/lists/linux-input/msg44577.html

If you just adapt the second patch to add your ids, it should hopefully
be working (though the surface book is not for some unknown reasons
yet).

Cheers,
Benjamin

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
