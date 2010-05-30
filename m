From: Chase Douglas <chase.douglas@canonical.com>
Subject: Re: [NEEDS TEST][PATCH] elantech: discard the first 2 positions
 reports for some firmwares
Date: Sun, 30 May 2010 14:55:32 -0400
Message-ID: <1275245732.6666.70.camel@mini>
References: <4C02B18D.3050003@tudelft.nl> <1275243114.6666.50.camel@mini>
	 <20100530182600.GA32416@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from adelie.canonical.com ([91.189.90.139]:48072 "EHLO
	adelie.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752412Ab0E3Szi convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 30 May 2010 14:55:38 -0400
In-Reply-To: <20100530182600.GA32416@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: =?ISO-8859-1?Q?=C9ric?= Piel <E.A.B.Piel@tudelft.nl>, Florian Ragwitz <rafl@debian.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

On Sun, 2010-05-30 at 11:26 -0700, Dmitry Torokhov wrote:
> On Sun, May 30, 2010 at 02:11:54PM -0400, Chase Douglas wrote:
> > On Sun, 2010-05-30 at 20:42 +0200, =C3=89ric Piel wrote:
> > > According to the Dell/Ubuntu driver, what was previously observed=
 as "jumpy cursor"
> > > corresponds to the hardware sending incorrect data for the first =
two reports of a=20
> > > one touch finger. So let's use the same workaround as in the othe=
r driver. Also,
> > > detect another firmware version with the same behaviour, as in th=
e other driver.
> >=20
> > I can't find this code in any of the Ubuntu released kernels. Where=
 did
> > you find this patch?
>=20
> http://zinc.ubuntu.com/git?p=3Dmid-team/hardy-netbook.git;a=3Dcommitd=
iff;h=3Ddfc02dc860ccef79e7bce095c872548f914d96bf
>=20
> Woudl be nice if we did not have to hunt through random repos to find
> it...

I completely agree. We are trying to consolidate our repos as much as
possible. The Hardy release was two years ago, and we admittedly had to=
o
many repos with sources for different hardy kernels. We now have just
one repo for each of our recent kernel releases, and probably will have
only one master branch even for Maverick.

As for this patch, I still don't see it in the commit you linked to.
There's nothing in that version of the driver that discards packets,
checks firmware versions, or enables jumpy cursor logic.

If we did apply this patch somewhere and overlooked upstreaming it, the=
n
that was a mistake on our part. We would also be just as concerned as
you are, since we don't seem to carry this patch in any Ubuntu supporte=
d
kernels that I am aware of.

Thanks,

-- Chase

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
