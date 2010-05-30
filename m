From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [NEEDS TEST][PATCH] elantech: discard the first 2 positions
 reports for some firmwares
Date: Sun, 30 May 2010 13:12:21 -0700
Message-ID: <20100530201221.GA6069@core.coreip.homeip.net>
References: <4C02B18D.3050003@tudelft.nl>
 <1275243114.6666.50.camel@mini>
 <20100530182600.GA32416@core.coreip.homeip.net>
 <1275245732.6666.70.camel@mini>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.212.174]:63204 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753742Ab0E3UM0 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 30 May 2010 16:12:26 -0400
Received: by pxi18 with SMTP id 18so1209435pxi.19
        for <linux-input@vger.kernel.org>; Sun, 30 May 2010 13:12:26 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1275245732.6666.70.camel@mini>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Chase Douglas <chase.douglas@canonical.com>
Cc: =?iso-8859-1?Q?=C9ric?= Piel <E.A.B.Piel@tudelft.nl>, Florian Ragwitz <rafl@debian.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

On Sun, May 30, 2010 at 02:55:32PM -0400, Chase Douglas wrote:
> On Sun, 2010-05-30 at 11:26 -0700, Dmitry Torokhov wrote:
> > On Sun, May 30, 2010 at 02:11:54PM -0400, Chase Douglas wrote:
> > > On Sun, 2010-05-30 at 20:42 +0200, =C9ric Piel wrote:
> > > > According to the Dell/Ubuntu driver, what was previously observ=
ed as "jumpy cursor"
> > > > corresponds to the hardware sending incorrect data for the firs=
t two reports of a=20
> > > > one touch finger. So let's use the same workaround as in the ot=
her driver. Also,
> > > > detect another firmware version with the same behaviour, as in =
the other driver.
> > >=20
> > > I can't find this code in any of the Ubuntu released kernels. Whe=
re did
> > > you find this patch?
> >=20
> > http://zinc.ubuntu.com/git?p=3Dmid-team/hardy-netbook.git;a=3Dcommi=
tdiff;h=3Ddfc02dc860ccef79e7bce095c872548f914d96bf
> >=20
> > Woudl be nice if we did not have to hunt through random repos to fi=
nd
> > it...
>=20
> I completely agree. We are trying to consolidate our repos as much as
> possible. The Hardy release was two years ago, and we admittedly had =
too
> many repos with sources for different hardy kernels. We now have just
> one repo for each of our recent kernel releases, and probably will ha=
ve
> only one master branch even for Maverick.
>=20
> As for this patch, I still don't see it in the commit you linked to.
> There's nothing in that version of the driver that discards packets,
> checks firmware versions, or enables jumpy cursor logic.

The patch was not taken from the commit, Eric just referenced the commi=
t
as he gathered some additional information. The code in that commit is
so hideous that it would never get close to mainline as is.

>=20
> If we did apply this patch somewhere and overlooked upstreaming it, t=
hen
> that was a mistake on our part. We would also be just as concerned as
> you are, since we don't seem to carry this patch in any Ubuntu suppor=
ted
> kernels that I am aware of.
>=20
> Thanks,
>=20
> -- Chase
>=20

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
