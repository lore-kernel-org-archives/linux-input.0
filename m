From: Markus Pargmann <mpa@pengutronix.de>
Subject: Re: [PATCH v2 0/4] input: ft5x06: Fix userspace reported maximum
 value
Date: Thu, 26 Feb 2015 16:26:17 +0100
Message-ID: <20150226152617.GC10070@pengutronix.de>
References: <1415887618-29844-1-git-send-email-maxime.ripard@free-electrons.com>
 <20150223214936.GA16926@pengutronix.de>
 <20150224165508.GY25269@lukather>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="JWEK1jqKZ6MHAcjA"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150224165508.GY25269@lukather>
Sender: linux-kernel-owner@vger.kernel.org
To: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: Lothar =?utf-8?Q?Wa=C3=9Fmann?= <LW@KARO-electronics.de>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Henrik Rydberg <rydberg@euromail.se>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org


--JWEK1jqKZ6MHAcjA
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Maxime,

On Tue, Feb 24, 2015 at 05:55:08PM +0100, Maxime Ripard wrote:
> Hi Markus,
>=20
> On Mon, Feb 23, 2015 at 10:49:36PM +0100, Markus Pargmann wrote:
> > Hi,
> >=20
> > On Thu, Nov 13, 2014 at 03:06:54PM +0100, Maxime Ripard wrote:
> > > Hi,
> > >=20
> > > The current ft5x06 reports to the user-space that its maximum
> > > coordinates are, on both X and Y, way higher than what could be
> > > actually usable on the screen (in my case, 5759x1151 instead of
> > > 480x800).
> > >=20
> > > This causes trouble on some userspace stacks that then try to re-scale
> > > these coordinates back to the framebuffer resolution, like QT does.
> > >=20
> > > Use the of_touchscreen code to find the real touchscreen limits in the
> > > DT case, and report that to the userspace.
> > >=20
> > > Thanks,
> > > Maxime
> >=20
> > any news on this?
>=20
> Unfortunately, no.
>=20
> I never got any review on this, and somehow forgot about it.
>=20
> I will rebase the patches on 4.0, and resend them.

That's great, thanks. I will have some hardware next week to test it.

Best Regards,

Markus

--=20
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--JWEK1jqKZ6MHAcjA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJU7zsZAAoJEEpcgKtcEGQQVWMP/R2ZQLgLnt5Q3C+atK7O6xQ3
JI4/2AjBxRMmrsTWjtQVaFzOUEp0Jb9NsIbMRrW5wMy5p7WF4u3UPeIZZWnn5fpB
+XHAIB8YpXo9pA59sA+t6V8nCHfzrpnO5bk2uCXvx6u85ZUzyv40T3gY14vkckKB
HQytWcV0+iG5INThsE+oioV5SAw7oy6aj3cU2BxxazGwlV3NXTAUAYSzsi4F4g+z
PRlEqJibpCMV7kKcUaQwUc+UGfIFQfuI33pxDP31zN2b9rAdMZrTvDvgkWPHLNWB
vvJ1Ej9qJOGgB9MH6eD6mYT/6K87cguEa8JzsbD1huSJcDFCtEsZNletDkpaJyTp
BY2lUi4o0RTM4lp0tobphR+9Ek7Si2GEI6ZyecdZDpCvyQlNzctVsdMDF3B3A4oz
4ch62PLp+nvy+DobdDyccLFipNnL4MgIVPFYqUmD7x75TkDTv0DobjuL0A58/Pu9
wJoMtZ4cJVVDw3fTASPO+LErb6awW5x9sZlRfQCAosESL5M4MTJPJKTHzB2ODc8q
yw1U4Gdt5j8ZuCkNHqsAI6clxKNVM/QGYIcG7DdnoWQTldth87cpKjUDNH6OXGLw
GaZJ7o7lr5UXahIww9UTh3Llg9ods/b7LlPs+iD/NgLOZX8uUsfpcXszhQLQfAAO
uPeaSew9pw5CvJiKvmd1
=s0sG
-----END PGP SIGNATURE-----

--JWEK1jqKZ6MHAcjA--
