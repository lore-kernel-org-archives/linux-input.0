From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] HID: hid-multitouch: Only match MT interfaces
Date: Fri, 4 May 2012 14:06:38 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1205041405520.14613@pobox.suse.cz>
References: <1336056176-2508-1-git-send-email-rydberg@euromail.se> <CAN+gG=FSg+eZxGUY1BU0k_mkxiPZQ9BHuqUb00NTij_JWbDUcA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:58094 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755603Ab2EDMGl (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 4 May 2012 08:06:41 -0400
In-Reply-To: <CAN+gG=FSg+eZxGUY1BU0k_mkxiPZQ9BHuqUb00NTij_JWbDUcA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Cc: Henrik Rydberg <rydberg@euromail.se>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, =?ISO-8859-15?Q?St=E9phane_Chatty?= <chatty@enac.fr>

On Fri, 4 May 2012, Benjamin Tissoires wrote:

> > All known hid-multitouch devices currently match any device group.
> > However, some devices present interfaces belonging to different gro=
ups,
> > resulting in a race between the hid-generic and hid-multitouch modu=
les.
> > This patch narrows the MT device list to match only HID_GROUP_MULTI=
TOUCH,
> > which solves the problem.
> >
> > Reported-by: Benjamin Tissoires <benjamin.tissoires@gmail.com>
> > Signed-off-by: Henrik Rydberg <rydberg@euromail.se>
> > ---
> > =A0drivers/hid/hid-multitouch.c | =A0145 +++++++++++++++++++++-----=
----------------
> > =A01 file changed, 74 insertions(+), 71 deletions(-)
> >
> > diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multito=
uch.c
> > index ea465f1..20e9552 100644
> > --- a/drivers/hid/hid-multitouch.c
> > +++ b/drivers/hid/hid-multitouch.c
> > @@ -110,6 +110,9 @@ struct mt_device {
> >
> > =A0#define MT_DEFAULT_MAXCONTACT =A010
> >
> > +#define MT_USB_DEVICE(v, p) =A0 =A0HID_DEVICE(BUS_USB, HID_GROUP_M=
ULTITOUCH, v, p)
> > +#define MT_BT_DEVICE(v, p) =A0 =A0 HID_DEVICE(BUS_BLUETOOTH, HID_G=
ROUP_MULTITOUCH, v, p)
> > +
> > =A0/*
> > =A0* these device-dependent functions determine what slot correspon=
ds
> > =A0* to a valid contact that was just read.
> > @@ -735,276 +738,276 @@ static const struct hid_device_id mt_device=
s[] =3D {
> >
> > =A0 =A0 =A0 =A0/* 3M panels */
> > =A0 =A0 =A0 =A0{ .driver_data =3D MT_CLS_3M,
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 HID_USB_DEVICE(USB_VENDOR_ID_3M,
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 MT_USB_DEVICE(USB_VENDOR_ID_3M,
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0USB_DEVICE_ID_3M1968=
) },
> > =A0 =A0 =A0 =A0{ .driver_data =3D MT_CLS_3M,
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 HID_USB_DEVICE(USB_VENDOR_ID_3M,
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 MT_USB_DEVICE(USB_VENDOR_ID_3M,
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0USB_DEVICE_ID_3M2256=
) },
> > =A0 =A0 =A0 =A0{ .driver_data =3D MT_CLS_3M,
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 HID_USB_DEVICE(USB_VENDOR_ID_3M,
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 MT_USB_DEVICE(USB_VENDOR_ID_3M,
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0USB_DEVICE_ID_3M3266=
) },
> >
> > =A0 =A0 =A0 =A0/* ActionStar panels */
> > =A0 =A0 =A0 =A0{ .driver_data =3D MT_CLS_DEFAULT,
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 HID_USB_DEVICE(USB_VENDOR_ID_ACTIONST=
AR,
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 MT_USB_DEVICE(USB_VENDOR_ID_ACTIONSTA=
R,
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0USB_DEVICE_ID_ACTION=
STAR_1011) },
> >
> > =A0 =A0 =A0 =A0/* Atmel panels */
> > =A0 =A0 =A0 =A0{ .driver_data =3D MT_CLS_SERIAL,
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 HID_USB_DEVICE(USB_VENDOR_ID_ATMEL,
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 MT_USB_DEVICE(USB_VENDOR_ID_ATMEL,
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0USB_DEVICE_ID_ATMEL_=
MULTITOUCH) },
> > =A0 =A0 =A0 =A0{ .driver_data =3D MT_CLS_SERIAL,
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 HID_USB_DEVICE(USB_VENDOR_ID_ATMEL,
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 MT_USB_DEVICE(USB_VENDOR_ID_ATMEL,
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0USB_DEVICE_ID_ATMEL_=
MXT_DIGITIZER) },
> >
>=20
> You are missing /* Baanto multitouch devices */ here. Please use the
> branch for-next of Jiri....

This is not necessary ... I will have to fix the merge conflict one way=
 or=20
another anyway, that's fine.

Thanks,

--=20
Jiri Kosina
SUSE Labs
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
