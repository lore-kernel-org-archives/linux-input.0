From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH 07/16] HID: wiimote: Parse accelerometer data
Date: Wed, 10 Aug 2011 13:55:07 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1108101353390.32288@pobox.suse.cz>
References: <1311869316-17128-1-git-send-email-dh.herrmann@googlemail.com> <1311869316-17128-8-git-send-email-dh.herrmann@googlemail.com> <201107282012.25113.oneukum@suse.de> <CANq1E4Q=XDWjq7gUss=Xe_TMNJPZOL81MM_LKCpy9c9j92hZVA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:34395 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753118Ab1HJLzJ (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 10 Aug 2011 07:55:09 -0400
In-Reply-To: <CANq1E4Q=XDWjq7gUss=Xe_TMNJPZOL81MM_LKCpy9c9j92hZVA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Herrmann <dh.herrmann@googlemail.com>
Cc: Oliver Neukum <oneukum@suse.de>, linux-input@vger.kernel.org, padovan@profusion.mobi

On Thu, 28 Jul 2011, David Herrmann wrote:

> >> +static void handler_accel(struct wiimote_data *wdata, const __u8 =
*payload)
> >> +{
> >> + =A0 =A0 =A0 __u16 x, y, z;
> >> +
> >> + =A0 =A0 =A0 if (!(wdata->state.flags & WIIPROTO_FLAG_ACCEL))
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> >> +
> >> + =A0 =A0 =A0 /*
> >> + =A0 =A0 =A0 =A0* payload is: BB BB XX YY ZZ
> >> + =A0 =A0 =A0 =A0* Buttons data contains LSBs
> >> + =A0 =A0 =A0 =A0*/
> >> +
> >> + =A0 =A0 =A0 x =3D payload[2] << 2;
> >> + =A0 =A0 =A0 y =3D payload[3] << 2;
> >> + =A0 =A0 =A0 z =3D payload[4] << 2;
> >> +
> >> + =A0 =A0 =A0 x |=3D (payload[0] >> 5) & 0x3;
> >> + =A0 =A0 =A0 y |=3D (payload[1] >> 4) & 0x2;
> >> + =A0 =A0 =A0 z |=3D (payload[1] >> 5) & 0x2;
> >
> > Could you make the comments a bit clearer. Those last lines are imp=
ossible
> > to understand.
>=20
> The LSBs are encoded in the "BB BB" data and I am extracting them. I
> have documented the whole protocol in a separated document but if it
> is common practice to add those comments to the code, I will add it i=
n
> the next version.

In some cases, the usual way is to put a brief description of the=20
protocol/data structures mandated by hardware in the comments at the ve=
ry=20
beginning of the driver file.

The description below seems like a perfect fit for such purpose. If you=
=20
have much more elaborate description, it should probably go into=20
Documentation/.

Thanks,

--=20
Jiri Kosina
SUSE Labs
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
