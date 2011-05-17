From: Thierry Reding <thierry.reding@avionic-design.de>
Subject: Re: [PATCH 1/5] tsc2007: Debounce pressure measurement.
Date: Tue, 17 May 2011 08:27:16 +0200
Message-ID: <20110517062715.GA16262@avionic-0098.mockup.avionic-design.de>
References: <1305534783-4917-1-git-send-email-thierry.reding@avionic-design.de>
 <20110517060241.GC20428@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LQksG6bCIzRHxTLp"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:60541 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751926Ab1EQG1T (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 17 May 2011 02:27:19 -0400
Content-Disposition: inline
In-Reply-To: <20110517060241.GC20428@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Kwangwoo Lee <kwangwoo.lee@gmail.com>


--LQksG6bCIzRHxTLp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

[Cc'ing Kwangwoo via the alternate email address]

* Dmitry Torokhov wrote:
> On Mon, May 16, 2011 at 10:32:59AM +0200, Thierry Reding wrote:
> > When the controller signals a pen-down event via the platform-specific
> > GPIO, while the sample values indicate an invalid measurement, the
> > measurement needs to be repeated.
> >=20
>=20
> Would not we be interrupted again and take another sample then?

Not necessarily. The problem is that if the pendown GPIO reports pendown, it
doesn't necessarily mean that the pressure measurement will be valid. This =
is
especially true if max_rt is configurable (as introduced by one of the
follow-up patchs).

What happens is that we are interrupted, check the GPIO to see that the pen
is indeed down and then read the values and compute the pressure to see that
it is invalid and we stop sampling. The TSC2007's nPEN_IRQ line never goes
high again after that because the pen is still down (according to the GPIO).

The comment in the old code of the (rt > max_rt) even says "[...] repeat at
least once more the measurement", which the old code actually doesn't.

Thierry

--LQksG6bCIzRHxTLp
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEARECAAYFAk3SFUMACgkQZ+BJyKLjJp9QewCfYzhtWOsQFDWPIYg6H+PKQ1rY
ovIAn1CrcB8DnHo7mO2TtUKga+kdIFh/
=PNEq
-----END PGP SIGNATURE-----

--LQksG6bCIzRHxTLp--
