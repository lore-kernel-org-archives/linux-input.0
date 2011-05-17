From: Thierry Reding <thierry.reding@avionic-design.de>
Subject: Re: [PATCH 1/5] tsc2007: Debounce pressure measurement.
Date: Tue, 17 May 2011 08:45:11 +0200
Message-ID: <20110517064511.GB16262@avionic-0098.mockup.avionic-design.de>
References: <1305534783-4917-1-git-send-email-thierry.reding@avionic-design.de>
 <20110517060241.GC20428@core.coreip.homeip.net>
 <20110517062715.GA16262@avionic-0098.mockup.avionic-design.de>
 <20110517063247.GD20428@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BwCQnh7xodEAoBMC"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:63495 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752493Ab1EQGpX (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 17 May 2011 02:45:23 -0400
Content-Disposition: inline
In-Reply-To: <20110517063247.GD20428@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Kwangwoo Lee <kwangwoo.lee@gmail.com>


--BwCQnh7xodEAoBMC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

* Dmitry Torokhov wrote:
> On Tue, May 17, 2011 at 08:27:16AM +0200, Thierry Reding wrote:
> > [Cc'ing Kwangwoo via the alternate email address]
> >=20
> > * Dmitry Torokhov wrote:
> > > On Mon, May 16, 2011 at 10:32:59AM +0200, Thierry Reding wrote:
> > > > When the controller signals a pen-down event via the platform-speci=
fic
> > > > GPIO, while the sample values indicate an invalid measurement, the
> > > > measurement needs to be repeated.
> > > >=20
> > >=20
> > > Would not we be interrupted again and take another sample then?
> >=20
> > Not necessarily. The problem is that if the pendown GPIO reports pendow=
n, it
> > doesn't necessarily mean that the pressure measurement will be valid. T=
his is
> > especially true if max_rt is configurable (as introduced by one of the
> > follow-up patchs).
> >=20
> > What happens is that we are interrupted, check the GPIO to see that the=
 pen
> > is indeed down and then read the values and compute the pressure to see=
 that
> > it is invalid and we stop sampling. The TSC2007's nPEN_IRQ line never g=
oes
> > high again after that because the pen is still down (according to the G=
PIO).
> >=20
> > The comment in the old code of the (rt > max_rt) even says "[...] repea=
t at
> > least once more the measurement", which the old code actually doesn't.
> >=20
>=20
> I see. I am concerned with resubmitting work over and over when we do
> not have ts->get_pendown_state method.

I hadn't thought about that case. But it seems as if that case should behave
the same and stop rescheduling work as soon as no pressure is applied and rt
becomes 0.

Perhaps if I change this:

	debounced =3D true;

into

	if (ts->get_pendown_state)
		debounced =3D true;

it becomes more obvious that this "fix" only applies to the case where the
GPIO and pressure measurement contradict each other.

Thierry

--BwCQnh7xodEAoBMC
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEARECAAYFAk3SGXcACgkQZ+BJyKLjJp80WQCgpcl5ICekSldE+t4CwNJi4aus
8lUAoItWFrXf78+EDi6QWUYiThdL8jOf
=d7ut
-----END PGP SIGNATURE-----

--BwCQnh7xodEAoBMC--
