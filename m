From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: Re: [PATCH v2 0/4] input: ft5x06: Fix userspace reported maximum
 value
Date: Tue, 24 Feb 2015 17:55:08 +0100
Message-ID: <20150224165508.GY25269@lukather>
References: <1415887618-29844-1-git-send-email-maxime.ripard@free-electrons.com>
 <20150223214936.GA16926@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5LZCLy8Sy7WgNZQM"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:40648 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751436AbbBXRAU (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 24 Feb 2015 12:00:20 -0500
Content-Disposition: inline
In-Reply-To: <20150223214936.GA16926@pengutronix.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Markus Pargmann <mpa@pengutronix.de>
Cc: Lothar =?iso-8859-1?Q?Wa=DFmann?= <LW@KARO-electronics.de>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Henrik Rydberg <rydberg@euromail.se>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org


--5LZCLy8Sy7WgNZQM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Markus,

On Mon, Feb 23, 2015 at 10:49:36PM +0100, Markus Pargmann wrote:
> Hi,
>=20
> On Thu, Nov 13, 2014 at 03:06:54PM +0100, Maxime Ripard wrote:
> > Hi,
> >=20
> > The current ft5x06 reports to the user-space that its maximum
> > coordinates are, on both X and Y, way higher than what could be
> > actually usable on the screen (in my case, 5759x1151 instead of
> > 480x800).
> >=20
> > This causes trouble on some userspace stacks that then try to re-scale
> > these coordinates back to the framebuffer resolution, like QT does.
> >=20
> > Use the of_touchscreen code to find the real touchscreen limits in the
> > DT case, and report that to the userspace.
> >=20
> > Thanks,
> > Maxime
>=20
> any news on this?

Unfortunately, no.

I never got any review on this, and somehow forgot about it.

I will rebase the patches on 4.0, and resend them.

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--5LZCLy8Sy7WgNZQM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJU7KzrAAoJEBx+YmzsjxAghjMP/RH+zj/CJ1FxfD/HCuR6lvYu
Fz55SzgkCmJ/pKvCddIXDBt4dfP4ErL+/3PUyKXofHm9JSIM01Xq4pdrRDAOWsJR
KjCqnPNkgXj1GA9MFDIY8u6GOyPfKyN/aSQfm9EpwsqtfoCYuYKNG0lv+JH2HGor
wv+DXjpESaF8J0IeEO92mZhBgEGcKlasF6x0TiAhqtKfmpa93jIPN2kqC8uV5Haf
vLzkpx3tQGHPJ8ovBoEGaQlsZW1Gb17sKnkTS9DSxAgmdKkvtORcAonU0us/WcZu
YkRvDgXdUAUwgfpg+BCD/ZgGCCy2etyXHGAbN90xTOwrcUgE761Gh8c1Yixo/jDN
fX97EuB2IlaDZ/DQWK7Xoq74urHIu+M+T8Y57X7rgdTnZ0HIw4d7/cG60SK9wq/q
kNn3i8t1c3JZPtFT2yPQvexk9CqMDc6iMU+Oq5Rsuaw8mIkuvJhX8fd93MoYx7Ac
MOWALyRc637rpPGWDxWaW8ScTMjb4O/s1Uuhkz++HllyC7OnQpyJReQMmvyWErkS
S7zuE5l4Y1dfl7ms6CLUBTS4kz6PdS9UOhBkn1OVuYAD5klzmZr1i1sZezLeoOu5
gv5DbxkJXUZjRZP2fau3KgqQC0eTCfaxQTFzFlg8r0dWlI8buu45q9sna17jRjwZ
SGMsh6cmVWhLTqnOPrst
=OnCI
-----END PGP SIGNATURE-----

--5LZCLy8Sy7WgNZQM--
