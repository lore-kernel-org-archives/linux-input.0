From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [Device-drivers-devel] [PATCH 3/3] Input: touchscreen: ad7877
 filter events where pressure is beyond the maximum
Date: Sun, 17 Oct 2010 21:08:10 -0700
Message-ID: <20101018040810.GB7782@core.coreip.homeip.net>
References: <1287139250-24777-1-git-send-email-michael.hennerich@analog.com>
 <1287139250-24777-3-git-send-email-michael.hennerich@analog.com>
 <AANLkTimg2Uv26dcU7noSGCX7SHOn2+p6-LH_q=h9NtWc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:52169 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750922Ab0JREIR (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 18 Oct 2010 00:08:17 -0400
Received: by mail-gy0-f174.google.com with SMTP id 13so155966gyg.19
        for <linux-input@vger.kernel.org>; Sun, 17 Oct 2010 21:08:17 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTimg2Uv26dcU7noSGCX7SHOn2+p6-LH_q=h9NtWc@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mike Frysinger <vapier.adi@gmail.com>
Cc: michael.hennerich@analog.com, drivers@analog.com, device-drivers-devel@blackfin.uclinux.org, linux-input@vger.kernel.org

On Fri, Oct 15, 2010 at 09:51:12PM -0400, Mike Frysinger wrote:
> On Fri, Oct 15, 2010 at 06:40,  <michael.hennerich@analog.com> wrote:
> > Suppress events where pressure > pressure_max.
> > These events come typically along with inaccurate X and Y samples.
>=20
> were you going to commit to the blackfin tree ?
>=20
> > --- a/drivers/input/touchscreen/ad7877.c
> > +++ b/drivers/input/touchscreen/ad7877.c
> > @@ -360,6 +360,13 @@ static int ad7877_rx(struct ad7877 *ts)
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Rt /=3D z1;
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Rt =3D (Rt + 2047) >> 12;
> >
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* Sample found inconsistent, press=
ure is beyond
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* the maximum. Don't report it to =
user space.
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (Rt > ts->pressure_max)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>=20
> this has spaces in the middle of your tab indents ...

I took care of that on my side...

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
