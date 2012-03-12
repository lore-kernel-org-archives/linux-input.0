From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH 1/5] HID: multitouch: add support for eGalax 0x722a
Date: Mon, 12 Mar 2012 13:40:46 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1203121339550.18356@pobox.suse.cz>
References: <1331053026-21272-1-git-send-email-benjamin.tissoires@gmail.com> <1331053026-21272-2-git-send-email-benjamin.tissoires@gmail.com> <alpine.LNX.2.00.1203091329030.18356@pobox.suse.cz>
 <CAN+gG=F0w88T-iDxVJNEjgyud8FwC5vTGT8+2KTva8FXgFjTog@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:58969 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754152Ab2CLMkt (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 12 Mar 2012 08:40:49 -0400
In-Reply-To: <CAN+gG=F0w88T-iDxVJNEjgyud8FwC5vTGT8+2KTva8FXgFjTog@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Henrik Rydberg <rydberg@euromail.se>, Stephane Chatty <chatty@enac.fr>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Sat, 10 Mar 2012, Benjamin Tissoires wrote:

> >> =A0drivers/hid/hid-ids.h =A0 =A0 =A0 =A0| =A0 =A01 +
> >> =A0drivers/hid/hid-multitouch.c | =A0 =A03 +++
> >> =A02 files changed, 4 insertions(+), 0 deletions(-)
> >>
> >> diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
> >> index 6656516..e1fada2 100644
> >> --- a/drivers/hid/hid-ids.h
> >> +++ b/drivers/hid/hid-ids.h
> >> @@ -240,6 +240,7 @@
> >> =A0#define USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH_7207 =A0 =A00x7207
> >> =A0#define USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH_720C =A0 =A00x720c
> >> =A0#define USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH_7224 =A0 =A00x7224
> >> +#define USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH_722A =A0 =A00x722A
> >> =A0#define USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH_725E =A0 =A00x725e
> >> =A0#define USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH_7262 =A0 =A00x7262
> >> =A0#define USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH_726B =A0 =A00x726b
> >> diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multit=
ouch.c
> >> index 0eda37f..019de83 100644
> >> --- a/drivers/hid/hid-multitouch.c
> >> +++ b/drivers/hid/hid-multitouch.c
> >> @@ -797,6 +797,9 @@ static const struct hid_device_id mt_devices[]=
 =3D {
> >> =A0 =A0 =A0 { .driver_data =3D MT_CLS_EGALAX_SERIAL,
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 HID_USB_DEVICE(USB_VENDOR_ID_DWAV,
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 USB_DEVICE_ID_DWAV_EGA=
LAX_MULTITOUCH_7224) },
> >> + =A0 =A0 { .driver_data =3D MT_CLS_EGALAX_SERIAL,
> >> + =A0 =A0 =A0 =A0 =A0 =A0 HID_USB_DEVICE(USB_VENDOR_ID_DWAV,
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 USB_DEVICE_ID_DWAV_EGALA=
X_MULTITOUCH_722A) },
> >> =A0 =A0 =A0 { .driver_data =3D MT_CLS_EGALAX,
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 HID_USB_DEVICE(USB_VENDOR_ID_DWAV,
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 USB_DEVICE_ID_DWAV_EGA=
LAX_MULTITOUCH_726B) },
> >
> > Applied.
> >
>=20
> Thanks Jiri.
> How about patches 2,3 and 5?

I just needed some more time to review those. They are now in my tree a=
s=20
well.

Patch #4 is still under discussion, and thus on hold.

Thanks,

--=20
Jiri Kosina
SUSE Labs

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
