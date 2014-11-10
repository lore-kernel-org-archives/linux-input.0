From: Daniel Nicoletti <dantti12@gmail.com>
Subject: Re: PATCH change for HID_BATTERY_STRENGTH kconfig
Date: Mon, 10 Nov 2014 08:56:59 -0200
Message-ID: <1415617019.16803.2.camel@bart>
References: <CACo8zOfAf3cUNh4MZcQvYByiu=D5S1aA4qiH_HFuvz5GYMJF7g@mail.gmail.com>
	 <alpine.LNX.2.00.1305240016180.13213@pobox.suse.cz>
	 <CACo8zOcm3B7WdQpHA3J2ZtP6AWUrtAo_L63mpYJR0w13jNwLpQ@mail.gmail.com>
	 <alpine.LNX.2.00.1407291339040.16390@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qc0-f177.google.com ([209.85.216.177]:36000 "EHLO
	mail-qc0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752386AbaKJK5F (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 10 Nov 2014 05:57:05 -0500
Received: by mail-qc0-f177.google.com with SMTP id l6so5412388qcy.8
        for <linux-input@vger.kernel.org>; Mon, 10 Nov 2014 02:57:04 -0800 (PST)
In-Reply-To: <alpine.LNX.2.00.1407291339040.16390@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org

Em Ter, 2014-07-29 =C3=A0s 13:39 +0200, Jiri Kosina escreveu:
> On Mon, 23 Jun 2014, Daniel Nicoletti wrote:
>=20
> > 2013-05-23 19:16 GMT-03:00 Jiri Kosina <jkosina@suse.cz>:
> > > On Mon, 13 May 2013, Daniel Nicoletti wrote:
> > >
> > >> Hi,
> > >> I'd like to propose this patch while removes the need for
> > >> hid to be compiled build-in, as this is the same behavior
> > >> that WiiMote and Wacom have.
> > >> Is this ok?
> > >
> > > Makes sense to me. Could you please resend with proper changelog =
and
> > > Signed-off-by: line?
> > >
> > > Thanks.
> >=20
> > Sorry it took more than a year for me to do this,
> > so I called git send-email, and so far the CC and
> > linux-input didn't get it, tho it said result OK.
> > git send-email --to "Jiri Kosina <jkosina@suse.cz>" --cc
> > "linux-input@vger.kernel.org"
> > 0001-HID-Allows-for-HID_BATTERY_STRENGTH-config-be-enable.patch
> >=20
> > I'm pasting it here hoping gmail doesn't screw
> > it, if you prefer that I send it using the above
> > command mind you telling what I did wrong?
> >=20
> > Thanks.
> >=20
> > >From df740fd81dffbb74e13c622392fe9a945006fd3c Mon Sep 17 00:00:00 =
2001
> > From: Daniel Nicoletti <dantti12@gmail.com>
> > Date: Mon, 23 Jun 2014 10:31:47 -0300
> > Subject: [PATCH] HID: Allows for HID_BATTERY_STRENGTH config be ena=
bled
> >  without the need for HID module to be built-in.
> >=20
>=20
> It'd be nice to insert a few sentences of changelog here.
>=20
> Thanks.
>=20
> > Signed-off-by: Daniel Nicoletti <dantti12@gmail.com>
> > ---
> >  drivers/hid/Kconfig | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
> > index fb52f3f..d6d85ad 100644
> > --- a/drivers/hid/Kconfig
> > +++ b/drivers/hid/Kconfig
> > @@ -27,7 +27,8 @@ if HID
> >=20
> >  config HID_BATTERY_STRENGTH
> >         bool "Battery level reporting for HID devices"
> > -       depends on HID && POWER_SUPPLY && HID =3D POWER_SUPPLY
> > +       depends on HID
> > +       select POWER_SUPPLY
> >         default n
> >         ---help---
> >         This option adds support of reporting battery strength (for=
 HID devices
> > --=20
> > 2.0.0
> >=20
>=20
> --=20
> Jiri Kosina
> SUSE Labs

Sorry for yet another delay here is the patch with
a better changelog (I hope so)...


=46rom 21608873917dcec012c7f9f1b84dd44774069de2 Mon Sep 17 00:00:00 200=
1
=46rom: Daniel Nicoletti <dantti12@gmail.com>
Date: Mon, 23 Jun 2014 10:31:47 -0300
Subject: [PATCH] HID: Allow HID_BATTERY_STRENGTH to be enabled

Allows for HID_BATTERY_STRENGTH config be enabled
without the need for HID module to be built-in,
prior to this HID and POWER_SUPPLY had to be
equal, and now we only select POWER_SUPPLY and
depend on the HID module.

Signed-off-by: Daniel Nicoletti <dantti12@gmail.com>
---
 drivers/hid/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index f42df4d..602ac07 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -27,7 +27,8 @@ if HID
=20
 config HID_BATTERY_STRENGTH
        bool "Battery level reporting for HID devices"
-       depends on HID && POWER_SUPPLY && HID =3D POWER_SUPPLY
+       depends on HID
+       select POWER_SUPPLY
        default n
        ---help---
        This option adds support of reporting battery strength (for HID
devices
--=20
2.1.0



--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
