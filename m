From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: synaptics - set minimum coordinates as reported
 by firmware
Date: Mon, 25 Jul 2011 01:37:52 -0700
Message-ID: <20110725083752.GE22937@core.coreip.homeip.net>
References: <20110707065705.GH7658@core.coreip.homeip.net>
 <CAGS+omBkpcVU29e4mK-HK838EiGhjbicuUkE8+yY2auQ01ZibQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f42.google.com ([209.85.210.42]:41828 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751700Ab1GYIh6 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 25 Jul 2011 04:37:58 -0400
Received: by pzk37 with SMTP id 37so8109412pzk.1
        for <linux-input@vger.kernel.org>; Mon, 25 Jul 2011 01:37:58 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAGS+omBkpcVU29e4mK-HK838EiGhjbicuUkE8+yY2auQ01ZibQ@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Daniel Kurtz <djkurtz@chromium.org>
Cc: Linux Input <linux-input@vger.kernel.org>

On Wed, Jul 20, 2011 at 07:20:40PM +0800, Daniel Kurtz wrote:
> Sorry, I fear I am too late, but...
>=20
> On Thu, Jul 7, 2011 at 2:57 PM, Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
> >
> > Newer Synaptics firmware allows to query minimum coordinates report=
ed by
> > the device, let's use this data.
> >
> > Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
> > ---
> >
> > =A0drivers/input/mouse/synaptics.c | =A0 56 +++++++++++++++++++++++=
+++-------------
> > =A0drivers/input/mouse/synaptics.h | =A0 =A08 ++++--
> > =A02 files changed, 43 insertions(+), 21 deletions(-)
>=20
> [...snip...]
>=20
> > diff --git a/drivers/input/mouse/synaptics.h b/drivers/input/mouse/=
synaptics.h
> > index b8025b0..a4394e1 100644
> > --- a/drivers/input/mouse/synaptics.h
> > +++ b/drivers/input/mouse/synaptics.h
> > @@ -19,7 +19,8 @@
> > =A0#define SYN_QUE_RESOLUTION =A0 =A0 =A0 =A0 =A0 =A0 0x08
> > =A0#define SYN_QUE_EXT_CAPAB =A0 =A0 =A0 =A0 =A0 =A0 =A00x09
> > =A0#define SYN_QUE_EXT_CAPAB_0C =A0 =A0 =A0 =A0 =A0 0x0c
> > -#define SYN_QUE_EXT_DIMENSIONS =A0 =A0 =A0 =A0 0x0d
> > +#define SYN_QUE_EXT_MAX_COORDS =A0 =A0 =A0 =A0 0x0d
> > +#define SYN_QUE_EXT_MIN_COORDS =A0 =A0 =A0 =A0 0x0f
> >
> > =A0/* synatics modes */
> > =A0#define SYN_BIT_ABSOLUTE_MODE =A0 =A0 =A0 =A0 =A0(1 << 7)
> > @@ -73,10 +74,12 @@
> > =A0* 2 =A0 0x04 =A0 =A0reduced filtering =A0 =A0 =A0 firmware does =
less filtering on
> > =A0* =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 position data, driver should watch
> > =A0* =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 for noise.
> > + * 2 =A0 0x20 =A0 =A0report min =A0 =A0 =A0 =A0 =A0 =A0 =A0query 0=
x0f gives min coord reported
> > =A0*/
> > =A0#define SYN_CAP_CLICKPAD(ex0c) =A0 =A0 =A0 =A0 ((ex0c) & 0x10000=
0) /* 1-button ClickPad */
> > =A0#define SYN_CAP_CLICKPAD2BTN(ex0c) =A0 =A0 ((ex0c) & 0x000100) /=
* 2-button ClickPad */
> > =A0#define SYN_CAP_MAX_DIMENSIONS(ex0c) =A0 ((ex0c) & 0x020000)
> > +#define SYN_CAP_MIN_DIMENSIONS(ex0c) =A0 ((ex0c) & 0x000200)
>=20
> I believe "Byte 2, 0x20" is actually 0x002000, not 0x000200.
> It would appear that the documentation is inconsistent with
> implementation; and, the implementation conflicts with the heretofore
> unused "deluxe LED controls" bit.
>=20

You are right, thanks for noticing. Should be fixed now.

Thanks.

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
