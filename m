From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/2] elantech: Report tool width when it is known
Date: Wed, 5 May 2010 10:12:53 -0700
Message-ID: <20100505171253.GD7337@core.coreip.homeip.net>
References: <4BE16121.8040000@tudelft.nl>
 <20100505165323.GG6075@perldition.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ww0-f46.google.com ([74.125.82.46]:54404 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751865Ab0EERNG (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 5 May 2010 13:13:06 -0400
Received: by wwb34 with SMTP id 34so20628wwb.19
        for <linux-input@vger.kernel.org>; Wed, 05 May 2010 10:13:04 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100505165323.GG6075@perldition.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Florian Ragwitz <rafl@debian.org>
Cc: =?iso-8859-1?Q?=C9ric?= Piel <E.A.B.Piel@tudelft.nl>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

On Wed, May 05, 2010 at 06:53:24PM +0200, Florian Ragwitz wrote:
> On Wed, May 05, 2010 at 02:14:25PM +0200, =C9ric Piel wrote:
> > >From observation of the values sent from the hardware version 2, i=
t
> > seems that the first four bits of byte 1 represents the width. So w=
e can
> > report it as well. Observed values on my hardware were always betwe=
en 1
> > and 12, so let's use this for min and max.
>=20
> Excellent. I'm quite happy to see this.
>=20
> I've actually thought about reporting some kind of width based on the
> "thumb" bit in the first byte. The actual width information being
> available didn't occur to me for some reason.
>=20
> The patch itself looks just fine to me, but it might also want to upd=
ate
> the elantech documentation accordingly.
>=20
> See also https://patchwork.kernel.org/patch/95448/ which isn't part o=
f
> the -input tree yet.
>=20

It is - I folded it with the changes to the driver and it is upstream. =
I
left out the new 4.1 signature patch until we know better about firmwar=
e
versions, but otherwise your changes are in mainline.

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
