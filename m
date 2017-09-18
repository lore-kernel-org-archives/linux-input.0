From: Niels Skou Olsen <nolsen@jabra.com>
Subject: RE: [PATCH] HID: Add special driver for Jabra devices
Date: Mon, 18 Sep 2017 06:02:33 +0000
Message-ID: <VI1PR0701MB2991C968D4DF94EF466920D9DA630@VI1PR0701MB2991.eurprd07.prod.outlook.com>
References: <1504269832-23142-1-git-send-email-nolsen@jabra.com>
 <nycvar.YFH.7.76.1709081408220.3285@jbgna.fhfr.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-eopbgr10073.outbound.protection.outlook.com ([40.107.1.73]:57947
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750757AbdIRGCh (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Mon, 18 Sep 2017 02:02:37 -0400
In-Reply-To: <nycvar.YFH.7.76.1709081408220.3285@jbgna.fhfr.qr>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "benjamin.tissoires@redhat.com" <benjamin.tissoires@redhat.com>, "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>

On Fri, 8 Sep 2017, jikos@kernel.org wrote:

> On Fri, 1 Sep 2017, nolsen@jabra.com wrote:
>
> > From: Niels Skou Olsen <nolsen@jabra.com>
> >
> > diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c index
> > 9bc9116..0603012 100644
> > --- a/drivers/hid/hid-core.c
> > +++ b/drivers/hid/hid-core.c
> > @@ -2077,6 +2077,9 @@ static const struct hid_device_id hid_have_specia=
l_driver[] =3D {
> > +#if IS_ENABLED(CONFIG_HID_JABRA)
> > +{ HID_USB_DEVICE(USB_VENDOR_ID_JABRA, HID_ANY_ID) },
> > +#endif
>
> You also need to update hid-core so that generic driver doesn't bind to t=
hose device.
> See hid_have_special_driver[] in drivers/hid/hid-core.c

Isn't above addition to hid_have_special_driver[] enough? It is in the orig=
inal patch.

Thanks,
Niels

**** GN GROUP NOTICE - AUTOMATICALLY INSERTED**** The information in this e=
-mail (including attachments, if any) is considered confidential and is int=
ended only for the recipient(s) listed above. Any review, use, disclosure, =
distribution or copying of this e-mail is prohibited except by or on behalf=
 of the intended recipient. If you have received this email in error, pleas=
e notify me immediately by reply e-mail, delete this e-mail, and do not dis=
close its contents to anyone. Any opinions expressed in this e-mail are tho=
se of the individual and not necessarily the GN group. Thank you. *********=
*********** DISCLAIMER END ************************
