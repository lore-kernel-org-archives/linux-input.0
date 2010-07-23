From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [Uclinux-dist-devel] [PATCH v3] input/misc: new ADXL345/346
 driver
Date: Thu, 22 Jul 2010 23:44:02 -0700
Message-ID: <20100723064401.GB20532@core.coreip.homeip.net>
References: <1255517680-30733-1-git-send-email-vapier@gentoo.org>
 <1256028039-15044-1-git-send-email-vapier@gentoo.org>
 <20100625071425.GA631@core.coreip.homeip.net>
 <544AC56F16B56944AEC3BD4E3D5917712E66DFEF69@LIMKCMBX1.ad.analog.com>
 <20100701075316.GA14696@core.coreip.homeip.net>
 <AANLkTikI3ps5u30x235VOtQgAN0KdMGRNotKjLYSTpCc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:34170 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750780Ab0GWGoH (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 23 Jul 2010 02:44:07 -0400
Received: by pwi5 with SMTP id 5so3378737pwi.19
        for <linux-input@vger.kernel.org>; Thu, 22 Jul 2010 23:44:07 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTikI3ps5u30x235VOtQgAN0KdMGRNotKjLYSTpCc@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mike Frysinger <vapier.adi@gmail.com>
Cc: "Hennerich, Michael" <Michael.Hennerich@analog.com>, Luotao Fu <l.fu@pengutronix.de>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "uclinux-dist-devel@blackfin.uclinux.org" <uclinux-dist-devel@blackfin.uclinux.org>, Chris Verges <chrisv@cyberswitching.com>

Hi Mike,

On Wed, Jul 21, 2010 at 09:50:12AM -0400, Mike Frysinger wrote:
> On Thu, Jul 1, 2010 at 03:53, Dmitry Torokhov wrote:
> > Input: adxl34 - make enable/disable separate from suspend/resume
>=20
> this should be "adxl34x" i think to match the style we've used in the
> past and the actual driver name
>=20
> > -void adxl34x_enable(struct adxl34x *ac)
> > +void adxl34x_resume(struct adxl34x *ac)
> > =A0{
> > =A0 =A0 =A0 =A0mutex_lock(&ac->mutex);
> > - =A0 =A0 =A0 __adxl34x_enable(ac);
> > +
> > + =A0 =A0 =A0 if (ac->suspended && !ac->disabled && ac->opened)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 __adxl34x_enable(ac);
> > +
> > + =A0 =A0 =A0 ac->suspended=3D false;
>=20
> ERROR: spaces required around that '=3D' (ctx:VxW)
> #191: FILE: drivers/input/misc/adxl34x.c:435:
> +       ac->suspended=3D false;
>=20
> > =A0}
> >
> > -EXPORT_SYMBOL_GPL(adxl34x_enable);
> > +EXPORT_SYMBOL_GPL(adxl34x_resume);
>=20
> while you're here, might want to delete the newline after the brace t=
o
> avoid the checkpatch warning:

Thanks for noticing these issues however as the original change is quit=
e
buried I opted to roll these changes into another patch.

Thanks.

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
